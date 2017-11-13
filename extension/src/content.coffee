util.source = "C"
util.onLog = (msg)->
    chrome.extension.sendRequest
        request: "log"
        message: msg
    return

util.log "content script loaded", "info"

commands =
    showusers:
        run: (arg) ->
            ($ "a").each ()->
                #util.log "found a link", "debu"
                ref = ($ this).attr "href"
                regex = /^viewprofile\.aspx\?profile_id=([0-9]+)$/g
                match = regex.exec ref
                if match == null
                    return
                util.log "found profile id: "+match[1], "info"
                return
    loaduser:
        run: (arg) ->
            window.location = "viewprofile.aspx?profile_id="+arg
    rateuser:
        run: (arg) ->
            regex = /viewprofile\.aspx/g
            match = regex.exec window.location.href
            if match == null
                util.log "this command is only tested for viewprofile.aspx pages", "erro"
                return
            description = $("#description").html()
            score = 0
            for word, weight of config.wlist_good
                regex = new RegExp word, "gi"
                pscore = 0
                match = description.match(regex)
                if match == null
                    continue
                for i in [0...match.length]
                    pscore += weight / Math.pow(2, i)
                score += pscore
            return score


chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
    util.log "want to do '"+request.command+"' with '"+request.argument+"'", "debu"
    if request.command == "showusers"
        commands.showusers.run(request.argument)
    else if request.command == "loaduser"
        commands.loaduser.run(request.argument)
    else if request.command == "rateuser"
        result = commands.rateuser.run(request.argument)
        util.log "command returned value: " + result, "data"
    return

always = () ->
    regex = /viewprofile\.aspx/g
    match = regex.exec window.location.href
    if match != null
        score = commands.rateuser.run()
        chrome.extension.sendRequest
            request: "badge"
            value: score.toString()
    else
        chrome.extension.sendRequest
            request: "badge"
            value: ""

always()

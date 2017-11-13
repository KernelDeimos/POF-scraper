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


chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
    util.log "want to do '"+request.command+"' with '"+request.argument+"'", "debu"
    if request.command == "showusers"
        commands.showusers.run(request.argument)
    else if request.command == "loaduser"
        commands.loaduser.run(request.argument)
    return

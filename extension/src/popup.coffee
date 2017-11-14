util.source = "P"
util.onLog = (msg)->
    bg = chrome.extension.getBackgroundPage()
    bg.globals.debug.push(msg)

util.log "popup activated", "debu"

globals =
    outputIsScrolled: false
    outputLastScroll: 0

sendToContentScript = (object)->
    chrome.tabs.query
        active: true
        currentWindow: true
        (tabs)->
            activeTab = tabs[0]
            chrome.tabs.sendMessage activeTab.id,
                object
            return 
    return 

copyid = (id)->
    util.log "clicked link", "debu"
    $("#inArg").val(id)

updateConsole = ()->
    if globals.outputIsScrolled
        return
    bg = chrome.extension.getBackgroundPage()
    debugMessages = bg.globals.debug
    output = $ "#debugConsole"
    output.html ""
    for msg in debugMessages
        regex = /([0-9]+)/
        msg = msg.replace /([0-9]+)/,
            "<a href=\"#\">$1</a>"
        output.html output.html()+msg+"\n"
    if !globals.outputIsScrolled
        output.scrollTop(output[0].scrollHeight)
    output.find('a').click ()->
        copyid($(this).html())
    return


run = ()->
    bg = chrome.extension.getBackgroundPage()
    if bg.globals.score != ""
        ($ "#scoretext").html("Score: "+bg.globals.score)
    btn1 = document.getElementById "button1"
    btn1.addEventListener 'click', ()->
        util.log "button press receive", "info"
        command = ($ "#inCmd").val()
        if command == "blanklines"
            for i in [0..8]
                util.log ""
        else
            sendToContentScript
                command:  command
                argument: ($ "#inArg").val()
        updateConsole()
        return
    setInterval ()->
        updateConsole()
        return
    , 200

    output = $ "#debugConsole"
    globals.outputLastScroll = output.scrollTop()
    output.on 'wheel', (event)->
        # util.log output.scrollTop() - globals.outputLastScroll
        globals.outputIsScrolled = true
        interval = setInterval ()->
            if output.scrollTop() == (output[0].scrollHeight - output[0].offsetHeight)
                globals.outputIsScrolled = false
                clearInterval(interval)
        , 200
        return
    return



window.onload = run
util.source = "C"
util.onLog = (msg)->
    chrome.extension.sendRequest
        request: "log"
        message: msg
    return

util.log "content script loaded", "info"

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
    util.log "want to do '"+request.command+"' with '"+request.argument+"'", "debu"
    if request.message == "baction_click"
        util.log "browser action was clicked", "debu"
    return

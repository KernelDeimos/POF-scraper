util.onLog = (msg)->
    chrome.extension.sendRequest
        request: "log"
        message: msg
    return

util.log "Content script loaded"

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
    if request.message == "baction_click"
        util.log "Browser action was clicked"
    return

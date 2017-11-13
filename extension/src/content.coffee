util.onLog = (msg)->
    chrome.extension.sendRequest
        request: "log"
        message: msg
    return

util.log "content script loaded", "info"

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
    if request.message == "baction_click"
        util.log "browser action was clicked", "debu"
    return

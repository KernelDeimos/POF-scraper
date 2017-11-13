globals =
    debug: []

util.onLog = (msg)->
    globals.debug.push msg

for i in [1..50]
    util.log "Background script loaded"

chrome.browserAction.onClicked.addListener (tab)->
    chrome.tabs.query
        active: true
        currentWindow: true
        (tabs)->
            activeTab = tabs[0]
            chrome.tabs.sendMessage activeTab.id,
                message: "baction_click"
            return 
    return 

chrome.extension.onRequest.addListener (request)->
    if request.request == "log"
        globals.debug.push request.message

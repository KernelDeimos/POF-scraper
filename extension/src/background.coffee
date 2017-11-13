globals =
    debug: []
    score: ""

util.source = "B"
util.onLog = (msg)->
    globals.debug.push msg

# Display startup text
globals.introtext = """
██████╗  ██████╗ ███████╗███████╗
██╔══██╗██╔═══██╗██╔════╝██╔════╝
██████╔╝██║   ██║█████╗  ███████╗
██╔═══╝ ██║   ██║██╔══╝  ╚════██║
██║     ╚██████╔╝██║     ███████║
╚═╝      ╚═════╝ ╚═╝     ╚══════╝
                                 
 ██████╗     ██████╗     ██████╗ 
██╔═████╗   ██╔═████╗   ██╔═████╗
██║██╔██║   ██║██╔██║   ██║██╔██║
████╔╝██║   ████╔╝██║   ████╔╝██║
╚██████╔╝██╗╚██████╔╝██╗╚██████╔╝
 ╚═════╝ ╚═╝ ╚═════╝ ╚═╝ ╚═════╝ 
"""

util.log globals.introtext

util.log "background script started", "info"

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
    else if request.request == "badge"
        globals.score = request.value
        chrome.browserAction.setBadgeText
            text: request.value

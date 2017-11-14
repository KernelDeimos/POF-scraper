globals =
    debug: []
    score: ""
    users: {}

util.source = "B"
util.onLog = (msg)->
    globals.debug.push msg

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

initializeUser = (userID) ->
    globals.users[userID] =
        userid: userID
        checked: false
        score: 0

chrome.extension.onRequest.addListener (request)->
    if request.request == "log"
        globals.debug.push request.message
    else if request.request == "badge"
        globals.score = request.value
        chrome.browserAction.setBadgeText
            text: request.value
    else if request.request == "addusers"
        for user in request.users
            if !(user of globals.users)
                initializeUser user
        util.log "current user store contains "+
            Object.keys(globals.users).length+" items", "debu"
    else if request.request == "setscore"
        if !(request.user of globals.users)
            initializeUser request.user
        globals.users[request.user].score = request.score
        globals.users[request.user].checked = true
    else if request.request == "crawl"
        util.log "background received crawl command", "debu"
    else if request.request == "all"
        for id, user of globals.users
            if user.checked
                util.log ""+user.userid+" "+user.score, "data"
    return

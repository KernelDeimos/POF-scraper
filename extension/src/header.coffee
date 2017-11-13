util =
    name: "POFS 0.0.0"
    onLog: (msg)->
    log: (msg, level)->
        if level != undefined
            console.log "["+util.name+"] ["+level+"] "+msg
            util.onLog "["+level+"] "+msg
        else
            console.log "["+util.name+"] "+msg
            util.onLog msg

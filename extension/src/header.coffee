util =
    name: "POFS 0.0.0"
    onLog: (msg)->
    log: (msg)->
        console.log "["+util.name+"]"+" "+msg
        util.onLog msg

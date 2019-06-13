(// compilar este archivo después de Synths/Synths.scd
var defaultBuf = Prand([\OPEN_HIHAT2, \OPEN_HIHAT1, \CLOSED_HIHAT1, \OPEN_HIHAT2].collect(~drum), inf);
~durPlayer = {|durs, buf = (defaultBuf), midi = ([60, 65])|
    Pdef(\durPlayer,
        Pbind(
            \instrument, \samplePlay,
            \buf, buf,
            \dur, Pseq(durs, inf)
        )
    )
}
)

// ~durPlayer.([2, [2, [2, [0.4, 3]], 1, [2, [1,1,2,0.1]]]].convertRhythm).play
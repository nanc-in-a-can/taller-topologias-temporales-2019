(
~durPlayer = {|durs, instrument = \default, midi = ([60])|
    Pdef(\durPlayer,
        Pbind(
            \instrument, instrument,
            \midi, Pseq(midi, inf),
            \dur, Pseq(durs, inf)
        )
    )
}
)

// ~durPlayer.([2, [2, [2, [0.4, 3]], 1, [2, [1,1,2,0.1]]]].convertRhythm).play
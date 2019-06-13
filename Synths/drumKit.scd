(
//make durmkit as synthdefs
var instruments = [
    [\OPEN_HIHAT1, ~drumKit[0].bufnum],
    [\OPEN_HIHAT2, ~drumKit[1].bufnum],
    [\VIBRASLAP, ~drumKit[2].bufnum],
    [\MARACAS, ~drumKit[3].bufnum],
    [\CABASA, ~drumKit[4].bufnum],
    [\SHORT_WHISTLE, ~drumKit[5].bufnum],
    [\SHORT_WHISTLE2, ~drumKit[6].bufnum],
    [\LOW_BONGO, ~drumKit[7].bufnum],
    [\SHORT_GUIRO, ~drumKit[8].bufnum],
    [\BASS_DRUM, ~drumKit[9].bufnum],
    [\HI_BONGO, ~drumKit[10].bufnum],
    [\HAND_CLAP, ~drumKit[11].query.bufnum],
    [\RIDE_CYMBAL1, ~drumKit[12].bufnum],
    [\ACOUSTIC_SNARE, ~drumKit[13].bufnum],
    [\MUTE_HI_CONGA, ~drumKit[14].bufnum],
    [\LONG_GUIRO, ~drumKit[15].bufnum],
    [\CLOSED_HIHAT1, ~drumKit[16].bufnum],
    [\CLOSED_HIHAT2, ~drumKit[17].bufnum],
    [\TAMBOURINE, ~drumKit[18].bufnum],
    [\TAMBOURINE_HIPitch1, ~drumKit[19].bufnum],
    [\TAMBOURINE_HIPitch2, ~drumKit[20].bufnum],
    [\LOW_WOOD_BLOCK, ~drumKit[21].bufnum],
    [\PEDAL_HIHAT, ~drumKit[22].bufnum],
    [\LOW_AGOGO, ~drumKit[23].bufnum],
    [\HIGH_AGOGO, ~drumKit[24].bufnum],
    [\BASS_DRUM2, ~drumKit[25].bufnum]
];

instruments.do({|instrument|
    var buf = instrument[1];
    SynthDef(instrument[0],
        {| out = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15 |
            var sig,env;
            sig = Mix.ar(PlayBuf.ar(2,buf,
                rate,1,
                BufDur.kr(buf)*pos*44100,        doneAction:2));
            env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
            sig = sig * env;
            sig = sig * amp;
            Out.ar(out,Pan2.ar(sig,pan));
    }).add;
});
)






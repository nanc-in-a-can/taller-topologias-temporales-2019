(
[
    [\addPartialsOdd01_17, ~waveTables[0].bufnum],
    [\addSaw2plus5, ~waveTables[1].bufnum],
    [\addSine01_07, ~waveTables[2].bufnum],
    [\addSine01_16, ~waveTables[3].bufnum],
    [\addSine01_32, ~waveTables[4].bufnum],
    [\addSineOdd01_17, ~waveTables[5].bufnum],
].do({|wave|
    var bufnum = wave[1];
    SynthDef(wave[0], {
        |freq=60,  // pitch
        endOffset=2, durOffset=1, // timbre
        att=0.01, rel=0.1, gate=1, // time
        out=0, amp=0.5| // bus and intensity

        var sig, env, offset, buf;

        offset = Line.kr(0, endOffset, durOffset);
        buf = bufnum;
        sig = VOsc3.ar(buf+offset, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.333333)*amp;
        env = EnvGen.ar(Env.asr(att, 1, rel, -2),gate, doneAction:2);

        Out.ar(out, sig*env);
    }).add;
})
)

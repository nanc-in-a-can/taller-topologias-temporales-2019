//Synths
// necessary server conditions
s.options.numBuffers = 1024 * 16;
s.boot;

( // execute here to compile every function and synthdef

//load wavetable catalogue;
var path = thisProcess.nowExecutingPath.dirname;
var wavsCatalogue = path;
var drumKit = path++"/drumKits/IAMM_Kits";

~waveTables = SoundFile.collectIntoBuffers(wavsCatalogue++"/wavetable/*",s);
~drumKit = SoundFile.collectIntoBuffers(drumKit++"/Kit_1/*",s);


(
SynthDef(\wavetable, {
	|freq=60,  // pitch
	wave=0, endOffset=2, durOffset=1, // timbre
	att=0.01, rel=0.1, gate=1, // time
	out=0, amp=0.5| // bus and intensity

	var sig, env, offset, buf;

	offset = Line.kr(0, endOffset, durOffset);
	buf = wave;
	sig = VOsc3.ar(buf+offset, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.333333)*amp;
	env = EnvGen.ar(Env.asr(att, 1, rel, -2),gate, doneAction:2);

	Out.ar(out, sig*env);
}).add;
);

(
~chooseWaveTable = {|nameOfWave|
	switch(nameOfWave,
		\addPartialsOdd01_17, {~waveTables[0].bufnum},
		\addSaw2plus5, {~waveTables[1].bufnum},
		\addSine01_07, {~waveTables[2].bufnum},
		\addSine01_16, {~waveTables[3].bufnum},
		\addSine01_32, {~waveTables[4].bufnum},
		\addSineOdd01_17, {~waveTables[5].bufnum},

				{0})

}
);

( // from coï¿¥ï¾¡pt SynthDef library
SynthDef(\samplePlay,
	{| out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15 |
		var sig,env;
		sig = Mix.ar(PlayBuf.ar(2,buf,
			rate,1,
			BufDur.kr(buf)*pos*44100,        doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);
(
~drum = {|nameOfWave|
	switch(nameOfWave,
		\OPEN_HIHAT1, {~drumKit[0].bufnum},
		\OPEN_HIHAT2, {~drumKit[1].bufnum},
		\VIBRASLAP, {~drumKit[2].bufnum},
		\MARACAS, {~drumKit[3].bufnum},
		\CABASA, {~drumKit[4].bufnum},
		\SHORT_WHISTLE, {~drumKit[5].bufnum},
		\SHORT_WHISTLE2, {~drumKit[6].bufnum},
		\LOW_BONGO, {~drumKit[7].bufnum},
		\SHORT_GUIRO, {~drumKit[8].bufnum},
		\BASS_DRUM, {~drumKit[9].bufnum},
		\HI_BONGO, {~drumKit[10].bufnum},
		\HAND_CLAP, {~drumKit[11].query.bufnum},
		\RIDE_CYMBAL1, {~drumKit[12].bufnum},
		\ACOUSTIC_SNARE, {~drumKit[13].bufnum},
		\MUTE_HI_CONGA, {~drumKit[14].bufnum},
		\LONG_GUIRO, {~drumKit[15].bufnum},
		\CLOSED_HIHAT1, {~drumKit[16].bufnum},
		\CLOSED_HIHAT2, {~drumKit[17].bufnum},
		\TAMBOURINE, {~drumKit[18].bufnum},
		\TAMBOURINE_HIPitch1, {~drumKit[19].bufnum},
		\TAMBOURINE_HIPitch2, {~drumKit[20].bufnum},
		\LOW_WOOD_BLOCK, {~drumKit[21].bufnum},
		\PEDAL_HIHAT, {~drumKit[22].bufnum},
		\LOW_AGOGO, {~drumKit[23].bufnum},
		\HIGH_AGOGO, {~drumKit[24].bufnum},
		\BASS_DRUM2, {~drumKit[25].bufnum},
				{nil})

}
);
);
// example of how this works:

(
Pdef(\mySynthMachine,
	Pbind(
	\instrument, \wavetable, \wave, ~chooseWaveTable.(\addSine01_07),
	\freq, Pseq([60,67,48].midicps,inf),
	\dur, 0.2, \rel, Pkey(\dur)*0.5),
	\amp,1
)
);

// Pdef(\mySynthMachine).play

(
Pdef(\mySampleMachine,
	Pbind(
		\dur, 0.1,
		\instrument, \samplePlay,
		\buf, Prand(
			[
				~drum.(\OPEN_HIHAT2),
				~drum.(\OPEN_HIHAT1),
				~drum.(\CLOSED_HIHAT1),
				~drum.(\OPEN_HIHAT2)

			]
			,inf),
		\amp, 0.5,
		\rate, 1
	)
)
);

// Pdef(\mySampleMachine).play







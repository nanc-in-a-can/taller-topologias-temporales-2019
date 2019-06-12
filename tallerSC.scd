(
Server.default.options.memSize= 512000*20;
Server.default.options.numWireBufs= 512;
s = Server.local;
s.options.numBuffers = 1024 * 16;
s.boot;
);


// ¿qué son los ritmos euclidianos?

// provienen del algoritmo del mismo nombre, se utilizan para descubrir el divisor común de dos números enteros, en otras palabras este algoritmo genera patrones de distribución de la manera más uniforme posible con números enteros. Bjorklund utiliza una secuencia binaria para producir distribuciones de números lo más parejas posibles. A partir de este, se pueden conceptualizar los ritmos emblemáticos de la música subsahariana africana y otros bastante difundidos en distintas culturas musicales alrededor del mundo.

~patt1Onsets= Bjorklund(3,8);
~patt1Durs= Bjorklund2(3,8);


// dichos patrones se pueden arreglar entre sí de manera polimétrica compartiendo un mismo pulso subyaciente. Es decir la distancia entre k es la misma aunque el arreglo de n cambie. Si k es distinto entre cada patron entonces se crearán ciclos de convergencia entre patrones (k1 * k2 por ejemplo);

(
~toXO = {|onsets|
	onsets.collect({|item, iter| if(item==1, {"x"}, {"o"})  })

}
)


(
Pbind(
	\instrument, \samplePlay, \buf, Pseq([~drum.(\BASS_DRUM2)],inf),
	\amp, Pseq(Bjorklund(3,8),inf), \dur, 0.3).play;
Pbind(
	\instrument, \samplePlay, \buf, Pseq([~drum.(\CABASA)],inf),
	\amp, Pseq(Bjorklund(7,12),inf), \dur, 0.15).play;
Pbind(
	\instrument, \samplePlay, \buf, Pseq([~drum.(\OPEN_HIHAT1)],inf),
	\amp, Pseq(Bjorklund(5,8),inf), \dur, 0.3).play;
);

// Concierto para bongó de Perez Prado  //  ¿¿¿ ritmos euclidianos ???

// la clave es un ritmo euclidiano????

// k?    n?     (escuchemos)


~claveMasomenos= Bjorklund(5,16);

// si cambiamos un valor queda
~clave= ~claveMasomenos.swap(9,10)

// en realidad la clave cubana es:

~clave= Bjorklund(3,8) ++ [0,0, 1,0, 1,0, 0,0];

// ¿qué explicación hay de esto?

(
//

a =
FluentCan(\canBjorklund1)
.notes([80])
.durs((1!~clave.size))
.period(2.5)
.tempos([1])
.transps([0])
.cp(4)
.instruments([\samplePlay])
.meta((pbind: [buf: ~drum.(\MARACAS)]))
.apply(IsoFluent.xo(~toXO.(~clave)))
.repeat(inf)
.play
)








// concierto de bongoes
// tema principal


~tema= Bjorklund(5,8).rotate(2); // quintillo cubano rotado
~tema= ~tema ++ Bjorklund(5,8);  // quintillo sin rotación
~tema= ~tema ++ Bjorklund(5,8).rotate(2)++[1]++(0!7);
// consecuente de la frase con un break de silencio en la ultima parte;

(
//
a =
FluentCan(\canBjorklund2)
.notes([67,60])
.durs((1!~tema.size))
.period(5)
.tempos([1])
.transps([0])
.cp(12)
.apply(IsoFluent.xo(~toXO.(~tema)))
.instruments([\samplePlay])
.meta((pbind: [buf: ~drum.(\TAMBOURINE_HIPitch2)]))
.repeat(inf)
.play
)

// el primer solo presenta en sus primeros 30 segundos variaciones utilizando como generador el patron bjorklund (3,8);

~solo= Bjorklund(3,8);
//
~solo= ~solo.stutter(2); // repeating 2

~final= ~tema.rotate((~tema.size/2).asInteger).copyRange(0,15);

~analisis= ((~tema!2).flatten++(~solo!3).flatten++(~final).flatten).flat


(
//
a =
FluentCan(\canBjorklund3)
.notes([67,60])
.durs((1!~analisis.size))
.period(20)
.tempos([1])
.transps([0])
.cp(12)
.apply(IsoFluent.xo(~toXO.(~analisis)))
.instruments([\samplePlay])
.meta((pbind: [buf: ~drum.(\TAMBOURINE_HIPitch2)]))
.repeat(inf)
.play
)



// sin embargo el comienzo del solo es aún más interesante;
// 1 == bongo agudo, 0 == bongo grave
(
Pbind(\instrument, \samplePlayer,
	\dur, 0.15, \amp, 1, \bjork, Pseq(~solo,inf),
	\drum,Pfunc{|event|  if( event[\bjork]==1, {\OPEN_HIHAT2}, {\CLOSED_HIHAT1})}
).trace.play;
);



// ritmo armónico

(
//
~notes= 100*(1..16); // proporciones que serán expresadas como ritmo y como alturas
~notes= [60,60,67,67,67,72,72,72,72].midicps;   // en notas midi
a =
FluentCan(\can2)
.notes(~notes.cpsmidi+12)
.durs(~notes.reciprocal)
.amps([1,1,1])
.period(5)
.tempos([1])
.transps([0])
.cp(4)
.apply(IsoFluent.xo("x"))
.instruments([\wavetable])
.meta((pbind: [wave:~chooseWaveTable.(\addSine01_07)]))
.repeat(inf)
.play
)


(
//
// compases de denominador complejo

// duracion total 6. 6 dividido en 3 partes iguales, primer parte dividida en 3 partes [1,1,1], segunda parte dividido en 4 partes [1,1,1,1] última parte dividida en 5 partes donde el último quinto esta subdividido en 3 partes iguales.
// primer paso
[4, [2,2]].convertRhythm
[4, [1,1,1,1]].convertRhythm

~compases=
[6, [
	[2,[1,1,1]],
	[2,[1,1,1,1]],
	[2,[1,1,1,1,
		[1, [1,1,1]]]]    ] ].convertRhythm;


FluentCan(\can2)
.notes([60,62,64,65,67,69,71,72,74,75.3,77.5,79,80,82,84])
.durs(~compases)
.amps([1,1,1])
.period(4)
.tempos([1])
.transps([0])
.cp(4)
.apply(IsoFluent.xo("x"))
.instruments([\wavetable])
.meta((pbind: [wave:~chooseWaveTable.(\addSine01_07)]))
.repeat(inf)
.play
)





// Tick to Processing 1


~netAddr= NetAddr("127.0.0.1", 12000);
~netAddr.sendMsg("/tick", [1,2,3].choose.asString);


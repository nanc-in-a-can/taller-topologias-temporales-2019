

(
s.options.numBuffers = 1024 * 16;
s.waitForBoot({
    ~path = thisProcess.nowExecutingPath.dirname;
    [
        "/Synths/Synths.scd",
        "/Synths/durPlayer.scd",
        "/Synths/drumKit.scd"
    ].collect(~path++_).do(_.load);
})
)
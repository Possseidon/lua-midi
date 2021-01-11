-- Load the library.
local midi = require "midi"

-- Get a stream e.g. by opening a file with io.open().
-- Make sure to open in binary mode "rb".
local file = assert(io.open("resources/short-tune.mid", "rb"))

-- Call midi.process() with a callback function.
-- The callback is invoked for each midi event (see output below).
local tracks = midi.process(file, print)

print("Loaded " .. tracks .. " midi tracks!")

-- Be nice and close the file (although this script ends here anyway).
file:close()

--[[ Output:

header  1       2       480
track   1
sequencerOrTrackName    Piano
timeSignature   4       4       24      8
keySignature    0       C       major
setTempo        150.0
modeMessage     1       121     0
program 1       0
controller      1       7       100
controller      1       10      64
controller      1       91      0
controller      1       93      0
noteOn  1       64      80
noteOn  1       71      80
deltatime       227
noteOn  1       64      0
noteOn  1       71      0
deltatime       13
noteOn  1       64      80
deltatime       227
noteOn  1       64      0
deltatime       13
noteOn  1       67      80
deltatime       227
noteOn  1       67      0
deltatime       13
noteOn  1       71      80
deltatime       227
noteOn  1       71      0
deltatime       13
noteOn  1       69      80
noteOn  1       74      80
deltatime       227
noteOn  1       69      0
noteOn  1       74      0
deltatime       13
noteOn  1       71      80
deltatime       227
noteOn  1       71      0
deltatime       13
noteOn  1       74      80
deltatime       227
noteOn  1       74      0
deltatime       13
noteOn  1       67      80
noteOn  1       76      80
deltatime       227
noteOn  1       67      0
noteOn  1       76      0
deltatime       1
endOfTrack
track   2
sequencerOrTrackName    Piano
keySignature    0       C       major
noteOn  1       48      80
noteOn  1       52      80
deltatime       911
noteOn  1       48      0
noteOn  1       52      0
deltatime       49
noteOn  1       50      80
noteOn  1       57      80
deltatime       683
noteOn  1       50      0
noteOn  1       57      0
deltatime       37
noteOn  1       52      80
noteOn  1       55      80
noteOn  1       59      80
deltatime       227
noteOn  1       52      0
noteOn  1       55      0
noteOn  1       59      0
deltatime       1
endOfTrack
Loaded 2 midi tracks!

]]

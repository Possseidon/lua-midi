local midi = require "midi"

-- Processing the different midi events can be achieved in various ways.
-- However building a dispatch table is likely not a bad choice.
local handlers = {}

-- Listen for the start of new tracks:
function handlers.track(track)
  print("Track " .. track)
end

-- Listen for played notes:
function handlers.noteOn(channel, key, velocity)
  -- Fairly often "noteOn" with a velocity of zero is used instead of "noteOff".
  if velocity > 0 then
    print(("Note with key %i and velocity %.2f on channel %i"):format(key, velocity, channel))
  end
  -- Sometimes even "noteOff" have a non-zero velocity.
  -- If you need to be super safe, use the same handler for both events.
end

-- Listen for timing events:
function handlers.deltatime(ticks)
  print("Pause ".. ticks)
end

-- Now we can build a callback that dispatches its arguments to the correct handler:
local function callback(name, ...)
  -- Get the correct handler...
  local handler = handlers[name]
  -- and forward the arguments to it, if it exists.
  if handler then
    handler(...)
  end
end

local file = assert(io.open("resources/short-tune.mid", "rb"))
midi.process(file, callback)

-- The double pauses in the output below are a result of ignoring "noteOff" events.

--[[ Output:

Track 1
Note with key 64 and velocity 0.63 on channel 1
Note with key 71 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 64 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 67 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 71 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 69 and velocity 0.63 on channel 1
Note with key 74 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 71 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 74 and velocity 0.63 on channel 1
Pause 227
Pause 13
Note with key 67 and velocity 0.63 on channel 1
Note with key 76 and velocity 0.63 on channel 1
Pause 227
Pause 1
Track 2
Note with key 48 and velocity 0.63 on channel 1
Note with key 52 and velocity 0.63 on channel 1
Pause 911
Pause 49
Note with key 50 and velocity 0.63 on channel 1
Note with key 57 and velocity 0.63 on channel 1
Pause 683
Pause 37
Note with key 52 and velocity 0.63 on channel 1
Note with key 55 and velocity 0.63 on channel 1
Note with key 59 and velocity 0.63 on channel 1
Pause 227
Pause 1

]]

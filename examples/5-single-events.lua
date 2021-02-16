local midi = require "midi"

-- Instead of reading a whole track, it is also possible to read single midi events.
-- A stream is still required however, which makes this example a bit more complicated.

-- We build up a dummy stream with a position and some midi data.
local stream = {
  pos = 1,
  data = "\x90\x50\x7F\x80\x50\x7F"
}

-- And we give it a read method, to read some bytes and advance the position.
function stream:read(count)
  local result = self.data:sub(self.pos, self.pos + count - 1)
  self.pos = self.pos + count
  return result
end

-- Now this dummy stream can be processed twice
midi.processEvent(stream, print) --> noteOn   1  80  1.0
midi.processEvent(stream, print) --> noteOff  1  80  1.0

-- An optional third parameter for the running status can be provided.
-- The function returns:
-- 1. The total number of bytes it had to read for the event.
-- 2. The updated running status.

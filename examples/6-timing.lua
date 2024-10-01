local midi = require "midi"

local file = assert(io.open("resources/short-tune.mid", "rb"))

local totalTicks = 0
local totalSeconds = 0

local division    -- set in the midi header
local tempo = 120 -- 120 BPM is the default tempo for midi files
print("Initial Tempo:", tempo)

local function process(event, ...)
  if event == "header" then
    local format, tracks, div = ...
    division = div
    print("Division:", division)
  elseif event == "deltatime" then
    local ticks = ...
    totalTicks = totalTicks + ticks
    totalSeconds = totalSeconds + ticks / division / tempo * 60
  elseif event == "setTempo" then
    tempo = ...
    print("Tempo Change:", tempo, "at " .. totalSeconds .. " seconds")
  end
end

midi.processTrack(file, process, 1) -- only process the first track
file:close()

-- It might make sense to process all tracks and use the maximum time
-- Although I think most programs pad all tracks to that maximum anyway

print("Total Ticks:", totalTicks)     --> Total Ticks:   1908
print("Total Seconds:", totalSeconds) --> Total Seconds: 1.59

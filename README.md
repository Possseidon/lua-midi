# lua-midi

A pure Lua implementation to read midi files using a callback function.

## Usage

The library allows not only reading all tracks in a midi file at once, but also reading only the header (e.g. to a find out the track count) and then reading a single, specific midi track.

Reading all tracks in a midi file:

```lua
local midi = require "midi"

local file = assert(io.open("short-tune.mid"))
midi.process(file, print)

file:close()
```

Reading only the last track in a midi file:

```lua
local midi = require "midi"

local file = assert(io.open("short-tune.mid"))
local tracks = midi.processHeader(file) -- find number of tracks

file:seek("set") -- seek back to the beginning of the file
midi.processTrack(file, print, tracks)

file:close()
```

---

## Library

The library consists of a single Lua file, namely [midi.lua](lib/midi.lua).

### Reading full midi files

The following functions require a stream of a real midi file and use a callback to report individual midi events:

```lua
function midi.process(stream, callback, onlyHeader, onlyTrack)
function midi.processHeader(stream, callback)
function midi.processTrack(stream, callback, track)
```

All functions return the total number of tracks in the midi file.

| Parameter    | Description                                                                                           |              |
| ------------ | ----------------------------------------------------------------------------------------------------- | ------------ |
| `stream`     | A stream (e.g. `file*`) that points to the start of a midi file.                                      | **required** |
| `callback`   | A callback function which is invoked for all midi events.                                             | *optional*   |
| `onlyHeader` | When set to `true`, only the header chunk will be processed.                                          | *optional*   |
| `onlyTrack`  | When set to any integer, only the header chunk and track with this one-based index will be processed. | *optional*   |
| `track`      | Same as `onlyTrack` but required.                                                                     | **required** |

### Reading single midi events

The following function simply reads a single midi event (excluding the usually preceeding delta-time) from the given stream:

```lua
function midi.processEvent(stream, callback, runningStatus)
```

It returns how many bytes it had to read from the stream, followed by the updated runningStatus.

| Parameter       | Description                                              |              |
| --------------- | -------------------------------------------------------- | ------------ |
| `stream`        | A stream (e.g. `file*`) that points to a midi event.     | **required** |
| `callback`      | A callback function which is invoked for the midi event. | **required** |
| `runningStatus` | The running status of a previous midi event.             | *optional*   |

---

## Examples

### [1-read-full-midi.lua](examples/1-read-full-midi.lua)

Prints all midi events in the given midi file.

### [2-read-single-track.lua](examples/2-read-single-track.lua)

Prints only the midi events of a single track in the midi file.

### [3-dispatch-table.lua](examples/3-dispatch-table.lua)

Handles only specific midi events using a dispatch table.

### [4-event-signatures.lua](examples/4-event-signatures.lua)

Lists the signatures, on how the callback is invoked, for each midi event.

### [5-single-events.lua](examples/5-single-events.lua)

Shows how to read single events from a stream.

### [6-timing.lua](examples/6-timing.lua)

Calculates the total length of a midi file in seconds.

Also outlines how to convert midi ticks to seconds in general.

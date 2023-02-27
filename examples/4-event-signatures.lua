-- There are a lot of different midi events with varying parameters.
-- All events with their respective function signatures can be found here.
-- Further information about the Midi Specification can be found here:
-- https://www.music.mcgill.ca/~ich/classes/mumt306/StandardMIDIfileformat.html

local handlers = {}

---- Utility Events
-- These events aren't quote on quote "Midi Events", but still useful/necessary.

---Advances the song forward in time by a certain number of ticks.
---@param ticks integer Always positive, never zero.
function handlers.deltatime(ticks) end

---Provides information found in the midi header.
---@param format integer The midi format used: 0 - single track; 1 - simultaneous tracks; 2 - independent tracks
---@param tracks integer Number of tracks. Also returned from any of the midi.process() functions for convenience.
---@param division integer The number of ticks per quater note (unless the most significant, 16th bit is set, see below).
---See [2.1 - Header Chunks](https://www.music.mcgill.ca/~ich/classes/mumt306/StandardMIDIfileformat.html#BM2_1) for more information.
---The actual time per tick also depends on the current tempo.
function handlers.header(format, tracks, division) end

---Signifies the start of a new midi track.
---@param track integer The index of the track, starting at one.
function handlers.track(track) end

---Called when a chunk with a type that is neither `MThd` nor `MTrk` was found.
---@param chunkType string The 4-character magic bytes of the unknown chunk.
---@param data string All of the data contained in the chunk as a binary string.
function handlers.unknownChunk(chunkType, data) end

---An unknown status byte has been ignored.
---@param status integer The status byte that was ignored.
function handlers.ignore(status) end

---- Midi Events
-- Events that operate on a single channel.

-- TODO: Midi Event Signatures

function handlers.noteOff(channel, key, velocity) end
function handlers.noteOn(channel, key, velocity) end
function handlers.keyPressure(channel, key, pressure) end
function handlers.controller(channel, number, value) end
function handlers.modeMessage(channel, number, value) end
function handlers.program(channel, program) end
function handlers.channelPressure(channel, pressure) end
function handlers.pitch(channel, pitch) end

---- Meta Events
-- Events containing meta info that is not specific to any channel.

-- TODO: Meta Event Signatures

function handlers.sequenceNumber() end
function handlers.text() end
function handlers.copyright() end
function handlers.sequencerOrTrackName() end
function handlers.instrumentName() end
function handlers.lyric() end
function handlers.marker() end
function handlers.cuePoint() end
function handlers.channelPrefix() end
function handlers.endOfTrack() end
function handlers.setTempo() end
function handlers.smpteOffset() end
function handlers.timeSignature() end
function handlers.keySignature() end
function handlers.sequenceEvent() end

---- SysEx Event
-- Manufacturer specific events.

-- TODO: SysEx Event Signature

function handlers.sysexEvent() end

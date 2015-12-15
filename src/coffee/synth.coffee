Utils = require('./utils')

class Synth
    constructor: ->
        @volumeLevel = 0.5
        @stopped = true
        @quantize = false

        contextClass = (window.AudioContext or
            window.webkitAudioContext or 
            window.mozAudioContext or 
            window.oAudioContext or
            window.msAudioContext)

        try
            @context = new contextClass()
        catch
            alert("No Context Class")

        @osc = @context.createOscillator();
        @vol = @context.createGain();

        @vol.gain.value = 0.0; # from 0 to 1, 1 full volume, 0 is muted
        @osc.connect(@vol); # connect @osc to @vol
        @vol.connect(@context.destination); # connect vol to @context distination
        @osc.start(@context.currentTime + 1) # start it 1 seconds from now

    start: ->
        @stopped = false
        @vol.gain.value = @volumeLevel

    stop: ->
        @stopped = true
        @vol.gain.value = 0

    setVolume: (vol_) ->
        console.log "setting volume: " + vol_
        @volumeLevel = vol_

        if not @stopped
            @start()

    setFrequency: (freq_) ->
        if @quantize
            note = Utils.findClosestNote(freq_)
            freq_ = note.note_freq
            model.setCurrNote(note.note_name)

        @osc.frequency.value = freq_

module.exports = Synth
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
        @osc.type = 'triangle'

        @vol = @context.createGain();
        @vol.gain.value = 0.0; # from 0 to 1, 1 full volume, 0 is muted

        @delay = @context.createDelay();
        @delay.delayTime.value = 0.5;
        @delay.delayTime.value = 0.5;

        @feedback = @context.createGain();
        @feedback.gain.value = 0.4;

        @filter = @context.createBiquadFilter();
        @filter.frequency.value = 1000;

        @delay.connect(@feedback);
        @feedback.connect(@filter);
        @filter.connect(@delay);

        @osc.connect(@vol); # connect @osc to @vol
        @vol.connect(@delay);
        @delay.connect(@context.destination);

        @vol.connect(@context.destination); # connect vol to @context distination
        @osc.start(@context.currentTime + 1) # start it 1 seconds from now

    start: ->
        @stopped = false
        @vol.gain.value = @volumeLevel
        @feedback.gain.value = @volumeLevel
        console.log "setting volume and feedback: " + @vol.gain.value + ':' + @feedback.gain.value

    stop: ->
        @stopped = true
        @vol.gain.value = 0

    createDelay: ->

        # @osc.connect(@context.destination);
        # @delay.connect(@context.destination);


    setWaveType: (wave) ->
        @osc.type = wave

    setVolume: (vol_) ->
        console.log "setting volume: " + vol_
        @volumeLevel = vol_

        if not @stopped
            @start()

    setFrequency: (freq_) ->
        @osc.frequency.value = freq_

module.exports = Synth
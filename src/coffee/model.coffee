EventEmitter = require('events').EventEmitter # used to tell UI when to update
Resources = require('./resources')
Synth = require('./synth')

class Model extends EventEmitter
    constructor: () ->
        #empty
        @curr_view = Resources.SYNTH_VIEW
        @synth = null # initialized in starting dialog, must be inited by user touch
        @curr_note = "A4"

    setCurrNote: (note_name) ->
        @curr_note = note_name
        @emit 'change'


    getCurrView: () ->
        return @curr_view

    setCurrView: (view_name) ->
        @curr_view = view_name

module.exports = Model
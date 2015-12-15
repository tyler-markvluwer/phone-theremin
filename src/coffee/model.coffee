EventEmitter = require('events').EventEmitter # used to tell UI when to update
Resources = require('./resources')
Synth = require('./synth')

class Model extends EventEmitter
    constructor: () ->
        #empty
        @curr_view = Resources.SYNTH_VIEW

    getCurrView: () ->
        return @curr_view

    setCurrView: (view_name) ->
        @curr_view = view_name

module.exports = Model
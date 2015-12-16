React = require('react')
Resources = require('./resources')
MotionControlView = require('./motionControlView')
Synth = require('./synth')
Utils = require('./utils')

Mui = require('material-ui')
{MenuItem, LeftNav, Snackbar, IconButton, AppBar, RaisedButton, Slider} = require('material-ui')

List = require('material-ui/lib/lists/list')
ListItem = require('material-ui/lib/lists/list-item')
Colors = require('material-ui/lib/styles/colors')
NavigationClose = require('material-ui/lib/svg-icons/navigation/close')
MoreVertIcon = require('material-ui/lib/svg-icons/navigation/more-vert')
AddCircle = require('material-ui/lib/svg-icons/content/add')

synthView = React.createClass    
    #################################
    #       React Functions
    #################################
    componentDidMount: ->
        # @props.model.on 'change', @update

    update: ->
        @forceUpdate()

    getInitialState: ->
        {
            quantize: false
            curr_note: 'N/A'
            startStopButtonText: 'Start Synth'
        }

    _synthOnTouchTapCallback: ->
        if model.synth.stopped
            model.synth.start()
            @setState({startStopButtonText: "Stop Synth"})
        else
            model.synth.stop()
            @setState({startStopButtonText: "Start Synth"})

    setVolume: (event, vol_) ->
        model.synth.setVolume(vol_)

    setFrequencySlider: (event, freq_) ->
        freq_ = Utils.scale(0, 1, Resources.FREQ_MIN, Resources.FREQ_MAX, freq_)
        @setFrequency(freq_)

    setFrequency: (freq_) ->
        if model.synth.quantize
            note = Utils.findClosestNote(freq_)
            freq_ = note.note_freq
            @setState(curr_note: note.note_name)

        model.synth.setFrequency(freq_)

    _toggleQuantize: () ->
        if model.synth.quantize
            model.synth.quantize = false
        else
            model.synth.quantize = true

        @setState({quantize: model.synth.quantize})

    _mouseUpCallback: () ->
        model.synth.quantize = false
        console.log "mouse is up"


    render: ->
        PlusButton = (<IconButton onClick={console.log('hi')}><AddCircle /></IconButton>)

        <div>
            <AppBar
                title='Phone Theremin'
                iconElementRight={PlusButton}
                onLeftIconButtonTouchTap={@props.toggleLeft}
            />
            <br></br>
            <div className='container'>
                <div className='row'>
                    <div className='col-sm-3'>
                        <RaisedButton
                            label={@state.startStopButtonText}
                            onTouchTap={@_synthOnTouchTapCallback}
                        />
                    </div>
                </div>
                <div className='row'>
                    <h4 className='span12' style={textAlign: 'center'}>
                        {'Quantize: ' + @state.quantize}
                    </h4>
                    <h4 className='span12' style={textAlign: 'center'}>
                        {'Current Note: ' + @state.curr_note}
                    </h4>
                </div>
                <div className='row'>
                    <MotionControlView model={@props.model} setFreq={@setFrequency}/>
                </div>
                <br></br>
                <div className='row'>
                    <div className='col-sm-2'></div>
                    <div className='col-sm-8'>
                        <Slider
                            name='volume-slider'
                            description='Volume'
                            onChange={@setVolume}
                            defaultValue={0.5}
                        />
                    </div>
                    <div className='col-sm-2'></div>
                </div>
                <div className='row'>
                    <div className='col-sm-2'></div>
                    <div className='col-sm-8'>
                        <Slider
                            name='pitch-slider'
                            description='Pitch'
                            onChange={@setFrequencySlider}
                            defaultValue={0.5}
                        />
                    </div>
                    <div className='col-sm-2'></div>
                </div>
                <div className='row'>
                    <RaisedButton
                        label='Pitch Quantize'
                        onTouchTap={@_toggleQuantize}
                        style={width: '100%'}
                    />
                </div>
                <br></br>
            </div>
        </div>

module.exports = synthView
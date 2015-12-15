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
        @props.model.on 'change', @update

    update: ->
        @forceUpdate()

    getInitialState: ->
        {
            quantize: false
        }

    startSynth: ->
        model.synth.start()

    stopSynth: ->
        model.synth.stop()

    setVolume: (event, vol_) ->
        model.synth.setVolume(vol_)

    setFrequency: (event, freq_) ->
        newFreq = Utils.scale(0, 1, Resources.FREQ_MIN, Resources.FREQ_MAX, freq_)
        model.synth.setFrequency(newFreq)

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
                            label='Start Synth'
                            onTouchTap={@startSynth}
                        />
                    </div>

                    <div className='col-sm-3'>
                        <RaisedButton
                            label='Stop Synth'
                            onTouchTap={@stopSynth}
                        />
                    </div>
                </div>
                <div className='row'>
                    <h2 className='span12' style={textAlign: 'center'}>
                        {'Quantize: ' + @state.quantize}
                    </h2>
                    <h2 className='span12' style={textAlign: 'center'}>
                        {'Current Note: ' + model.curr_note}
                    </h2>
                </div>
                <br></br>
                <div className='row'>
                    <MotionControlView model={@props.model} />
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
                            onChange={@setFrequency}
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
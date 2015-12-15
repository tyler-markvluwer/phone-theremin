React = require('react')
Resources = require('./resources')
Utils = require('./utils')

Mui = require('material-ui')
{MenuItem, LeftNav, Snackbar, IconButton, AppBar, RaisedButton, Slider} = require('material-ui')

List = require('material-ui/lib/lists/list')
ListItem = require('material-ui/lib/lists/list-item')
Colors = require('material-ui/lib/styles/colors')
NavigationClose = require('material-ui/lib/svg-icons/navigation/close')
MoreVertIcon = require('material-ui/lib/svg-icons/navigation/more-vert')
AddCircle = require('material-ui/lib/svg-icons/content/add')

round = (val) ->
    amt = 10
    return Math.round(val * amt) /  amt

motionControlView = React.createClass    
    #################################
    #       React Functions
    #################################
    componentDidMount: ->
        # @props.model.on 'change', @update
        # @init()

    update: ->
        @forceUpdate()

    getInitialState: -> {
        leftRightVal: 0.0
        frontBackVal: 0.0
        zVal: 0.0
        handled_last_time: false
    }

    init: ->
        if @deviceSupportsMotion
            window.addEventListener('devicemotion', @deviceMotionHandler, false)
        else
            document.getElementById("dmEvent").innerHTML = "Not supported on your device or browser.  Sorry."

    deviceSupportsMotion: ->
        return window.DeviceMotionEvent or 'listenForDeviceMovement' in window

    updateSynthValues: ->
        console.log "updating synth values"

        scaledVol = Utils.scale(0, 20, 0, 1, @state.frontBackVal)
        model.synth.setVolume(scaledVol)

        scaledFreq = Utils.scale(0, 20, Resources.FREQ_MIN, Resources.FREQ_MAX, @state.leftRightVal)
        @props.setFreq(scaledFreq)

    deviceMotionHandler: (eventData) ->
        # Only handle motion every other time
        if @state.handled_last_time
            @state.handled_last_time = false
            return
        else
           @state.handled_last_time = true 

        info = "[X, Y, Z]"
        xyz = "[X, Y, Z]"

        # Grab the acceleration including gravity from the results
        acceleration = eventData.accelerationIncludingGravity;

        if model.motion_flip
            @setState {leftRightVal: round(acceleration.x + Resources.SENSOR_OFFSET)}
            @setState {frontBackVal: round(acceleration.y + Resources.SENSOR_OFFSET)}

        else
            @setState {leftRightVal: round(Resources.SENSOR_OFFSET - acceleration.x)}
            @setState {frontBackVal: round(Resources.SENSOR_OFFSET - acceleration.y)}

        @setState {zVal: round(acceleration.z)}

        info = eventData.interval;
        document.getElementById("moInterval").innerHTML = info;
        @updateSynthValues()


    render: ->
        <div className='container'>
            <div className='row'>
                <RaisedButton
                    label='Start Motion Tracking'
                    onTouchTap={@init}
                />
            </div>
            <br></br>
            <div className='row'>
                <span>accelerationIncludingGravity: </span>
                <span id="moAccelGrav">
                    {'[' + @state.leftRightVal + ', ' + @state.frontBackVal + ', ' + @state.zVal + ']'}
                </span>
            </div>
            <div className='row'>
                <span>interval: </span><span id="moInterval"></span>
            </div>

        </div>

module.exports = motionControlView
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

        scaledVol = Utils.scale(0, 20, 0, 1, @state.leftRightVal)
        model.synth.setVolume(scaledVol)

        scaledFreq = Utils.scale(0, 20, Resources.FREQ_MIN, Resources.FREQ_MAX, @state.frontBackVal)
        model.synth.setFrequency(scaledFreq)

    deviceMotionHandler: (eventData) ->
        info = "[X, Y, Z]"
        xyz = "[X, Y, Z]"
        
        # Grab the acceleration including gravity from the results
        # acceleration = eventData.acceleration
        # info = xyz.replace("X", round(acceleration.x))
        # info = info.replace("Y", round(acceleration.y))
        # info = info.replace("Z", round(acceleration.z))
        # document.getElementById("moAccel").innerHTML = info;

        # Grab the acceleration including gravity from the results
        acceleration = eventData.accelerationIncludingGravity;

        @setState {leftRightVal: round(acceleration.x + Resources.SENSOR_OFFSET)}
        # info = xyz.replace("X", @leftRightVal);

        @setState {frontBackVal: round(acceleration.y + Resources.SENSOR_OFFSET)}
        # info = info.replace("Y", @frontBackVal);

        @setState {zVal: round(acceleration.z)}
        # info = info.replace("Z", round(acceleration.z));
        # document.getElementById("moAccelGrav").innerHTML = info;

        # Grab the acceleration including gravity from the results
        # rotation = eventData.rotationRate;
        # info = xyz.replace("X", round(rotation.alpha));
        # info = info.replace("Y", round(rotation.beta));
        # info = info.replace("Z", round(rotation.gamma));
        # document.getElementById("moRotation").innerHTML = info;

        info = eventData.interval;
        document.getElementById("moInterval").innerHTML = info;
        @updateSynthValues()


    render: ->
        <div className='container' >
            <RaisedButton
                label='Start Motion Tracking'
                onTouchTap={@init}
            />
            <div className='row'>
                 <span>Event Supported: </span><span id="dmEvent"></span>
            </div>
            <div className='row'>
                <span>acceleration: </span><span id="moAccel"></span>
            </div>
            <div className='row'>
                <span>accelerationIncludingGravity: </span>
                <span id="moAccelGrav">
                    {'[' + @state.leftRightVal + ', ' + @state.frontBackVal + ', ' + @state.zVal + ']'}
                </span>
            </div>
            <div className='row'>
            </div>
            <div className='row'>
                <span>interval: </span><span id="moInterval"></span>
            </div>

        </div>

module.exports = motionControlView
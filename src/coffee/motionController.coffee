
round = (val) ->
    amt = 10
    return Math.round(val * amt) /  amt

class MotionController
	constructor: ->
        if @deviceSupportsMotion
            window.addEventListener('devicemotion', @deviceMotionHandler, false)
        else
            alert("Not supported on your device or browser.  Sorry.")

        @leftRightVal = 0.0
        @frontBackVal = 0.0

	deviceSupportsMotion: ->
        return window.DeviceMotionEvent or 'listenForDeviceMovement' in window

    deviceMotionHandler: (eventData) ->
        console.log 'eventData'
        console.log eventData

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
        info = xyz.replace("X", round(acceleration.x));
        @leftRightVal = round(acceleration.x)
        info = info.replace("Y", round(acceleration.y));
        @frontBackVal = round(acceleration.y)
        info = info.replace("Z", round(acceleration.z));
        document.getElementById("moAccelGrav").innerHTML = info;

        # Grab the acceleration including gravity from the results
        # rotation = eventData.rotationRate;
        # info = xyz.replace("X", round(rotation.alpha));
        # info = info.replace("Y", round(rotation.beta));
        # info = info.replace("Z", round(rotation.gamma));
        # document.getElementById("moRotation").innerHTML = info;

        info = eventData.interval;
        document.getElementById("moInterval").innerHTML = info;
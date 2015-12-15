React = require('react')
#key1 = require('./key1') # TODO put this back in!
#key2 = require('./key2') # TODO put this back in!

# import the Model class
Model = require('./model')

# Parse.initialize(key1, key2);

# (consider using a singleton pattern)
model = new Model()

# needed for material ui
injectTapEventPlugin = require("react-tap-event-plugin")
injectTapEventPlugin();

Render = require('react-dom').render
AppView = require('./appView')

# make model global for instructional purposes
window.model = model

Render(
	AppView # which component to mount
        model: model
    document.getElementById('app-view-mount') # where to mount it
)

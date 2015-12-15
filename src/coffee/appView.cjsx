React = require('react')
Resources = require('./resources')
SynthView = require('./synthView')
AboutView = require('./aboutView')
Synth = require('./synth')

Mui = require('material-ui')
{MenuItem, LeftNav, Dialog} = require('material-ui')

List = require('material-ui/lib/lists/list')
ListItem = require('material-ui/lib/lists/list-item')
Colors = require('material-ui/lib/styles/colors')
NavigationClose = require('material-ui/lib/svg-icons/navigation/close')
MoreVertIcon = require('material-ui/lib/svg-icons/navigation/more-vert')

appView = React.createClass    
    #################################
    #       React Functions
    #################################
    componentDidMount: ->
        @props.model.on 'change', @update

    update: ->
        @forceUpdate()

    toggleLeft: ->
        @refs.leftNav.toggle()

    constructSynth: ->
        model.synth = new Synth()
        @refs.welcomeDialog.dismiss()

    menuOnChange: (event, index, menuItem) ->
        switch index
            when 0 then @props.model.setCurrView(Resources.SYNTH_VIEW)
            when 1 then @props.model.setCurrView(Resources.ABOUT_VIEW)
            when 3 then @props.model.toggleMotionFlip()
            else alert("error, unknown index in leftNav")

    render: ->
        menuItems = [
            { route: 'customization', text: 'Synth'},
            { route: 'get-started', text: 'About'},
            { type: MenuItem.Types.SUBHEADER, text: 'Meta' },
            { route: '', text: 'Flip Rotation'},
            { type: MenuItem.Types.SUBHEADER, text: 'Meta' },
            {
                linkButtton: true
                # type: MenuItem.Types.LINK,
                text: 'View Code',
                href: 'www.google.com',
            },
        ]
        standardActions = [
              { text: "Let's get rockin!", onTouchTap: @constructSynth, ref: 'submit' }
            ];

        <div className='app-div' id='awesome-441-app-div'>
            {switch @props.model.getCurrView()
                when Resources.SYNTH_VIEW
                    <SynthView
                        model={@props.model}
                        toggleLeft={@toggleLeft}
                    />
                when Resources.ABOUT_VIEW
                    <AboutView
                        model={@props.model}
                        toggleLeft={@toggleLeft}
                    />
                else alert("error, unknown current view")
            }

            <Dialog
                ref='welcomeDialog'
                title="Welcome to the Mobile Theremin!"
                actions={standardActions}
                actionFocus="submit"
                defaultOpen={true}
                modal={true}
            >
                Just tilt your phone and you're ready to go!
            </Dialog>
            <LeftNav ref="leftNav" docked={false} menuItems={menuItems} onChange={@menuOnChange} disableSwipeToOpen={true} />
        </div>

module.exports = React.createFactory(appView)


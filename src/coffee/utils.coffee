class Utils
	constructor: ->
		# empty

	scale: (OldMin, OldMax, NewMin, NewMax, OldValue) ->
		OldRange = (OldMax - OldMin)  
		NewRange = (NewMax - NewMin)  
		NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

		return NewValue

module.exports = new Utils()
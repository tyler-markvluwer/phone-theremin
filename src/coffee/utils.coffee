Resources = require('./resources')

class Utils
	constructor: ->
		# empty

	scale: (OldMin, OldMax, NewMin, NewMax, OldValue) ->
		OldRange = (OldMax - OldMin)  
		NewRange = (NewMax - NewMin)  
		NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

		return NewValue

	findClosestNote: (freq_) ->
		closestDiff = 999999.00
		closestNote = null
		for note in Resources.NOTE_LIST
			diff = Math.abs(freq_ - note.note_freq)
			if diff < closestDiff
				closestNote = note
				closestDiff = diff

		console.log closestNote
		return closestNote

module.exports = new Utils()
Resources = require('./resources')

class Utils
	constructor: ->
		# empty

	scale: (OldMin, OldMax, NewMin, NewMax, OldValue) ->
		OldRange = (OldMax - OldMin)  
		NewRange = (NewMax - NewMin)  
		NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

		return NewValue

	findClosestNoteOld: (freq_) ->
		closestDiff = 999999.00
		closestNote = null
		for note in Resources.NOTE_LIST
			diff = Math.abs(freq_ - note.note_freq)
			if diff < closestDiff
				closestNote = note
				closestDiff = diff

		console.log closestNote
		return closestNote

	findClosestNote: (freq_) ->
	    mid = null
	    lo = 0;
	    hi = Resources.NOTE_LIST.length - 1
	    console.log hi + " " + lo
	    while (hi - lo > 1)
	        mid = Math.floor ((lo + hi) / 2)
	        if Resources.NOTE_LIST[mid].note_freq < freq_
	            lo = mid
	        else
	            hi = mid

	    if (freq_ - Resources.NOTE_LIST[lo].note_freq <= Resources.NOTE_LIST[hi].note_freq - freq_)
	        return Resources.NOTE_LIST[lo]

	    return Resources.NOTE_LIST[hi]

module.exports = new Utils()
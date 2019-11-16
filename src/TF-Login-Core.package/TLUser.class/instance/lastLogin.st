accessing
lastLogin
	^ lastLogin ifNil: [ DateAndTime epoch ]
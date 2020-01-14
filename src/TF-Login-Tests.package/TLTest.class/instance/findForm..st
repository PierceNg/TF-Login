testing support
findForm: aString
	^ (Soup fromString: aString) findTag: 'form'


testing support
clickOn: anId in: content with: valuesById

	| form names url args |

	form := self findForm: content.
	url := self actionUrlFor: form.
	names := self controlsById: form.
	args := Dictionary new.
	
	valuesById keysAndValuesDo: [ :k :v |
		args at: (names at: k) put: v ].
	args at: (names at: anId) put: ''.
	^ (client url: url; formAddAll: args; post)
	

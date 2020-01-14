testing support
baseUrl
	^ self useZincServer
		ifTrue: [
			'http://localhost:', self server port asString ]
		ifFalse: [
			'http://localhost:', self port asString ]
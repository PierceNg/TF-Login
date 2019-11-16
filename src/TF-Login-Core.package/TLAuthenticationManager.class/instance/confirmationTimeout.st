accessing
confirmationTimeout
	confirmationTimeout isNil ifTrue: [ confirmationTimeout := self defaultConfirmationTimeout ].
	^ confirmationTimeout
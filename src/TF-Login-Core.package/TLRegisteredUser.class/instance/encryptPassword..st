accessing
encryptPassword: aPassword
	| cryptClass |
	
	cryptClass := (self passwordCrypt isSymbol)
		ifTrue: [ self class environment at: self passwordCrypt ]
		ifFalse: [ self passwordCrypt ].
	^ cryptClass new crypt: aPassword
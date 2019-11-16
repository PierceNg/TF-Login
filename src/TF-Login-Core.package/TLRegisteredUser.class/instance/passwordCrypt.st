accessing
passwordCrypt

	^ passwordCrypt ifNil: [ 
		encpswd 
			ifNil: [ passwordCrypt := self defaultPasswordCrypt ]
			ifNotNil: [ passwordCrypt := encpswd algoClass ]]
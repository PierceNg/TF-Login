accessing
verifyPassword: aPassword
	| currHash newHash |
	
	currHash := self encryptedPassword.

	newHash := (self class environment at: currHash algoClass) new
		iterations: currHash iterations;
		outputSize: currHash passwordHashSize;
		crypt: aPassword salt: currHash salt.
	
	^ currHash passwordHash = newHash passwordHash
process
crypt: aPassword salt: aSalt
	| hash |
	
	hash := PBKDF2 new
		hashFunction: SHA1;
		password: aPassword;
		salt: aSalt;
		iterations: self iterations;
		length: self outputSize;
		deriveKey.
	
	^ TLPasswordHash new
		algoClass: self class name
		iterations: self iterations
		salt: aSalt
		passwordHash: hash
		passwordHashSize: self outputSize
instance creation
username: uname encpswd: pswd email: em
	^ (self basicNew)
		initialize;
		username: uname;
		encryptedPassword: pswd;
		email: em;
		yourself 
instance creation
username: uname password: pswd email: em
	^ (self basicNew)
		initialize;
		username: uname;
		password: pswd;
		email: em;
		yourself 
instance creation
username: user email: em lastLogin: ll lastLoginFrom: llf loginCount: lc

	"This method should only be invoked by the unit tests."

	^ (self basicNew)
		initialize;
		username: user;
		email: em;
		lastLogin: ll;
		lastLoginFrom: llf;
		loginCount: lc; 
		yourself
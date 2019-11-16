instance creation
username: user userId: id email: em lastLogin: ll lastLoginFrom: llf loginCount: lc applicationProperties: aDictionary

	"This method should only be invoked by the RegisteredUsers class."

	^ (self basicNew)
		initialize;
		username: user;
		userId: id;
		email: em;
		lastLogin: ll;
		lastLoginFrom: llf;
		loginCount: lc; 
		applicationProperties: aDictionary;
		yourself
API / CRUD
addPendingRegistrationUser: user password: pswd email: em regId: regId
	
	| pendingUser |
	pendingUser := TLPendingUser
				username: user
				password: pswd
				email: em
				regId: regId
				confirmationDeadline: (self deadlineSecs: self confirmationTimeout).
	
	Lock critical: [self pendingActions
		at: regId
		put: pendingUser].
		
	^pendingUser 
	
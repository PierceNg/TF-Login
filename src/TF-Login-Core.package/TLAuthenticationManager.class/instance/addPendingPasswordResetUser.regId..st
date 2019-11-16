API / CRUD
addPendingPasswordResetUser: user regId: regId
	| pendingPasswordReset |
	
	pendingPasswordReset := TLPendingPasswordReset 
				username: user username
				regId: regId
				confirmationDeadline: (self deadlineSecs: self confirmationTimeout).
	
	Lock critical: [self pendingActions 
		at: regId
		put: pendingPasswordReset].
		
	^pendingPasswordReset
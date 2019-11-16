API / CRUD
confirmAccountChange: regid 
	
	| oldUser newUser pendingChanges|
	self removeExpiredPendingActions.
	Lock critical: [pendingChanges := self pendingActions at: regid ifAbsent: [ ^false ]].
	oldUser := self userForId: pendingChanges  userId.
	newUser := oldUser copy.
	newUser isNil ifFalse: [
		newUser
			email: pendingChanges email;
			username: pendingChanges username;
			encryptedPassword: pendingChanges encryptedPassword;
			applicationProperties: pendingChanges applicationProperties.
		self updateUser: newUser].
	
	Lock critical: [ self pendingActions removeKey: regid ].
	^ true 
	
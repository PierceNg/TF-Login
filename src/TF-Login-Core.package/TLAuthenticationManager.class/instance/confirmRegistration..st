API / CRUD
confirmRegistration: regid
	| user |
	self removeExpiredPendingActions.
	Lock critical: [
		user := self pendingActions at: regid ifAbsent: [ ^false ].
		self pendingActions removeKey: regid ].
	self addUser: user.
	^ true 
	
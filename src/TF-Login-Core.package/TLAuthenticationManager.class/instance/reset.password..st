API / CRUD
reset: regId password: pswd
	| oldUser newUser |
	
	self removeExpiredPendingActions.
	
	oldUser := self userForUsername: (self pendingActions at: regId) username.
	newUser := oldUser copy; password: pswd.
	
	self loginComponent authenticationManager updateUser: newUser.
	
	self pendingActions removeKey: regId.
	^ true 
	
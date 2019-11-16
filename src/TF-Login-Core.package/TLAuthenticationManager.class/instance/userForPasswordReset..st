API / CRUD
userForPasswordReset: regid
	| retval |
	self removeExpiredPendingActions.
	Lock critical: [ retval := self pendingActions removeKey: regid ifAbsent: [ nil ]].
	^ retval
	
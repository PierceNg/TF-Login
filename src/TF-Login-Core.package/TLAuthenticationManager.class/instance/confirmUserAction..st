API / CRUD
confirmUserAction: regid
	| action |
	self removeExpiredPendingActions.
	Lock critical: [
		action := self pendingActions at: regid ifAbsent: [ ^false ].
		self pendingActions removeKey: regid ].
	action confirmBlock value: action.
	^ true 
	
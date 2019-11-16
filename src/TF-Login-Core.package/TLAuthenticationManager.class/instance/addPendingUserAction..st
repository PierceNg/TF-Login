API / CRUD
addPendingUserAction: aPendingUserAction
	aPendingUserAction confirmationDeadline: (self deadlineSecs: self confirmationTimeout).
	Lock critical: [self pendingActions 
		at: aPendingUserAction regId
		put: aPendingUserAction ].

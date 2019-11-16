API / CRUD
removeExpiredPendingActions

	Lock critical: [
		self pendingActions: (self pendingActions select: [ :v | v isValid ])]

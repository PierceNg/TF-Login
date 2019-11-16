API / CRUD
deleteUser: aUser
	(self pendingActions values select:  [ :u | u userId = aUser userId ])
		do: [ :u | self pendingActions removeKey: u regId].
	self storageAdaptor deleteUser: aUser
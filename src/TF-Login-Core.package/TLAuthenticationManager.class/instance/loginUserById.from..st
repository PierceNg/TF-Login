API / CRUD
loginUserById: userId from: hostAddress
	| reguser |
	reguser := self storageAdaptor userForId: userId .
	reguser isNil
		ifFalse: [
			reguser
				lastLogin: DateAndTime now;
				lastLoginFrom: hostAddress;
				incrementLoginCount.
			self saveUser: reguser.
		
			^ TLUser
				username: (reguser username)
				userId: (reguser userId)
				email: (reguser email)
				lastLogin: (reguser lastLogin)
				lastLoginFrom: (reguser lastLoginFrom)
				loginCount: (reguser loginCount)
				applicationProperties: (reguser applicationProperties)]
			
		ifTrue: [ ^nil ]
	 
API / CRUD
loginUser: user encryptedPassword: pswd from: hostAddress
	| reguser |
	reguser := self getUser: user encryptedPassword: pswd ifAbsent: [ nil ].
	reguser isNil
		ifFalse: [
			reguser
				lastLogin: DateAndTime now;
				lastLoginFrom: hostAddress;
				incrementLoginCount.
			self saveUser: reguser.
		
			^ TLUser
				username: user
				userId: (reguser userId)
				email: (reguser email)
				lastLogin: (reguser lastLogin)
				lastLoginFrom: (reguser lastLoginFrom)
				loginCount: (reguser loginCount)
				applicationProperties: (reguser applicationProperties)]
			
		ifTrue: [ ^nil ]
	 
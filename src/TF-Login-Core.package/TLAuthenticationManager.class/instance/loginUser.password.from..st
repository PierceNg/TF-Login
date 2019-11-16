API / CRUD
loginUser: username password: pswd from: hostAddress
	| reguser |
	reguser := self getUser: username password: pswd ifAbsent: [ nil ].
	reguser isNil ifTrue: [ reguser := self getUser: username encryptedPassword: pswd ifAbsent: [ nil ]].
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
	 
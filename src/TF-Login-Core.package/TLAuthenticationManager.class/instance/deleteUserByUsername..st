API / CRUD
deleteUserByUsername: aUsername
	| reguser |
	reguser := self userForUsername: aUsername.
	reguser isNil ifFalse: [ self deleteUser: reguser ].

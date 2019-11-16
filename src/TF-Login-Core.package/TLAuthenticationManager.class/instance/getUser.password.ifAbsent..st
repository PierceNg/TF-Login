API / CRUD
getUser: aUsername password: pswd ifAbsent: aBlock

	| user |
	user := self storageAdaptor userForUsername: aUsername.
	user ifNotNil: [ :u |
		(user verifyPassword: pswd) ifFalse: [ user := nil ]].
	user isNil ifTrue: [ ^ aBlock value ].
	^user

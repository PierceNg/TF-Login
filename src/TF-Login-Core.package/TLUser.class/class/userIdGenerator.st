accessing
userIdGenerator
	^ userIdGenerator ifNil: [ self defaultUserIdGenerator ]
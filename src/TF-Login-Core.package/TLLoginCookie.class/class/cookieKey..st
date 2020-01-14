accessing
cookieKey: userId
	^ (SHA1 hashMessage: userId) hex
accessing
cookieItemHashed: aString
	^ (SHA1 hashMessage: aString) hex
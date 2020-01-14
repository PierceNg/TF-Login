testing
isValid: clientSideKV

	^ (self cookieKey = clientSideKV key) 
		& (self cookieValue = (self class cookieItemHashed: clientSideKV value))
		& (self isExpired not)
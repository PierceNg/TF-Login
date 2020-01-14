running
testClientSideContentOkExpired
	| clientSent |
	
	cookie expiryDate: DateAndTime yesterday.
	clientSent := '0a1b2c3d4e::5f6g7h8i9j'.
	self deny: (cookie isValid: (TLLoginCookie clientSentKeyValue: clientSent))

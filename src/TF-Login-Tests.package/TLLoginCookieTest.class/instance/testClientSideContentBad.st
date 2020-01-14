running
testClientSideContentBad
	| clientSent |
	
	cookie expiryDate: DateAndTime tomorrow.
	clientSent := '0a1b2c3d4e::5f6g'.
	self deny: (cookie isValid: (TLLoginCookie clientSentKeyValue: clientSent))

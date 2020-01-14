running
testClientSideContentOk
	| clientSent |
	
	cookie expiryDate: DateAndTime tomorrow.
	clientSent := '0a1b2c3d4e::5f6g7h8i9j'.
	self assert: (cookie isValid: clientSent)

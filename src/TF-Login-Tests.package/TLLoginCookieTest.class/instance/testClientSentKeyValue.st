running
testClientSentKeyValue
	| clientSent assoc |
	
	clientSent := '0a1b2c3d4e::5f6g7h8i9j'.
	assoc := TLLoginCookie clientSentKeyValue: clientSent.
	self assert: assoc key equals: '0a1b2c3d4e'.
	self assert: assoc value equals: '5f6g7h8i9j'.
	

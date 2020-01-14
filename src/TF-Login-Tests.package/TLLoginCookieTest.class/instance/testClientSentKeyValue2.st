running
testClientSentKeyValue2
	| clientSent assoc |
	
	clientSent := 'e::5'.
	assoc := TLLoginCookie clientSentKeyValue: clientSent.
	self assert: assoc key equals: 'e'.
	self assert: assoc value equals: '5'.
	

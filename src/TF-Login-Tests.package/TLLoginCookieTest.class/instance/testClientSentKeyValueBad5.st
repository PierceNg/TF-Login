running
testClientSentKeyValueBad5
	| clientSent |
	
	clientSent := '??'.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

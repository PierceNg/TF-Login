running
testClientSentKeyValueBad4
	| clientSent |
	
	clientSent := ':'.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

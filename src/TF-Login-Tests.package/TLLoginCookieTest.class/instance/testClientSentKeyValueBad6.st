running
testClientSentKeyValueBad6
	| clientSent |
	
	clientSent := ''.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

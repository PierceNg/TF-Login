running
testClientSentKeyValueBad3
	| clientSent |
	
	clientSent := '::'.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

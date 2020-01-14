running
testClientSentKeyValueBad
	| clientSent |
	
	clientSent := '::5'.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

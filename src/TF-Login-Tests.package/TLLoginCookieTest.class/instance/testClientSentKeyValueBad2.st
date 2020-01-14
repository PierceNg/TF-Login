running
testClientSentKeyValueBad2
	| clientSent |
	
	clientSent := 'e::'.
	self should: [ TLLoginCookie clientSentKeyValue: clientSent ] raise: TLLoginCookieError
	

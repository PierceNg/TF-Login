accessing
clientSentKeyValue: clientSideContent
	| sepdex |
	
	sepdex := clientSideContent findString: self clientSideSeparator startingAt: 1.
	(sepdex > 1)
		ifFalse: [ 
			(TLLoginCookieError new clientSideContent: clientSideContent) signal: 'Invalid client-sent cookie' ]
		ifTrue: [ 
			(clientSideContent size >= (sepdex + 2))
				ifFalse: [
					(TLLoginCookieError new clientSideContent: clientSideContent) signal: 'Invalid client-sent cookie' ]
				ifTrue: [
					^ Association 
						key: (clientSideContent copyFrom: 1 to: sepdex - 1)
						value: (clientSideContent copyFrom: sepdex + 2 to: clientSideContent size) ]]
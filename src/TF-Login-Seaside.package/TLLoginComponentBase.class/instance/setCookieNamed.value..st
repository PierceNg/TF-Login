cookies
setCookieNamed: aName value: aValue 

	| host |
	host := self session requestContext request host.
	(host indexOf: $:) >= 0
		ifTrue: [ host := host copyUpTo: $: ].

	self requestContext response
		addCookie: (self requestContext newCookie
			key: aName;
			httpOnly: true;
			domain: host;
			value: aValue)
			"expireIn: self usernamePasswordRememberDays days)"
			

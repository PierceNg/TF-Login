cookies
setLoginCookie

	self automaticLogin
		ifTrue: [
			| scookie |
			scookie := self makeLoginCookie: user.
			user addLoginCookie: scookie.
			self saveUser: user.
			self setCookieNamed: self loginCookieName  value: scookie clientSideContent. ]
		ifFalse: [
			self deleteCookieNamed: self loginCookieName ]
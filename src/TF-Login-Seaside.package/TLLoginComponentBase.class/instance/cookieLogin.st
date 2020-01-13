cookies
cookieLogin
	| scookie |
	
	accountChangeConfirmed ifNotNil: [ :bool | ^ false ].
	
	scookie := self session requestContext request cookieAt: self loginCookieName.
	scookie ifNil: [ ^ false ].
	
	user := self authenticationManager loginUserByCookie: scookie from: self session requestContext request remoteAddress.	
	user isNil
		ifTrue: [ ^ false ]
		ifFalse: [
			authenticationError := nil.
			"XXX Refresh the cookie's expiry date?"
			self session user: user.
			self answer: user ]
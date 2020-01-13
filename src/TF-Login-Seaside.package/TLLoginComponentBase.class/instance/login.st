login-logout
login

	username isNil ifTrue: [ ^ self ].
	user := self authenticationManager
		loginUser: username
		password: pswd
		from: self session requestContext request remoteAddress.
	user isNil
		ifTrue: [ authenticationError := true.
			self loginDisallowed: (self onLoginFailBlock
				value: username
				value:  self session requestContext request remoteAddress)]
		ifFalse: [
			(self loginDisallowed: (self onLoginBlock value: user)) isNil
				ifTrue: [
					authenticationError := nil.
					self session user: user.
					self setLoginCookie.
					self answer: user ]]
login-logout
automaticLogin
	^ automaticLogin ifNil: [ ^ self allowAutomaticLogin ]
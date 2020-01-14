as yet unclassified
updateFromUser: aUser
	self username: aUser username.
	self lastLogin:aUser lastLogin.
	self lastLoginFrom: aUser lastLoginFrom.
	self loginCount: aUser loginCount.
	self email: aUser email.
	self applicationProperties: aUser applicationProperties deepCopy.
	self loginCookies: aUser loginCookies.
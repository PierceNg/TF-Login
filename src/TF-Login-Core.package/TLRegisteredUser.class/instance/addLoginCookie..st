accessing
addLoginCookie: aCookie

	self deleteExpiredLoginCookies.
	self loginCookies add: aCookie
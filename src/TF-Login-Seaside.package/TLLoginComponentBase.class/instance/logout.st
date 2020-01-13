login-logout
logout
	self clearLoginCookie.
	self saveUser.
	self session user: nil
	
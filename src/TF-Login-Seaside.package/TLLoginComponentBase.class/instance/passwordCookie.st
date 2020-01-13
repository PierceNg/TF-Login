login-logout
passwordCookie
	Error signal: 'This code breaks security. #FixMe'
	"Answer the content of the password cookie or nil."
	"^ self session requestContext request cookieAt: (self appName, '-002')."

cookies
clearLoginCookie: session
	| scookie |

	scookie := session requestContext request cookieAt: self loginCookieName.
	scookie ifNotNil: [ :cookie |
		session requestContext response deleteCookie: cookie ].

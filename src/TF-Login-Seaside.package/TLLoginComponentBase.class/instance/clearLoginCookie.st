cookies
clearLoginCookie
	| scookie |

	scookie := self session requestContext request cookieAt: self loginCookieName.
	scookie ifNotNil: [ :cookie | self session requestContext response deleteCookie: cookie ].

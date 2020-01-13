cookies
deleteCookieNamed: aName
	| cookie |
	
	cookie := self session requestContext request cookieAt: aName.
	cookie ifNotNil: [ self session requestContext response deleteCookie: cookie ].

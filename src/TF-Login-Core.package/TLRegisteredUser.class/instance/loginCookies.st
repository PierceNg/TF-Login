accessing
loginCookies
	^ loginCookies ifNil: [ loginCookies := OrderedCollection new ]
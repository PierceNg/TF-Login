public
userForCookieKey: aCookieKey
	
	self allUserIds do: [ :ea | 
		(aCookieKey = (TLLoginCookie cookieKey: ea)) ifTrue: [ ^ self userForId: ea ]].
	^ nil

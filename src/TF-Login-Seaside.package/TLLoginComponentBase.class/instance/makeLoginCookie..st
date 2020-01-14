cookies
makeLoginCookie: aUser

	^ TLLoginCookie new 
		userId: aUser userId;
		expiryDate: DateAndTime now + (self session application preferenceAt: #automaticLoginCookieEffectiveDays) days;
		cookieValue: TLUser newUserId; "Use what's available to generate a random string."
		cookieKey: (TLLoginCookie cookieKey: aUser userId)
		yourself.

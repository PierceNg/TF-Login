cookies
makeLoginCookie: aUser

	^ TLLoginCookie new 
		userId: aUser userId;
		expiryDate: DateAndTime now + (self session application preferenceAt: #automaticLoginCookieEffectiveDays);
		cookieValue: TLUser newUserId; "Use what's available."
		yourself.

accessing
addLoginCookie: aCookie
	| cookie2|
	
	self deleteExpiredLoginCookies.
	cookie2 := aCookie deepCopy.
	cookie2 cookieValue: (TLLoginCookie cookieItemHashed: aCookie cookieValue). 
	self loginCookies add: cookie2
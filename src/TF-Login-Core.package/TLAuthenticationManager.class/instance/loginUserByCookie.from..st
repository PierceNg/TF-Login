API / CRUD
loginUserByCookie: clientSideCookie from: hostAddress
	"Always assume that a bad cookie is coming from an active attack?"
	
	| cookieKV user cookies user2 |

	[  cookieKV := TLLoginCookie clientSentKeyValue: clientSideCookie value ]
		on: TLLoginCookieError do: [ ^ nil ].

	user := self storageAdaptor userForCookieKey: cookieKV key.
	user ifNil: [ ^ nil ].
	
	cookies := user loginCookies select: [ :ea | ea isValid: cookieKV ].
	cookies ifEmpty: [ ^ nil ].
		
	user
		lastLogin: DateAndTime now;
		lastLoginFrom: hostAddress;
		incrementLoginCount.
	self saveUser: user.
		
	user2 := TLUser
		username: user username
		userId: user userId
		email: user email
		lastLogin: user lastLogin
		lastLoginFrom: user lastLoginFrom
		loginCount: user loginCount
		applicationProperties: user applicationProperties.
	user2 loginCookies: user loginCookies.
	^ user2
	
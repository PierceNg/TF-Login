tests
testLoginThenAutomaticLogin

	| content cookies loginCookie userByCookie |

	Transcript cr; show: 'testLoginThenAutomaticLogin'.

	self registerTestUser1.
	content := self getStartPage.
	content := self
		clickOn: 'loginbtn'
		in: content
		with: ((Dictionary new)
			at: 'loginuser' put: 'TestUser1';
			at: 'loginpswd' put: 'testpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.
	cookies := (client session cookieJar cookies select: [ :ea | ea name = 'TLTester-101' ]) asOrderedCollection.
	self assert: cookies size equals: 1.
	loginCookie := cookies first.
	userByCookie := (TLCachingFileStorageAdaptor name: TLTester appName) userForCookieKey: (TLLoginCookie clientSentKeyValue: loginCookie value) key.
	self assert: userByCookie username equals: 'TestUser1'.

	"Don't logout. Fetching the start page again should login automatically by cookie."
	content := self getStartPage.
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.

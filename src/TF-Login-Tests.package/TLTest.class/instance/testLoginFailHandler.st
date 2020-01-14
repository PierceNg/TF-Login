tests
testLoginFailHandler

	| content |

	Transcript cr; show: 'testLoginFailHandler'.

	TLTester setLoginFilter: true.
	TLTester setLoginFailHandler: true.
	self registerTestUser1.

	content := self getStartPage.
	3 timesRepeat: [
		content := self
			clickOn: 'loginbtn'
			in: content
				with: ((Dictionary new)
				at: 'loginuser' put: 'TestUser1';
				at: 'loginpswd' put: 'badpass';
				yourself)]..
	content := self
		clickOn: 'loginbtn'
		in: content
			with: ((Dictionary new)
			at: 'loginuser' put: 'TestUser1';
			at: 'loginpswd' put: 'testpass';
			yourself).
	self assert: (self findTag: 'div' in: content withClass: 'autherror') notNil

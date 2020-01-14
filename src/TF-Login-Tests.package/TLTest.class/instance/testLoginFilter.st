tests
testLoginFilter

	| content |

	Transcript cr; show: 'testLoginFilter'.

	TLTester setLoginFilter: true.
	self registerTestUser1.

	content := self getStartPage.
	5 timesRepeat: [
		content := self
			clickOn: 'loginbtn'
			in: content
				with: ((Dictionary new)
				at: 'loginuser' put: 'TestUser1';
				at: 'loginpswd' put: 'testpass';
				yourself).
		content := self
			clickOn: 'logoutbtn'
			in: content].
.
	content := self
		clickOn: 'loginbtn'
		in: content
			with: ((Dictionary new)
			at: 'loginuser' put: 'TestUser1';
			at: 'loginpswd' put: 'testpass';
			yourself).
	self assert: ((Soup fromString: content) findString: 'Too many logins') notNil

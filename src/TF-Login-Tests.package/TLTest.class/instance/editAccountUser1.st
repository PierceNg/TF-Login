testing support
editAccountUser1
	| content loginform controls url |

	self registerTestUser1.
	content := self getStartPage.
	content := self
		clickOn: 'loginbtn'
		in: content
		with: ((Dictionary new)
			at: 'loginuser' put: 'TestUser1';
			at: 'loginpswd' put: 'testpass';
			yourself).
	content := self
		clickOn: 'editaccountbtn'
		in: content.
	self assert: (self findFormIn: content withClass: 'editaccountform') notNil.
	^content

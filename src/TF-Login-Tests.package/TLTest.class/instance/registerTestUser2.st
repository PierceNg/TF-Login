testing support
registerTestUser2
	| content loginform controls url |

	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser2';
			at: 'registerpswd' put: 'testpass2';
			at: 'registerconfirmpswd' put: 'testpass2';
			at: 'registeremail' put: 'myemail';
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'loginconfsuccess') isNil not.

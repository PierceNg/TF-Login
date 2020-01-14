testing support
registerTestUser1
	| content loginform controls url |

	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.	
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'testpass';
			at: 'registerconfirmpswd' put: 'testpass';
			at: 'registeremail' put: 'myemail';
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'loginconfsuccess') isNil not.

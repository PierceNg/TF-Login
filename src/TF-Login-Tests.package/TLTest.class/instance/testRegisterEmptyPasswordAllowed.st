tests
testRegisterEmptyPasswordAllowed

	| content  |

	Transcript cr; show: 'testRegisterEmptyPasswordAllowed'.

	TLTester allowEmptyPasswords: true.
	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: '';
			at: 'registerconfirmpswd' put: '';
			at: 'registeremail' put: 'myemail@smpt.com';
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'loginconfsuccess') isNil not.


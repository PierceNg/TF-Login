tests
testRegisterUsernameExists

	| content  tag |

	Transcript cr; show: 'testRegisterUsernameExists'.

	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'testpass';
			at: 'registerconfirmpswd' put: 'testpass';
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'loginconfsuccess') isNil not.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'testpass2';
			at: 'registerconfirmpswd' put: 'testpass2';
			yourself).
	tag := (Soup fromString: content) findTagByClass: 'registererror'.
	self deny: tag isNil.
	self assert: (tag attributeAt: 'id') = 'registerusernameexists'.


tests
testRegisterEmptyPassword

	| content  tag |
	
	Transcript cr; show: 'testRegisterEmptyPassword'.
	
	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: '';
			at: 'registerconfirmpswd' put: '';
			yourself).
	tag := (Soup fromString: content) findTagByClass: 'registererror'.
	self deny: tag isNil.
	self assert: (tag attributeAt: 'id') = 'registerpasswordempty'.


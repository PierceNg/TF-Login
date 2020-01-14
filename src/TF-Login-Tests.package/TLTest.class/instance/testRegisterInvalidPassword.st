tests
testRegisterInvalidPassword

	| content  tag |

	Transcript cr; show: 'testRegisterInvalidPassword'.

	TLTester setPasswordValidator: true.
	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'pass';
			at: 'registerconfirmpswd' put: 'pass';
			yourself).
	tag := (Soup fromString: content) findTagByClass: 'registererror'.
	self deny: tag isNil.
	self assert: (tag attributeAt: 'id') = 'registerpasswordinvalid'.
	self assert: (tag findString: 'password too short') notNil.


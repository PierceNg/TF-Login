tests
testRegisterPasswordMismatch

	| content  tag |

	Transcript cr; show: 'testRegisterPasswordMismatch'.

	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'testpass';
			at: 'registerconfirmpswd' put: 'testpassxxx';
			yourself).
	tag := (Soup fromString: content) findTagByClass: 'registererror'.
	self deny: tag isNil.
	self assert: (tag attributeAt: 'id') = 'registerpasswordmismatch'.

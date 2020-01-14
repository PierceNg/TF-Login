tests
testEditAccountChangePassword

	| content  |

	Transcript cr; show: 'testEditAccountChangePassword'.

	content := self editAccountUser1.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctnewpswd' put: 'newtestpass';
			at: 'editacctnewpswdconf' put: 'newtestpass';
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.
	content := self
		clickOn: 'logoutbtn'
		in: content.
	self assert: ((Soup fromString: content) findTagByClass: 'loginform') notNil.
	content := self
		clickOn: 'loginbtn'
		in: content
		with: ((Dictionary new)
			at: 'loginuser' put: 'TestUser1';
			at: 'loginpswd' put: 'newtestpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.

		

	

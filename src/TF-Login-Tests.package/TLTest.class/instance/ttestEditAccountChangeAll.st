tests
ttestEditAccountChangeAll

	| content user |

	Transcript cr; show: 'testEditAccountChangeAll'.

	TLTester allowUsernameChange: true.
	content := self editAccountUser1.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctusername' put: 'NewUsername';
			at: 'editacctemail' put: 'newemail';
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
			at: 'loginuser' put: 'NewUsername';
			at: 'loginpswd' put: 'newtestpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.
	self assert: ((TLAuthenticationManager name: 'TLTester') userForUsername: 'NewUsername') email = 'newemail'.


		

	

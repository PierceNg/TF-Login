tests
testEditAccountChangeEmail

	| content  |

	Transcript cr; show: 'testEditAccountChangeEmail'.

	content := self editAccountUser1.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctemail' put: 'newemail';
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.
	self assert: ((TLAuthenticationManager name: 'TLTester') userForUsername: 'TestUser1') email = 'newemail'.

		

	

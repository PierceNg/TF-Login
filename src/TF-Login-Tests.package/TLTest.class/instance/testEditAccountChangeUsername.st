tests
testEditAccountChangeUsername

	| content user |

	Transcript cr; show: 'testEditAccountChangeUsername'.

	TLTester allowUsernameChange: true.
	content := self editAccountUser1.
	user := (TLAuthenticationManager name: 'TLTester') userForUsername: 'TestUser1'.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctusername' put: 'NewUsername';
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.
	self assert: ((TLAuthenticationManager name: 'TLTester') userForId: (user userId)) username = 'NewUsername'.

		

	

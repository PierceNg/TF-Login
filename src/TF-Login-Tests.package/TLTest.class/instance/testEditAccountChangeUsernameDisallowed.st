tests
testEditAccountChangeUsernameDisallowed

	| content user |

	Transcript cr; show: 'testEditAccountChangeUsernameDisallowed'.

	TLTester allowUsernameChange: false.
	content := self editAccountUser1.
	user := (TLAuthenticationManager name: 'TLTester') userForUsername: 'TestUser1'.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctusername' put: 'NewUsername';
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findTag: 'div' in: content withId: 'editacctusernamechangedisallowed') notNil.
	self assert: ((TLAuthenticationManager name: 'TLTester') userForId: (user userId)) username = 'TestUser1'.

		

	

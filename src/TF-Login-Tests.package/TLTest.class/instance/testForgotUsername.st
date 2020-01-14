tests
testForgotUsername

	| content  |

	Transcript cr; show: 'testForgotUsername'.

	TLTester usernameReminderEmailSender: [ :usernames :email |
		self assert: email = 'myemail'.
		self assert: (usernames includes: 'TestUser1').
		self assert: (usernames includes: 'TestUser2').
		true ].
	self registerTestUser1.
	self registerTestUser2.
	content := self getStartPage.
	content := self
		clickOn: 'forgotusernamebtn'
		in: content.
	content := self
		clickOn: 'forgotusernameokbtn'
		in: content
		with: ((Dictionary new)
			at: 'forgotusernameemail' put: 'myemail';
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'usernameemailsent' ) isNil not.
	content := self
		clickOn: 'usernameemailsentokbtn'
		in: content.
		

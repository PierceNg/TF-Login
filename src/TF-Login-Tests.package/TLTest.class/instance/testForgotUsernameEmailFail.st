tests
testForgotUsernameEmailFail

	| content |

	Transcript cr; show: 'testForgotUsernameEmailFail'.

	TLTester usernameReminderEmailSender: [ :usernames :email |
		self assert: email = 'myemail'.
		self assert: (usernames includes: 'TestUser1').
		false ].
	self registerTestUser1.
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
	content := self
		clickOn: 'usernameemailsentokbtn'
		in: content.
		

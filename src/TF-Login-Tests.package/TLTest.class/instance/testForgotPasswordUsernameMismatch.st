tests
testForgotPasswordUsernameMismatch

	| content url |

	Transcript cr; show: 'testForgotPasswordUsernameMismatch'.

	TLTester passwordResetEmailSender: [ :resetUrl :email : timeout |
		self assert: email = 'myemail'.
		url := resetUrl..
		self assert: timeout = 5.
		true ].
	TLTester confirmationTimeoutMinutes: 5.
	self registerTestUser1.
	content := self getStartPage.
	content := self
		clickOn: 'forgotpasswordbtn'
		in: content.
	content := self
		clickOn: 'forgotpasswordokbtn'
		in: content
		with: ((Dictionary new)
			at: 'forgotpasswordusername' put: 'TestUser1';
			yourself).
	self assert: (self findFormIn: content  withClass: 'passwordemailsent' ) notNil.
	content := self
		clickOn: 'passwordemailsentokbtn'
		in: content.
	content := (ZnClient new get: url) contents.
	self assert: (self findFormIn: content withClass: 'passwordresetform') notNil.
	content := self
		clickOn: 'resetbtn'
		in: content
		with: ((Dictionary new)
			at: 'resetpswduser' put: 'TestUser2';
			at: 'resetpswd' put: 'password2';
			at: 'resetpswdconfirm' put: 'password2';
			yourself).
	self assert: (self findTag: 'span' in: content withId:  'resetpasswordusernamemismatch' ) notNil.

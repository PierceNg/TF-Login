tests
testForgotPasswordEmptyAllowed

	| content url |

	Transcript cr; show: 'testForgotPasswordEmptyAllowed'.

	TLTester passwordResetEmailSender: [ :resetUrl :email : timeout |
		self assert: email = 'myemail'.
		url := resetUrl..
		self assert: timeout = 5.
		true ].
	TLTester allowEmptyPasswords: true.
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
			at: 'resetpswduser' put: 'TestUser1';
			at: 'resetpswd' put: '';
			at: 'resetpswdconfirm' put: '';
			yourself).
	self assert: (self findFormIn: content  withClass: 'pswdresetsuccessform') notNil.

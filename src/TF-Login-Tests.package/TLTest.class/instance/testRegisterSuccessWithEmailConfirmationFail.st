tests
testRegisterSuccessWithEmailConfirmationFail

	| content  myemail |
	
	Transcript cr; show: 'testRegisterSuccessWithEmailConfirmationFail'.

	myemail := 'meatmyemailcom'.
	TLTester registrationConfirmationEmailSender: [ :confirmUrl :email :timeout |
		self assert: email = myemail.
		false ].
	TLTester sendRegistrationConfirmationEmail: true.
	content := self getStartPage.
	content := self clickOn: 'registerbtn' in: content.	
	content := self
		clickOn: 'registerbtn'
		in: content
		with: ((Dictionary new)
			at: 'registeruser' put: 'TestUser1';
			at: 'registerpswd' put: 'testpass';
			at: 'registerconfirmpswd' put: 'testpass';
			at: 'registeremail' put: myemail;
			yourself).
	self assert: ((Soup fromString: content) findTagByClass: 'regsubmitfailed') isNil not.
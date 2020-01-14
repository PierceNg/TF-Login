tests
testEditAccountLoggedOut

	| content  content1 content2 |

	Transcript cr; show: 'testEditAccountLoggedOut'.

	content1 := self editAccountUser1.
	content2 := self
		clickOn: 'editacctokbtn'
			in: content1
			with: ((Dictionary new)
			at: 'editacctpswd' put: 'badpass';
			yourself).
	self assert: (self findFormIn: content2 withClass: 'editaccountform') notNil.
	content2 := self
		clickOn: 'editacctcancelbtn'
			in: content2.
	self assert: (self findFormIn: content2 withClass: 'loggedinform') notNil.
	content2 := self
		clickOn: 'logoutbtn'
			in: content2.
	self assert: (self findFormIn: content2 withClass: 'loginform') notNil.
	content2 := self
		clickOn: 'editacctokbtn'
			in: content1
			with: ((Dictionary new)
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findTag: 'div' in: content2 withId: 'editacctnouser') notNil.

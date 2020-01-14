tests
testEditAccountNoChange

	| content |

	Transcript cr; show: 'testEditAccountNoChange'.

	content := self editAccountUser1.
	content := self
		clickOn: 'editacctokbtn'
			in: content
			with: ((Dictionary new)
			at: 'editacctpswd' put: 'testpass';
			yourself).
	self assert: (self findFormIn: content withClass: 'loggedinform') notNil.

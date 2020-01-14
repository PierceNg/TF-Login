tests
testRegisterMany

	| content |

	Transcript cr; show: 'testRegisterMany'.

	content := self getStartPage.
	1 to: 10 do: [ :n |
		content := self clickOn: 'registerbtn' in: content.	
		content := self
			clickOn: 'registerbtn'
			in: content
			with: ((Dictionary new)
				at: 'registeruser' put: 'TestUser', n asString;
				at: 'registerpswd' put: 'testpass', n asString;
				at: 'registerconfirmpswd' put: 'testpass', n asString;
				at: 'registeremail' put: 'myemail', n asString;
				yourself).
		self assert: ((Soup fromString: content) findTagByClass: 'loginconfsuccess') isNil not ].

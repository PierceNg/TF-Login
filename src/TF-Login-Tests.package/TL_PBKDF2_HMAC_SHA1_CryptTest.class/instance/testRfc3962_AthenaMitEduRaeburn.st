setUp-tearDown
testRfc3962_AthenaMitEduRaeburn
	| hash |

	crypt iterations: 1.

	crypt outputSize: 16.
	hash := crypt crypt: 'password' salt: 'ATHENA.MIT.EDUraeburn'.
	self assert: hash passwordHash hex equals: 'cdedb5281bb2f801565a1122b2563515'.
	
	crypt outputSize: 32.
	hash := crypt crypt: 'password' salt: 'ATHENA.MIT.EDUraeburn'.
	self assert: hash passwordHash hex equals: 'cdedb5281bb2f801565a1122b25635150ad1f7a04bb9f3a333ecc0e2e1f70837'.
	
	crypt iterations: 2.

	crypt outputSize: 16.
	hash := crypt crypt: 'password' salt: 'ATHENA.MIT.EDUraeburn'.
	self assert: hash passwordHash hex equals: '01dbee7f4a9e243e988b62c73cda935d'.

	crypt outputSize: 32.
	hash := crypt crypt: 'password' salt: 'ATHENA.MIT.EDUraeburn'.
	self assert: hash passwordHash hex equals: '01dbee7f4a9e243e988b62c73cda935da05378b93244ec8f48a99e61ad799d86'.

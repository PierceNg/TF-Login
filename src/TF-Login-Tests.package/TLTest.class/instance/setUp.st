testing support
setUp

	self useZincServer
		ifTrue: [
  	     		self server: (self seasideAdaptorClass port: 12345) start.
			0.5 seconds wait.
       			self assert: (self server isRunning ) description: 'This test needs a Seaside server.'.].

	self assert: ((Smalltalk at: #Soup ifAbsent: [nil]) isNil not) description: 'This test requires Soup: http://smalltalkhub.com/#!/~PharoExtras/Soup'.
	
	"TLCachingFileStorageAdaptor initialize."
	TLTester testing: true.
	TLTester initialize.
	TLTester sendRegistrationConfirmationEmail: false.
	TLTester confirmationTimeoutMinutes: 10.
	TLTester setPasswordValidator: false.
	TLTester allowEmptyPasswords: false.
	TLTester allowAutomaticLogin: true.
	(TLCachingFileStorageAdaptor name: TLTester appName) deleteDatabase. 
	TLAuthenticationManager initialize.
	client := (ZnClient new).
	client timeout: 10.

	 
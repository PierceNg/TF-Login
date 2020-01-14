testing support
tearDown
	TLTester uninitialize.
	(TLCachingFileStorageAdaptor name: TLTester appName) deleteDatabase. 
	TLAuthenticationManager initialize.
	self useZincServer ifTrue: [ self server unregister ]

		
	 
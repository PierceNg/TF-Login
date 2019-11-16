accessing
storageAdaptor
	storageAdaptor isNil ifTrue: [ self storageAdaptor: (TLCachingFileStorageAdaptor name: self appName)].
	^storageAdaptor 

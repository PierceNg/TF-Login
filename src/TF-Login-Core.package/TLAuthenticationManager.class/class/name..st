instance creation
name: anAppName
	^ self basicNew
		initialize;
		appName: anAppName;
		yourself
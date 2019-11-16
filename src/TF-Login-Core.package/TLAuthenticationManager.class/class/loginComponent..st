instance creation
loginComponent:  aLoginComponent
	^ self basicNew
		initialize;
		appName: aLoginComponent appName;
		loginComponent: aLoginComponent;
		yourself
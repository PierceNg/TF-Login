testing support
getStartPage
	^ (client get: self baseUrl, '/', TLTester appName) contents.

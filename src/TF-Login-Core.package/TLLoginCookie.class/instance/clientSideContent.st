accessing
clientSideContent

	^ String streamContents: [ :s | 
		s nextPutAll: cookieKey;
			nextPutAll: self class clientSideSeparator;
			nextPutAll: cookieValue ]
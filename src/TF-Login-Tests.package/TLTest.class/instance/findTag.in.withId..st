testing support
findTag: tagName in: content withId: id
	^ ((Soup fromString: content) findAllTags: tagName) detect: [ :each |
		 (each attributeAt: 'id') = id ] ifNone: [ nil ]
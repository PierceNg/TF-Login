testing support
findTag: tagName in: content withClass: aClassName
	| tag |
	^ (tag := ((Soup fromString: content) findTagByClass: aClassName)) name = tagName
		ifTrue: [ tag ]
		ifFalse: [ nil ]


public
fileNamesMatchingNoLock: aWildcardString
	| list |
	list := OrderedCollection new.
	self dirlist values do: [ :dir |
		list addAll: (dir fileNamesMatching: aWildcardString)  ].
	^list
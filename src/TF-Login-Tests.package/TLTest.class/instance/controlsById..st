testing support
controlsById: aForm
	| tags dict |
	dict := Dictionary new.
	tags := #( 'input' 'button').
	
	tags do: [ :eachTag |
		(aForm findAllTags: eachTag) do: [ :each |
			| id |
			id := each attributeAt: 'id'.
			id isNil ifFalse: [ dict at: id put: (each attributeAt: 'name')  ]]].
	^ dict
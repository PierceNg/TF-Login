accessing
iterations
	^ iterations ifNil: [ iterations := self defaultIterations ]
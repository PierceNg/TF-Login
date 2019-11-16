accessing
outputSize
	^ outputSize ifNil: [ outputSize := self defaultOutputSize ]
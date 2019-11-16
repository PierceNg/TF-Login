process
crypt: aPassword
	^ self crypt: aPassword salt: (self salt: self saltSize)
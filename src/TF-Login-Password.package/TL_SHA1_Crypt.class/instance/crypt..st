process
crypt: aPassword
	
	^ TLPasswordHash new
		algoClass: self class name
		iterations: nil
		salt: nil
		passwordHash: (Base64MimeConverter mimeEncode: (ReadStream on: (SHA1 hashMessage: aPassword))) contents
		passwordHashSize: nil
	
"
Original implementation of TLRegisteredUser>>encryptPassword:
	^ (Base64MimeConverter mimeEncode: (ReadStream on: (SHA1 hashMessage: aPassword,userId))) contents.

Note 'userId' was concatenated to 'aPassword'. In this implementation, caller prepares 'aPassword' appropriately.
"

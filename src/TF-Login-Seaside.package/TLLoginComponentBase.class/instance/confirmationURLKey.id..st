email-confirmation
confirmationURLKey: aKey id: regId
	self flag: #XXX. "Fix the URl scheme."
	^ 'http://' , self session requestContext request host, '/',self session url path first asString , '?', aKey, '=' , regId.

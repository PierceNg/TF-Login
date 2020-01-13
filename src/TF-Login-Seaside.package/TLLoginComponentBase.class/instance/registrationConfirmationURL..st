email-confirmation
registrationConfirmationURL: regId
	self flag: #XXX. "Fix the URL scheme."
	^ 'http://' , self session requestContext request host, '/',self session url path first asString , '?regconfirm=' , regId.

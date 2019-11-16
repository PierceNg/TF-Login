API / CRUD
confirmationURL: regId
	^ 'http://' , self loginComponent session requestContext request host, self session basicUrl asString , '&confirm=' , regId.

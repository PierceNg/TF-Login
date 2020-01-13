as yet unclassified
confirmWithUser
	| url userAction |
		"Instantiate a TLPendingUserAction object for your user and
		provide a one-argument block to be evaluated when the user confirms."
		userAction := TLPendingUserAction 
			forUser: self session user
			onConfirmDo: [ :confirmedAction |
				self testConfirmed: true ].
	
		"Queue the pending user action. It will remain active for the configured
		confirmation timeout period. This method retruns the confirmation URL
		to which the user must navigate to confirm the action." 
		url := loginComponent addPendingUserAction: userAction.
	
		"Send a confirmation email to the user."
		self
			sendTestConfirmationUrl: url
			to: self session user email
			timeout: (self application preferenceAt: #confirmationTimeoutMinutes)	
		

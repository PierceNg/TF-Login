as yet unclassified
renderPrefs: view
		view form
			class: 'prefs';
			with: [
				view table: [
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #sendRegistrationConfirmationEmail);
								callback: [ :v | 	self application preferenceAt: #sendRegistrationConfirmationEmail put: v ].
							view text: 'Registration requires email confirmation']].
					
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #confirmEmailChangeViaEmail);
								callback: [ :v | 	self application preferenceAt: #confirmEmailChangeViaEmail put: v ].
							view text: 'Email address change requires email confirmation']].
					
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #confirmAccountChangesViaEmail);
								callback: [ :v | 	self application preferenceAt: #confirmAccountChangesViaEmail put: v ].
							view text: 'All account changes require email confirmation']].
					
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #allowEmptyPasswords);
								callback: [ :v | 	self application preferenceAt: #allowEmptyPasswords put: v ].
							view text: 'Allow passwords to be empty.']].
					
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #allowUsernameChange);
								callback: [ :v | 	self application preferenceAt: #allowUsernameChange put: v ].
							view text: 'Allow users to change their usernames.']].
					
					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #allowAutomaticLogin);
								callback: [ :v | 
									self application preferenceAt: #allowAutomaticLogin put: v ].
							view text: 'Allow users to automatically log in.']].

					view tableRow: [
						view tableData: [
							view checkbox
								onChange: 'return submitForm(this)';
								value: 	(self application preferenceAt: #useRecaptchaInRegistrationForm);
								callback: [ :v | self application preferenceAt: #useRecaptchaInRegistrationForm put: v ].							
							view text: 'Include reCAPTCHA spam prevention in registration form']].

					view tableRow: [
						view tableData: [
							view text: 'Confirmation email timeout in minutes: '.
							view textInput
								style: 'width: 40px';
								value: (self application preferenceAt: #confirmationTimeoutMinutes);
								callback: [ :v | self application preferenceAt: #confirmationTimeoutMinutes put: v ].
							view button
								onChange: 'return submitForm(this)';
								with: 'Set']].
								.
					view tableRow: [
						view tableData: [
							view text: 'Minimum password length: '.
							view textInput
								style: 'width: 40px';
								value: (self application preferenceAt: #minimumPasswordLength);
								callback: [ :v | self application preferenceAt: #minimumPasswordLength put: v ].
							view button
								onChange: 'return submitForm(this)';
								with: 'Set']].
						
					view tableRow: [
						view tableData: [
							view text: 'Maximum login failures before account disabled: '.
							view textInput
								style: 'width: 40px';
								value: (self application preferenceAt: #maximumFailedLoginAttempts);
								callback: [ :v | self application preferenceAt: #maximumFailedLoginAttempts put: v ].
							view button
								onChange: 'return submitForm(this)';
								with: 'Set']].

					"view tableRow: [
						view tableData: [
							view text: 'SMTP server address: '.
							view textInput
								value: (self application preferenceAt: #outgoingMailServerAddress);
								callback: [ :v | self application preferenceAt: #outgoingMailServerAddress put: v ]]]."

					"view tableRow: [
						view tableData: [
							view text: 'reCAPTCHA Private Key: '.
							view textInput
								style: 'width: 300px';
								value: (self application preferenceAt: #privateKey);
								callback: [ :v | self application preferenceAt: #privateKey put: v ]]].
					view tableRow: [
						view tableData: [
							view text: 'reCAPTCHA Public Key: '.
							view textInput
								style: 'width: 300px';
								value: (self application preferenceAt: #publicKey);
								callback: [ :v | self application preferenceAt: #publicKey put: v ]]]."
					"
					view tableRow: [
						view tableData: [
							view checkbox.
							view text: 'Silently fail for 300 seconds after 3 failed attempts.']].
					
					view tableRow: [
						view tableData: [
							view checkbox.
							view text: 'Send email after 10 failed attempts.']].
					"					]]
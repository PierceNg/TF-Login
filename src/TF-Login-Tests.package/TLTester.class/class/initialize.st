as yet unclassified
initialize

	"self testing: true. self initialize."
	"self testing: false."

	| application |
	self testing ifFalse: [ ^ self ].
	super initialize.
	application := WAAdmin register: self asApplicationAt: self appName.
	application preferenceAt: #sessionClass put: TLSession.
	application configuration parents add: TLConfiguration instance.
	application configuration parents add: WAEmailConfiguration instance.
	"application configuration parents add: BWRecaptchaConfiguration instance."
	application preferenceAt: #smtpServer put: 'localhost'.
	application preferenceAt: #sendRegistrationConfirmationEmail put: false.
	application preferenceAt: #confirmationTimeoutMinutes put: 10.
	application preferenceAt: #useRecaptchaInRegistrationForm put: false.	
	application preferenceAt: #confirmEmailChangeViaEmail put: false.
	application preferenceAt: #confirmAccountChangesViaEmail put: false.
	application preferenceAt: #allowEmptyPasswords put: false.
	application preferenceAt: #allowUsernameChange put: false.
	application preferenceAt: #allowAutomaticLogin put: true.


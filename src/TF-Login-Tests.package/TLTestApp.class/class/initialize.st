as yet unclassified
initialize
	"TLTestApp initialize"

	| application |
	super initialize.
	application := WAAdmin register: self asApplicationAt: 'LoginTestApp'.
	application preferenceAt: #sessionClass put: TLSession.
	application configuration parents add: TLTestAppConfiguration instance.
	application configuration parents add: TLConfiguration instance.
	application configuration parents add: WAEmailConfiguration instance.
	"(Smalltalk at: #BWRecaptchaConfiguration ifAbsent: [ nil ]) isNil ifFalse: [
		application configuration parents add: BWRecaptchaConfiguration instance]."
	application preferenceAt: #smtpServer put: 'localhost'.
	application preferenceAt: #minimumPasswordLength put: 6.
	application preferenceAt: #maximumFailedLoginAttempts put: 3.
	application preferenceAt: #sendRegistrationConfirmationEmail put: false.
	application preferenceAt: #confirmationTimeoutMinutes put: 10.
	application preferenceAt: #useRecaptchaInRegistrationForm put: false.	
	application preferenceAt: #confirmEmailChangeViaEmail put: false.
	application preferenceAt: #confirmAccountChangesViaEmail put: false.
	application preferenceAt: #allowEmptyPasswords put: false.
	application preferenceAt: #allowUsernameChange put: false.
	application preferenceAt: #allowAutomaticLogin put: true.
	application preferenceAt: #automaticLoginCookieEffectiveDays put: 7.
	
	application 
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary.
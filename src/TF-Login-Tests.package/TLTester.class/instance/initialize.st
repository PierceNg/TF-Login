accessing
initialize
	"self initialize."
	super initialize.
	self application preferenceAt: #allowEmptyPasswords put: self class allowEmptyPasswords.
	self application preferenceAt: #sendRegistrationConfirmationEmail put: self class sendRegistrationConfirmationEmail. 
	self application preferenceAt: #confirmationTimeoutMinutes put: self class confirmationTimeoutMinutes. 
	self application preferenceAt: #allowUsernameChange put: self class allowUsernameChange.
	self application preferenceAt: #allowAutomaticLogin put: self class allowAutomaticLogin.

	loginComponent := TLLoginComponent appName: self class appName.
	loginComponent authenticationManager storageAdaptor: (TLCachingFileStorageAdaptor name: self class appName).
	loginComponent onAnswer: [ :user | user ifNotNil: [ : u |  ] ].
	self class setPasswordValidator ifTrue: [
		loginComponent passwordValidator: [ :pswd |  pswd size < 6 ifTrue: [ 'password too short'] ifFalse: [ nil ] ] ].
	self class setLoginFilter ifTrue: [
		loginComponent onLogin: [ :user |
			user notNil ifTrue: [  
			user loginCount > 5
				ifTrue: [ 'Too many logins' ]
				ifFalse: [
					(user applicationProperties at: 'failcount' ifAbsent: [0]) >= 3
						ifTrue: [ 'Account disabled.']
						ifFalse: [ nil ]]]]].
	self class setLoginFailHandler ifTrue: [
		loginComponent onLoginFail: [ :username :address |
			| user failcount |  
			user := loginComponent authenticationManager userForUsername: username.
			user notNil ifTrue: [
			failcount := user applicationProperties at: 'failcount' ifAbsent: [ 0 ].
			failcount := failcount + 1.
			user applicationProperties at: 'failcount' put: failcount.
			loginComponent saveUser: user.
			nil ]]].
	self children add: loginComponent.
	editAccountComponent := (TLEditAccountComponent loginComponent: loginComponent).
	editAccountComponent onAnswer: [ ].
	self children add: editAccountComponent.
	self setMailSenders.
	loggedIn := false.
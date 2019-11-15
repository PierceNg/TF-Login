# Nov 2019

This is a feature branch off ```pharo7``` to implement salted SHA256-hashed passwords.

----

Originally from http://www.squeaksource.com/TFLogin.html, but tests were failing. It turns out that this was written for pharo 1.1.1. I wanted to use pharo 2, so I refactored the parts that didn't work in pharo 2. The following are the changes i made:

- ReadStream was updated to use Fuel.
- The tests now only support ZnClient and ZnServer.

All tests now pass, except for testCapacity test. I will look at this in the next week, but I thought it would be worthwhile to get it out.

This package provides basic user authentication, registration, and account management for Seaside.

Features include:

- User login component with username and password text fields, forgot username, forgot password, register, and login buttons.
- User registration component with optional BowWave reCaptcha spambot protection.
- Edit account settings component allows user to change username, password, email address and application-specific properties.
- Optional email confirmation for registration and account changes. Email content is provided by the host application. Examples are included.
- Multi-part HTML/plain text email.
- Configurable confirmation email timeouts and cookie retention periods.
- Forgot username and forgot password support.
- New password validation by the host application (to enforce password rules like minimum-length, etc.)
- Options to allow empty passwords, remember username in cookie, and automatic login on return to the website.
- Host application can provide login filter block for such things as disabling accounts or limiting login frequency.
- Host application can use TFLogin's email confirmation mechanism for application-specific purposes. Additional user-related objects may be included in the account edit form.
- Persistence is provided by a storage adaptor that can be replaced with the persistence mechanism of your choice. The provided default file storage adaptor scales to 100,000 users. Each user's information is saved in a separate versioned file.
- An application properties dictionary is provided that allows you to store and retrieve additional objects along with the user account information.
- All settings are available in the Seaside configuration page. Test/demo application included.
- TFLogin Guide document included (see below).
- Tested with Seaside 3.0.3 and Pharo 1.1.1. Email does NOT work with prior versions of Seaside.

All feedback is welcome.

# TFLogin Guide

Note that the tests included in the TFLogin package require the following packages to run:

    http://www.squeaksource.com/Soup
        Soup

    http://www.squeaksource.com/ZincHTTPComponent
        Zinc-HTTP

## Integrating TFLogin with Your Application

Take a look at the TLTestApp to see an example of the steps below.

There are a number of steps to introducing TFLogin authentication to an existing Seaside application. They are described below:

1. Create `MyCoolComponent class>>#initialize` like the following:
```smalltalk
initialize
	
	| application |
	application := WAAdmin register: self asApplicationAt: self handlerName.
	application preferenceAt: #sessionClass put: TLSession.

	"Add TL-specific configuration options"
	application configuration
		addParent: TLConfiguration instance;
		addParent: WAEmailConfiguration instance
```
2. If you plan to use reCaptcha to protect your registration form from spammers, then you will need the BowWave reCaptcha package that you can obtain by evaluating:
```smalltalk
    Gofer it
        url: 'http://www.squeaksource.com/BowWave';
            package: 'BowWave-Captcha-Core';
            package: 'BowWave-Captcha-Recaptcha';
            load.
```
Then add lines like the following to `MyCoolComponent class>>#initialize`, substituting your public and private reCaptcha keys that you obtain free from http://www.google.com/recaptcha.
```smalltalk	
    application configuration parents add: BWRecaptchaConfiguration instance.
    application preferenceAt: #publicKey put: '{{your-public-key}}'.
    application preferenceAt: #privateKey put: '{{your-private-key}}'.
```
Note that these preferences can also be set using your application's Seaside configuration page.

If you do not plan to use reCaptcha spambot protection, then it is not necessary to install the BowWave package.

3. You can also set TFLogin preferences in `MyCoolComponent class>>#initialize` if you wish, or you can set the using the Seaside application config page.  Here is an example of what can be done in the initialize method:
```smalltalk
	application preferenceAt: #sendRegistrationConfirmationEmail put: true.
	application preferenceAt: #confirmationTimeoutMinutes put: 10.
	application preferenceAt: #useRecaptchaInRegistrationForm put: false.	
	application preferenceAt: #smtpServer put: 'localhost'.	
	application preferenceAt: #confirmEmailChangeViaEmail put: false.
	application preferenceAt: #confirmAccountChangesViaEmail put: false.
	application preferenceAt: #allowEmptyPasswords put: false.
	application preferenceAt: #allowUsernameChange put: false.
	application preferenceAt: #allowRememberUsername put: true.
	application preferenceAt: #allowAutomaticLogin put: false.
```	
Note that these preferences can also be set using your application's Seaside configuration page.

4. In your component's instance-side `#initialize` method (not the class initialize method as described above) put the following to make the TFLogin components known to your application:
```smalltalk
initialize

	super initialize.
	loginComponent := (TLLoginComponent appName: '<your-app-name>').
	loginComponent onAnswer: [ :user | user ifNotNilDo: [ :u | self loggedIn: u ] ].
	self children add: loginComponent.
	editAccountComponent := (TLEditAccountComponent loginComponent: loginComponent).
	editAccountComponent onAnswer: [ self editingAccount: false ].
	self children add: editAccountComponent.
```
If you don't already have one, you will need a children method that looks like this:
```smalltalk
children
	^ children ifNil: [ children := Bag new ]
```	

5. If you will be using email confirmation, then you will need to tell TFLogin where your email sending methods are like this (also in the application initialize method). An example of the email sending methods referenced here is presented later on in this guide.
```smalltalk
	loginComponent registrationConfirmationEmailSender: [ :url :email :timeout | 
		self
			sendRegistrationConfirmationEmailTo: email
			confirmUrl: url
			timeoutMinutes: timeout  ].
	loginComponent passwordResetEmailSender: [ :url :email :timeout |
		self
			sendPasswordResetUrl: url
			to: email
			timeout: timeout ].
	loginComponent usernameReminderEmailSender: [ :usernames :email | 
		self
			sendUsernameReminderFor: usernames
			to: email ].
	editAccountComponent emailChangeConfirmationEmailSender: [ :url :email :timeout :newUser |
		self
			sendEmailChangeConfirmationTo: email
			confirmUrl: url
			timeout: timeout
			newUser: newUser  ].
	editAccountComponent accountChangeConfirmationEmailSender: [ :url :email :timeout :newUser |
		self
			sendAccountChangeConfirmationTo: email
			confirmUrl: url
			timeout: timeout
			newUser: newUser ].
```

6. If you want to support automatic login using username/password cookies for your users, you will need to include the following in your application's initialRequest method: 
```smalltalk
	loginComponent cookieLogin
```	
This will log the user in immediately before your application has had a change to display the loginComponent if they have the correct cookies defined (as would be the case if they checked the "Log me in automatically when I return to this site" checkbox when they last logged in.)

7. Here is an example of a mail-sending method. The text would of course vary depending on your application and the specific message being sent.
```smalltalk
sendRegistrationConfirmationEmailTo: email confirmUrl: url timeoutMinutes: timo
	"Compose and send email. Answer true on success, false on failure."

	| textBody htmlBody emailOk appName |

	appName := 'Login Test App'.
	
	"Compose a pain text message."
	textBody := (WriteStream on: String new)
		<< 'This email is in response to your request to register at '; << appName; << '.'; crlf;crlf;
		<< 'Direct your browser to the following URL within ';<< timo asString; << ' minutes to confirm your registration.'; crlf;crlf;
		<< '         '; << url; crlf;crlf;
		<< 'If you did not attempt to register for a'; << appName; << ' account then this message was sent in error and should be ignored.'.	

	"Compose a nice HTML message."
	htmlBody := WAHtmlCanvas builder fullDocument: true; render: [ :html |
		html div
			style: 'font-size:11pt;';
			with: [
				html div
					style: 'margin-bottom: 10px;';
					with: 'This email is in response to your request to register at ', appName, '.'.
				html text: 'Click on the link below within ', timo asString, ' minutes to confirm your registration.'.
				html div
					style: 'margin-left:20pt;margin-top:10px;margin-bottom:10px;';
					with: [
						html anchor
							url: url;
							with: 'Confirm registration'].
		 		html text: 'If the link above is unresponsive, copy and paste the URL below into your browser''s address field to confirm your registration.'.
				html div
					style: 'margin-left:20pt;margin-top:10px;margin-bottom:10px;';
					with: url.
				html text: 'If you did not attempt to register for a', appName, ' account then this message was sent in error and should be ignored.']].

	"Send the message."
	(emailOk := self sendEmailTo: email subject:  appName, ' Registration - action required' text: textBody html: htmlBody)
		ifFalse: [ Transcript cr; show: url ].

	^ emailOk

sendEmailTo: toAddress subject: subj text: textBody html: htmlBody
	"Send multi-part MIME email message."
	
	| sem em|
	em := TLMailMessage empty.
	em addAlternativePart: textBody contents contentType: 'text/plain'.
	em addAlternativePart: htmlBody contents contentType: 'text/html'.
	sem := em
		seasideMailMessageFrom: 'Registrar@' , self emailHost
		to: toAddress
		subject: subj.
	[sem send] on: Exception do: [ :ex | ^ false ].
	^ true	
```

8. In your application's `#renderContentOn:` you should render your loginComponent or editAccountComponent (from step 4 above) as embedded components. (They also support being "called" modally, but this functionality has not been tested.)

If the TLSession>>#user is nil, it means no-one is logged in and you might want to use this to determine whether to display the loginComponent. 

The editAccountComponent is generally displayed in response to an application-provided button. In step 4 we assumed that this button would set the `editingAccount` variable to true and that this would cause the `editAccountComponent` to be rendered. You may wish to use another method to determine how to display the `editAccountComponent`.

The `loginComponent` will answer when a user has successfully logged in. This is handled in the block specified in step 4 above. In that block we call an application method called `#loggedIn`. You can do whatever you wish in that method.

The `editAccountComponent` will answer when new values have been entered and the user has supplied the correct password or has clicked the cancel button. In step 4 above the block specified for this sets the `editAccount` variable to false, which we are assuming will cause the `editAccountComponent` not to be rendered.
	
	
## AJAX

The components with "Ajax" in their names, TLAjaxLoginComponent, TLAjaxForgotPasswordComponent, TLAjaxForgotUsernameComponent, and TLAjaxRegisterComponent interact with the user without perform full page refreshes. This makes them suitable for use in a JQuery dialog. See TLTestApp>>#renderLoginDialog: for an example of using TFLogin components in JQuery dialogs:
```smalltalk
	renderLoginDialog: html
		(html div)
			class: 'logindialog';
			script: ((html jQuery new dialog)
				title: 'Pop-up login';
				width: '540px';
				resizable: false;
				autoOpen: true;
				modal: false);
			with: [
				html render: ajaxLoginComponent  ]
```		
Note that to use JQueryUI components you must load the JQuery libraries in your application class #initialize method like this:
```smalltalk
	application 
 	       addLibrary: JQDeploymentLibrary;
  	      addLibrary: JQUiDeploymentLibrary.
```
and use TLAjaxLoginComponent in place of TLLoginComponent in your application #initialize method.

	
## New Password Validation

You can constrain passwords selected by your users to obey whatever rules you choose to define. In your application  initialization method, send a one-argument block to TLLoginComponent>>#passwordValidator:. This block will be passed the candidate password. The block should evaluate to nil if the password is acceptable, or to a string containing the error message to be shown to the user if it is not. The validator block is evaluated during user registration, when the user changes their password in the EditAccountComponent, and when the user resets their password when it has been forgotten.

Here is an example from TLTestApp:

In TLTestAPP>>initialize
```smalltalk
loginComponent passwordValidator: [ :pswd | self validatePassword: pswd ].
```
```smalltalk
validatePassword: password
    ^ password size < self minimumPasswordLength
            ifTrue: [ 'Password must be at least ', self minimumPasswordLength asString, ' characters long.']
            ifFalse: [ nil ]
```
```smalltalk
minimumPasswordLength
    ^ 6
```

## Logging Out

TLLoginComponent provides no logout button as it's placement is generally application-specific. Your logout button, if you have one, should send loginComponent>>#logout. Among other tasks, this will set the session user to nil. Thereafter, you may wish to unregister your session like this:
```smalltalk
        loginComponent logout.
        self session unregister.
```

## User Administration

TFLogin provides no components for administration of users at this time.

You can obtain a list of all usernames by evaluating
```smalltalk
    (TLAuthenticationManager name: 'your-app-name') allUsernames.
```
You can prepare reports on users using the following code fragment as a beginning
```smalltalk
    | authmgr |
    authmgr := (TLAuthenticationManager name: 'LoginTestApp').
    authmgr allUserIds do: [ :each |
        | user |
        user := authmgr userForId: each.
        Transcript cr; show: 'User ', user username, ' last login at ',
            user lastLoginFormatted, ' from ',
            user lastLoginFrom]
```

## Deleting User Accounts

To delete the current user account, use the TLLoginComponent>>#deleteLoggedInUser method. Here's an example:
```smalltalk
    loginComponent deleteLoggedInUser.
```
To delete a specific user you can evaluate something like this:
```smalltalk
    (TLAuthenticationManager  name: 'your-app-name') deleteUserByUsername: 'the-username-to-delete'
```
where your-app-name is your application name as provided in TLLoginComponent>>#initialize.

## Login Filter

If you provide a one-argument block to TLLoginComponent>>#onLogin: it will be evaluated after a logging-in user's username and password have been validated, but before they have gaind access. The argument passed to the block is the logging-in user object. In the block you can access all the user object methods, including applicationProperties. If the block evaluates to nil, the user is allowed access. To disallow access, the block should evaluate to a string to be displayed to the user explaining that they are being denied access.

Login filters can be used to disable accounts temporarily, limit the frequency of logins, logging, etc.

Here is an example from LoginTestApp. There is a button labeled "Disable my account for two minutes" presented to logged-in users. Clicking the button sends disableMe:
```smalltalk
disableMe
    self session user applicationProperties at: 'disabled' put: (DateAndTime current) + 2 minutes.
    self loggedOut
```	
In LoginTestApp initialize, the login filter is established like this:
```smalltalk
    loginComponent onLogin: [ :user | self loginFilter: user ].
```
Here is the login filter method itself:
```smalltalk
loginFilter: user
    | until |
    until := user applicationProperties at: 'disabled' ifAbsent: [ ^ nil ].
    until < DateAndTime current
        ifTrue: [
            user applicationProperties removeKey: 'disabled'.
            ^ nil ]
        ifFalse: [
            ^ 'Your account is disabled. Try again later.']
```	

## Managing Login Failures

Similar to the login filter, if you supply a two-argument block to TLLoginComponent>>#onLoginFail:, it will be evaluated when a user login attempt fails. The arguments passed to the block are the username and remote address of the failed login attempt. The block should evaluate to nil or text to be displayed to the user inplace of the standard authorization error message (TLLoginComponent>>#authenticationErrorText).

This can be used, together with application properties and a login filter to implement failed login policies such as disabling accounts after too many failed login attempts or ignoring logins from remote addresses that have been repeatedly attempting to login using many usernames.

Here is the code from TLTestApp that implements a maximum failed login attempts policy:

In TLTestApp initialize:
```smalltalk
    loginComponent onLogin: [ :user | self loginFilter: user ].
    loginComponent onLoginFail: [ :username :address | self loginFailedUser: username from: address ].
```
```smalltalk
loginFailedUser: username from: address
    "After the configured number of consecutive failed login attempts, disable the
    account for 2 minutes. Answer nil or text to be displayed in place of the normal
    authorization failure message."
	
    ^ (loginComponent authenticationManager usernameExists: username)
        ifTrue: [
            | failedUser failureCount |
            failedUser := loginComponent authenticationManager userForUsername: username.
            failureCount := failedUser applicationProperties at: 'failedLoginAttempts' ifAbsent: [ 0 ].
            failureCount < self maximumFailedLoginAttempts
                ifTrue: [
                    failedUser applicationProperties
				at: 'failedLoginAttempts'
				put: (failureCount  + 1).
                    loginComponent saveUser: failedUser.
                    nil ]
                ifFalse: [
                    failedUser applicationProperties
				at: 'disabledForLoginFailures'
				put: (DateAndTime current) + 2 minutes.
                    loginComponent saveUser: failedUser.
                    self disabledForLoginFailuresText ]]
        ifFalse: [ nil ]
```
```smalltalk
loginFilter: user
    "Return nil to allow login, or text to be displayed to the user if login is disallowed.
    First we check for disable from login failures, then for user requested disable."
	
    ^ (self loginFilterDisableForLoginFailures: user) ifNil: [self loginFilterDisabledByUser: user ]
```
```smalltalk
loginFilterDisableForLoginFailures: user
    "If logins have been disabled for too many login failures, return text to present to user,
    otherwise nil to allow login.
	
    Note that we use the same message here as is used in #loginFailedUser:from: so that
    there is no indication to the user that this time the correct password was actually entered." 

    | until |
    ^ (user applicationProperties includesKey: 'disabledForLoginFailures')
        ifTrue: [
            until := user applicationProperties at: 'disabledForLoginFailures'.
            until < DateAndTime current
                ifTrue: [
                    user applicationProperties removeKey: 'disabledForLoginFailures'.
                    nil ]
                ifFalse: [
                    self disabledForLoginFailuresText ]]
        ifFalse: [ nil ]
```
```smalltalk
loggedIn: user
	"sent from onAnswer in self initialize."
	
	user applicationProperties removeKey: 'failedLoginAttempts' ifAbsent: [].
```

## Auto-login

You may allow your user to specify that they be logged in automatically when they return to your site. This is accomplished by defining cookies that contain the user's base64 encoded username and an encrypted copy of their password.

Even though the password cookie content is encrypted, use of this feature presents a serious security risk. Consider allowing it only over secure (TLS/SSL) sessions or only when revealing the user's content to unauthorized users is not a problem.

Note that the TFLoginComponent>>#logout method clears the password cookie. Otherwise users with auto-login would be automatically logged in immediately after logout and would have no opportunity to change their auto-login setting. In general, users who have specified auto-login should not logout if they wish to be logged in automatically when they return.


Using TFLogin's email confirmation for your own purposes

You can cause TFLogin to send an email confirmation message and evaluate a block that you provide when the user navigates to the confirmation URL. This feature uses the same mechanism as is used for registration confirmation, username reminders, password resets, and account change confirmations.

The TLPendingUserAction is a subclass of TLUser and is a copy of the user for which the action is being confirmed. The confirm block that you provide is passed the TLPendingUser object. Note that when it is evaluated, the session context will be different than when the pending action was queued.

Here is an example from TLTestApp. Other referenced methods can be seen in the TLTestApp source code.
```smalltalk
confirmWithUser
    | url userAction |
        "Instantiate a TLPendingUserAction object for your user and
        provide a one-argument block to be evaluated when the user confirms."
        userAction := TLPendingUserAction 
            forUser: self session user
            onConfirmDo: [ :confirmedAction |
                "In our action we will log the user in and set a flag indicating that
                they have confirmed."
                loginComponent loginUserById: confirmedAction userId.
                self testConfirmed: true ].
	
        "Queue the pending user action. It will remain active for the configured
        confirmation timeout period. This method answers the confirmation URL
        to which the user must navigate to confirm the action." 
        url := loginComponent addPendingUserAction: userAction.
	
        "Send a confirmation email to the user."
        self
            sendTestConfirmationUrl: url
            to: self session user email
            timeout: (self application preferenceAt: #confirmationTimeoutMinutes)	
```

New user initialization

If you provide a one-argument block to the TLLoginComponent>>#onRegistration: method, your block will be evaluated with pending new user objects before the registration email confirmation (if any) is sent. Your block should answer true to allow the registration to proceed, or false to cancel the registration without further interaction with the user. If you return false, you should arrange to inform the user as to why their registration attempt is being rejected.

In your onRegistration block, you can populate the new user's applicationProperties dictionary with initial values. This can be useful if, for example, you have allowed an unregistered user to work at your website and for them to save their work you require them to register for an account. Since the registration confirmation will take place in another session the question arises as to where to save their work during the registration confirmation process (and how to dispose of it if the registration is not confirmed.) Saving the user's work in the pending user object's applicationProperties dictionary provides the answer. When the new user logs in the first time, anything placed in their applicationProperties dictionary in the onRegister block will be present in their TLSession user object.

Here is an example onRegistration block in which userObjects are saved in the pending user's applicationProperties:
```smalltalk
	loginComponent: onRegistration: [ :pendingUser | 
		pendingUser applicationProperties
			at: 'userObjects'
			put: self userObjects.
		true]
```

## Appearance

The components used by TFLogin are generally quite plain. CSS class names are present to allow you to use whatever CSS you need to allow them to blend in with your application.

If more customization is needed, you can substitute your own components for the default ones by setting the component class to be used. Where you see a defaultXxxComponent method where XxxComponent is the component you wish to replace, use method XxxComponent: to specity your replacement component class.

## Persistence

Persistence is accomplished by TLAuthenticationManager using an instance of TLStorageAdaptor. The default storage adaptor is TLCachingFileStorageAdaptor (see below). To use a different persistence mechanism, derive a new class from TLStorageAdaptor, implementing the subclassResponsibility methods. Then, in your application's initialization method, after instantiating TLLoginComponent set the storage adaptor like this:
```smalltalk
    myTLLoginComponent authenticationManager storageAdaptor: MyStorageAdaptor new. 
```
Note that pending unconfirmed user registrations, account changes, and password resets are not persisted and thus if the Smalltalk image is terminated without saving, they will be lost.

## TLFileStorageAdaptor 

The default storage adaptor may, in some cases, serve all of your application's persistence needs. TLCachingFileStorageAdaptor uses  an instance of TLMultiFileDatabase to manage file-based persistence of TLRegisteredUser objects. Each user object is read and written individually to its own file.

Numbered versions of each user file are maintained. By default, two versions are retained for each user. The files are named with the userId, the base36-encoded username and the base36-encoded email address. This allows TLCachingFileStorageAdaptor to use the file system's wildcarding support to select files by userId, username, or email address. Base-36 encoding is used to ensure that no characters disallowed by the file system appear in the filenames.

The default database directory created in the Pharo Contents/Resources directory is named app-nameUserDb where app-name is the value passed as the TLLoginComponent class>>#appName: during initialization.

TLCachingFileStorageAdaptor caches (by default) the 100 most recently accessed user objects and all usernames and associated userIds. File writes are queued to a background writer process to avoid delaying response to the user. Files are spread across an automatically-created sub-directory tree to avoid the performance penalty that occurs when a very large number of files is present in a single directory. TLCachingFileStorageAdaptor has been tested with 100,000 users and performs well with that user population.

## Application Properties

RegisteredUser contains a dictionary accessed by the #applicationProperties method that is by default empty. The host application may store arbitrary per-user objects in the dictionary or instances of subclasses of TLApplicationPropertyItem.

Objects placed in the applicationProperties of RegisteredUsers are saved and restored along with the rest of the user information. Applications can cause the current user to be saved, perhaps after having updated applicationProperties, with the TLLoginComponent >>#saveUser method.

Depending on the values of its settings, TLApplicationPropertyItem objects may optionally be included in the information displayed and optionally edited by the user in the TLEditAccountComponent. Objects not derived from TLApplicationPropertyItem found in the application properties dictionary are ignored by the TLEditAccountComponent.


## Re-initialization

To remove all pending actions such as password resets, new registrations, and account changes, evaluate 
```smalltalk
	TLAuthenticationManager  initialize.
```
To delete the user database, evaluate "(TLFileStorageAdaptor name: <app-name>) deleteDatabase" where app-name is your application name as provided in TLLoginComponent>>initialize. Example:
```smalltalk
      (TLFileStorageAdaptor name: 'LoginTestApp') deleteDatabase
```
Alternatively, you could delete the directory named <app-name>UserDb in the Pharo Contents/Resources directory.







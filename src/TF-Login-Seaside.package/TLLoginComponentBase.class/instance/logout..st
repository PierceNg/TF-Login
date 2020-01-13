login-logout
logout: aSession
	"For logging out when called from another session. aSession is actually my session. (When called from another
	session, self session returns that other session.) This method allows a session to log out other sessions." 
	self clearLoginCookie: aSession.
	aSession user: nil
	
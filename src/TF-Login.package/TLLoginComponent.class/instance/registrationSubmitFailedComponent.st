registration
registrationSubmitFailedComponent
	^ registrationSubmitFailedComponent ifNil: [ self defaultRegistrationSubmitFailedComponent ]
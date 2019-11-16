initialization
initialize 
	Lock := Semaphore forMutualExclusion.
	PendingActions := Dictionary new.
accessing
pendingActions: aDictionary
	"Answer the pending actions list for our appName."
	PendingActions at: self appName put: aDictionary 
testing
isValid: clientSideContent
	^ (clientSideContent = self clientSideContent) & (self isExpired not)
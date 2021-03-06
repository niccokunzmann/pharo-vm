initialization
initializeInterpreter: bytesToShift 
	"Initialize Interpreter state before starting execution of a new image."
	interpreterProxy := self sqGetInterpreterProxy.
	self dummyReferToProxy.
	objectMemory initializeObjectMemory: bytesToShift.
	self checkAssumedCompactClasses.
	primFailCode := 0.
	self initializeExtraClassInstVarIndices.
	stackLimit := 0. "This is also the initialization flag for the stack system."
	stackPage := overflowedPage := 0.
	extraFramesToMoveOnOverflow := 0.
	method := objectMemory nilObject.
	self cCode: [self cppIf: MULTIPLEBYTECODESETS ifTrue: [bytecodeSetSelector := 0]]
		inSmalltalk: [bytecodeSetSelector := 0].
	messageSelector := objectMemory nilObject.
	newMethod := objectMemory nilObject.
	lkupClass := objectMemory nilObject.
	self flushMethodCache.
	self flushAtCache.
	self initialCleanup.
	highestRunnableProcessPriority := 0.
	nextProfileTick := 0.
	profileSemaphore := objectMemory nilObject.
	profileProcess := objectMemory nilObject.
	profileMethod := objectMemory nilObject.
	nextPollUsecs := 0.
	nextWakeupUsecs := 0.
	tempOop := 0.
	interruptKeycode := 2094. "cmd-. as used for Mac but no other OS"
	interruptPending := false.
	inIOProcessEvents := 0.
	deferDisplayUpdates := false.
	pendingFinalizationSignals := statPendingFinalizationSignals := 0.
	globalSessionID := 0.
	[globalSessionID = 0]
		whileTrue: [globalSessionID := self
						cCode: 'time(NULL) + ioMSecs()'
						inSmalltalk: [(Random new next * SmallInteger maxVal) asInteger]].
	jmpDepth := 0.
	longRunningPrimitiveStartUsecs :=
	longRunningPrimitiveStopUsecs := 0.
	maxExtSemTabSizeSet := false.
	statForceInterruptCheck := 0.
	statStackOverflow := 0.
	statCheckForEvents := 0.
	statProcessSwitch := 0.
	statIOProcessEvents := 0.
	statStackPageDivorce := 0
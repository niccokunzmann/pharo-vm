common selector sends
bytecodePrimValueWithArg
	"In-line value: for BlockClosure and BlockContext"
	| maybeBlock rcvrClass |
	maybeBlock := self internalStackValue: 1.
	argumentCount := 1.
	successFlag := true.
	(self isNonIntegerObject: maybeBlock) ifTrue:
		[rcvrClass := self fetchClassOfNonInt: maybeBlock.
		 rcvrClass = (self splObj: ClassBlockClosure)
			ifTrue:
				[self externalizeIPandSP.
				 self primitiveClosureValue.
				 self internalizeIPandSP]
			ifFalse:
				[rcvrClass = (self splObj: ClassBlockContext)
					ifTrue:
						[self externalizeIPandSP.
						 self primitiveValue.
						 self internalizeIPandSP]
					ifFalse:
						[successFlag := false]]].
	successFlag ifFalse:
		[messageSelector := self specialSelector: 26.
		 ^self normalSend].
	self fetchNextBytecode
inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceeding followingAddress."
	^  ((objectMemory byteAt: followingAddress - 1) << 24)
	+  ((objectMemory byteAt: followingAddress - 2) << 16)
	+  ((objectMemory byteAt: followingAddress - 3) << 8)
	+   (objectMemory byteAt: followingAddress - 4)
bytecode generators
genPushNewArrayBytecode
	| size popValues |
	self assert: needsFrame.
	popValues := byte1 > 127.
	size := byte1 bitAnd: 127.
	self MoveCq: size R: SendNumArgsReg.
	self CallRT: ceCreateNewArrayTrampoline.
	popValues ifTrue:
		[size - 1 to: 0 by: -1 do:
			[:i|
			self PopR: TempReg.
			objectRepresentation
				genStoreSourceReg: TempReg
				slotIndex: i
				intoNewObjectInDestReg: ReceiverResultReg]].
	self PushR: ReceiverResultReg.
	^0
translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #memory
		declareC: 'static usqInt memory'.
	aCCodeGenerator
		var: #remapBuffer
		declareC: 'sqInt remapBuffer[RemapBufferSize + 1 /* ', (RemapBufferSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #rootTable
		declareC: 'sqInt rootTable[RootTableSize + 1 /* ', (RootTableSize + 1) printString, ' */]'.
	"Weak roots must be large enough for roots+remapBuffer+sizeof(allCallsOn: #markAndTrace:)"
	aCCodeGenerator
		var: #weakRoots
		declareC: 'sqInt weakRoots[WeakRootTableSize + 1 /* ', (WeakRootTableSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #headerTypeBytes
		declareC: 'sqInt headerTypeBytes[4]'.
	aCCodeGenerator
		var: #extraRoots
		declareC: 'sqInt* extraRoots[ExtraRootSize + 1 /* ', (ExtraRootSize + 1) printString, ' */]'.
	self declareCAsOop: {
			#youngStart .
			#endOfMemory .
			#memoryLimit .
			#youngStartLocal .
			#freeBlock .
			#compStart .
			#compEnd .
			#fwdTableNext .
			#fwdTableLast .
			#gcBiasToGrowThreshold }
		in: aCCodeGenerator.
	aCCodeGenerator
		var: #headerTypeBytes type: 'const sqInt' array: HeaderTypeExtraBytes.
	self declareC: #(gcStartUsecs statFullGCUsecs statIncrGCUsecs statIGCDeltaUsecs)
		as: #usqLong
		in: aCCodeGenerator
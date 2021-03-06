*VMMaker-JITSimulation
unsignedLongAt: byteIndex bigEndian: bigEndian
	"Compatiblity with the ByteArray method of the same name."
	| lowBits wordIndex value word0 word1 |
	lowBits := byteIndex - 1 bitAnd: 3.
	wordIndex := byteIndex - 1 // 4 + 1.
	lowBits = 0
		ifTrue:
			[value := self at: wordIndex]
		ifFalse:
			[word0 := self at: wordIndex.
			 word1 := self at: wordIndex + 1.
			 value := 16rFFFFFFFF bitAnd: word0 << (lowBits * 8) + (word1 >> (4 - lowBits * 8))].
	bigEndian ifFalse:
		[value := (value >> 24 bitAnd: 16rFF)
				 + (value >> 8 bitAnd: 16rFF00)
 				 + ((value bitAnd: 16rFF00) << 8)
				 + ((value bitAnd: 16rFF) << 24)].
	^value

	"| bm ba |
	(bm := Bitmap new: 4)
		at: 1 put: 16r01234567;
		at: 2 put: 16r89ABCDEF;
		at: 3 put: 16r89ABCDEF;
		at: 4 put: 16r01234567.
	ba := bm asByteArray.
	(((1 to: 5), (9 to: 13) select:
		[:bi| (bm unsignedLongAt: bi bigEndian: true) ~= (ba unsignedLongAt: bi bigEndian: true)]) collect:
			[:i| { i. (bm unsignedLongAt: i bigEndian: true) hex. (ba unsignedLongAt: i bigEndian: true) hex}]),
	(((1 to: 5), (9 to: 13) select:
		[:bi| (bm unsignedLongAt: bi bigEndian: false) ~= (ba unsignedLongAt: bi bigEndian: false)]) collect:
			[:i| { i. (bm unsignedLongAt: i bigEndian: false) hex. (ba unsignedLongAt: i bigEndian: false) hex}])"
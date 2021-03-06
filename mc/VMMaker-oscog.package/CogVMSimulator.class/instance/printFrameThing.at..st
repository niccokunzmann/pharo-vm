debug printing
printFrameThing: name at: address
	| it |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHex: address;
		printChar: $:.
	1 to: 12 - (self strlen: name) do: [:i| self printChar: $ ].
	self print: name;
		print: ': ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it.
		 (it between: objectMemory startOfMemory and: objectMemory endOfMemory) ifFalse:
			[(cogit lookupAddress: it) ifNotNil:
				[:label| self space; printChar: $(; print: label; printChar: $)]]].
	self cr
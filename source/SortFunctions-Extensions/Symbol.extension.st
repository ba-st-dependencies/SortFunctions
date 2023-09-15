Extension { #name : #Symbol }

{ #category : #'*SortFunctions-Extensions' }
Symbol >> asSortFunction [
	"Return a SortFunction around the receiver, where the receiver will be used as a unary message to send to both a and b during sorting, and then the result of said send will be collated in ascending order using the <=> method."
	"(#('abc' 'de' 'fghi') sorted: #size ascending) >>> #('de' 'abc' 'fghi')"

	^PropertySortFunction property: self
]

{ #category : #'*SortFunctions-Extensions' }
Symbol >> ascending [
	"Return a SortFunction around the receiver, where the receiver will be used as a unary message to send to both a and b during sorting, and then the result of said send will be collated in ascending order using the <=> method."
	"(#('abc' 'de' 'fghi') sorted: #size ascending) >>> #('de' 'abc' 'fghi')"

	^self asSortFunction
]

{ #category : #'*SortFunctions-Extensions' }
Symbol >> collatedBy: aSortFunction [
	"Return a SortFunction around the receiver, where the receiver will be used as a unary message to send to both a and b during sorting, and then the result of said send will be collated iusing aSortFunction."
	"(#('abc' 'de' 'fghi') sorted: (#size collatedBy: [:e|e bitAnd: 1]) , #size) >>> #( 'de' 'fghi' 'abc')"

	^PropertySortFunction property: self collatedWith: aSortFunction asSortFunction
]

{ #category : #'*SortFunctions-Extensions' }
Symbol >> descending [
	"Return a SortFunction around the receiver, where the receiver will be used as a unary message to send to both a and b during sorting, and then the result of said send will be collated in descending order using the <=> method."
	"(#('abc' 'de' 'fghi') sorted: #size descending) >>> #('fghi' 'abc' 'de')"

	^self asSortFunction reversed
]

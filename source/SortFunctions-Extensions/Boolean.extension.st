Extension { #name : #Boolean }

{ #category : #'*SortFunctions-Extensions' }
Boolean >> threeWayCompareTo: anotherObject [
	^ self asBit threeWayCompareTo: anotherObject asBit
]

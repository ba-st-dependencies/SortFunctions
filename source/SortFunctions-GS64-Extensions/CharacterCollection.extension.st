Extension { #name : #CharacterCollection }

{ #category : #'*SortFunctions-GS64-Extensions' }
CharacterCollection >> threeWayCompareTo: aString [

	^ self compareTo: aString collator: nil
]

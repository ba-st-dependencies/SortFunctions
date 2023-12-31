"
Unit test for sort functions
"
Class {
	#name : #SortFunctionTest,
	#superclass : #TestCase,
	#category : #'SortFunctions-Tests'
}

{ #category : #tests }
SortFunctionTest >> testAsSortFunction [

	| function |
	function := #name ascending.
	self assert: function equals: function asSortFunction.
	function := #name asSortFunction.
	self assert: function equals: function asSortFunction.
	function := [ :each | each name ] ascending.
	self assert: function equals: function asSortFunction.
	function := [ :x :y | x threeWayCompareTo: y ] asSortFunction.
	self assert: function equals: function asSortFunction
]

{ #category : #tests }
SortFunctionTest >> testComparisonOfFunctionsDefinedByBlock [
	| collatorBlock |
	collatorBlock := [ :a :b | 1 ].

	self assert: collatorBlock ascending equals: collatorBlock ascending.
	self assert: collatorBlock ascending hash equals: collatorBlock ascending hash.

	self deny: collatorBlock ascending equals: collatorBlock descending.
	self deny: collatorBlock ascending equals: [ :a :b | -1 ] ascending
]

{ #category : #tests }
SortFunctionTest >> testComparisonOfFunctionsDefinedBySymbol [

	self assert: #name ascending equals: #name ascending.
	self assert: #name ascending hash equals: #name ascending hash.

	self deny: #name ascending equals: #name descending.
	self deny: #name ascending equals: #name2 ascending.
	self deny: #name ascending undefinedFirst equals: #name ascending undefinedLast
]

{ #category : #tests }
SortFunctionTest >> testInversion [

	| function |
	function := #key ascending.
	self assert: (function value: 0 -> 2 value: 1 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 1).
	self deny: (function value: 2 -> 2 value: 1 -> 1).
	function := function reversed.
	self deny: (function value: 1 -> 2 value: 2 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 1).
	self assert: (function value: 2 -> 2 value: 1 -> 1).
	function := function reversed.
	self assert: (function value: 0 -> 2 value: 1 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 1).
	self deny: (function value: 2 -> 2 value: 1 -> 1)
]

{ #category : #'tests - sorting' }
SortFunctionTest >> testPropertyWithOddCollator [

	| oddFirst function data sorted |
	oddFirst := [:a :b | (b bitAnd: 1) - (a bitAnd: 1)].
	function := (#value collatedBy: oddFirst) , #value , #key.
	data := { 1 -> 10. 5 -> 5. 10 -> 4. 3 -> 8. 1 -> 1. 10 -> 10 }.
	sorted := data sorted: function.
	self assert: sorted equals: { 1 -> 1. 5 -> 5. 10 -> 4. 3 -> 8. 1 -> 10. 10 -> 10 }
]

{ #category : #tests }
SortFunctionTest >> testSingleArgBlock [

	| function block |
	block := [:association | association key / association value].
	function := block ascending.
	self assert: (function value: 0 -> 2 value: 1 -> 1).
	self assert: (function value: 1 -> 2 value: 2 -> 4).
	self deny: (function value: 2 -> 2 value: 1 -> 2).
	function := block descending.
	self deny: (function value: 1 -> 2 value: 2 -> 1).
	self assert: (function value: 2 -> 2 value: 1 -> 1).
	self assert: (function value: 3 -> 2 value: 1 -> 1)
]

{ #category : #tests }
SortFunctionTest >> testSortUsingBooleans [
	| data |
	data := #(1 2 3 4 5).
	self assert: (data sorted: #odd ascending) equals: #(2 4 1 3 5)
]

{ #category : #'tests - sorting' }
SortFunctionTest >> testSorting [
	| data sorted |
	data := { 2 -> 10. 5 -> 5. 10 -> 4. 3 -> 8. 1 -> 1. 11 -> 11 }.
	sorted := data sorted: #key ascending.
	self assert: sorted equals: { 1 -> 1. 2 -> 10. 3 -> 8. 5 -> 5. 10 -> 4. 11 -> 11 }.
	sorted := data sorted: #key descending.
	self assert: sorted equals: { 11 -> 11. 10 -> 4. 5 -> 5. 3 -> 8. 2 -> 10. 1 -> 1 }.
	sorted := data sorted: [ :each | each value ] ascending.
	self assert: sorted equals: { 1 -> 1. 10 -> 4. 5 -> 5. 3 -> 8. 2 -> 10. 11 -> 11 }.
	sorted := data sorted: [ :each | each value * 100.0 ] descending.
	self assert: sorted equals: { 11 -> 11. 2 -> 10. 3 -> 8. 5 -> 5. 10 -> 4. 1 -> 1 }
]

{ #category : #'tests - sorting' }
SortFunctionTest >> testSortingChained [
	| data sorted |
	data := { 1 -> 10. 5 -> 5. 10 -> 4. 3 -> 8. 1 -> 1. 10 -> 10 }.
	sorted := data sorted: #key ascending , #value ascending.
	self assert: sorted equals: { 1 -> 1. 1 -> 10. 3 -> 8. 5 -> 5. 10 -> 4. 10 -> 10 }.
	sorted := data sorted: #key ascending , #value descending.
	self assert: sorted equals: { 1 -> 10. 1 -> 1. 3 -> 8. 5 -> 5. 10 -> 10. 10 -> 4 }
]

{ #category : #'tests - sorting' }
SortFunctionTest >> testSortingChainedWithUndefined [
	| data sorted |
	data := { 1 -> 10. 5 -> 5. 10 -> 4. 10 -> nil. 3 -> 8. 1 -> 1. 10 -> 10 }.
	sorted := data sorted: #key ascending , #value ascending undefinedFirst.
	self assert: sorted equals: { 1 -> 1. 1 -> 10. 3 -> 8. 5 -> 5. 10 -> nil. 10 -> 4. 10 -> 10 }.
	sorted := data sorted: #key ascending , #value descending undefinedLast.
	self assert: sorted equals: { 1 -> 10. 1 -> 1. 3 -> 8. 5 -> 5. 10 -> 10. 10 -> 4. 10 -> nil }
]

{ #category : #'tests - sorting' }
SortFunctionTest >> testSortingWithUndefined [

	| data sorted |
	data := { 2 -> 10. 5 -> 5. 10 -> 4. nil -> nil. 3 -> 8. 1 -> 1. 11 -> 11 }.
	sorted := data sorted: #key ascending undefinedFirst.
	self assert: sorted equals: { nil -> nil. 1 -> 1. 2 -> 10. 3 -> 8. 5 -> 5. 10 -> 4. 11 -> 11 }.
	sorted := data sorted: #key descending undefinedLast.
	self assert: sorted equals: { 11 -> 11. 10 -> 4. 5 -> 5. 3 -> 8. 2 -> 10. 1 -> 1. nil -> nil }.
	sorted := data sorted: #value ascending undefinedLast.
	self assert: sorted equals: { 1 -> 1. 10 -> 4. 5 -> 5. 3 -> 8. 2 -> 10. 11 -> 11. nil -> nil }.
	sorted := data sorted: #value descending undefinedFirst.
	self assert: sorted equals: { nil -> nil. 11 -> 11. 2 -> 10. 3 -> 8. 5 -> 5. 10 -> 4. 1 -> 1 }
]

{ #category : #tests }
SortFunctionTest >> testTwoArgBlock [

	| function block |
	block :=
			[:a :b |
			a odd = b odd ifTrue: [0] ifFalse: [a odd ifTrue: [-1] ifFalse: [1]]].
	function := block ascending.
	self assert: (function value: 2 value: 4).
	self assert: (function value: 1 value: 3).
	self assert: (function value: 1 value: 4).
	self deny: (function value: -2 value: 1).
	function := block descending.
	self assert: (function value: 2 value: 4).
	self assert: (function value: 1 value: 3).
	self deny: (function value: 1 value: 4).
	self assert: (function value: -2 value: 1)
]

{ #category : #tests }
SortFunctionTest >> testUnarySymbol [

	| function |
	function := #key ascending.
	self assert: (function value: 0 -> 2 value: 1 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 1).
	self deny: (function value: 2 -> 2 value: 1 -> 1).
	function := #key descending.
	self deny: (function value: 1 -> 2 value: 2 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 1).
	self assert: (function value: 2 -> 2 value: 1 -> 1)
]

{ #category : #tests }
SortFunctionTest >> testUndefinedFirstUnary [

	| function |
	function := #value ascending undefinedFirst.
	self assert: (function value: 0 -> nil value: 1 -> 1).
	self assert: (function value: 1 -> 2 value: 1 -> 2).
	self deny: (function value: 2 -> 2 value: 1 -> 1).
	function := #value descending undefinedFirst.
	self assert: (function value: 1 -> nil value: 2 -> 1).
	self deny: (function value: 1 -> 2 value: 1 -> 3).
	self deny: (function value: 2 -> 2 value: 1 -> 3)
]

{ #category : #tests }
SortFunctionTest >> testUndefinedLastUnary [

	| function |
	function := #value ascending undefinedLast.
	self assert: (function value: 0 -> 2 value: 1 -> nil).
	self assert: (function value: 1 -> 2 value: 1 -> 2).
	self deny: (function value: 2 -> 2 value: 1 -> 1).
	function := #value descending undefinedLast.
	self assert: (function value: 1 -> 2 value: 2 -> nil).
	self deny: (function value: 1 -> 2 value: 1 -> 3).
	self deny: (function value: 2 -> 2 value: 1 -> 3)
]

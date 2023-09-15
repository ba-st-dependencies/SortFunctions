Class {
	#name : #BaselineOfSortFunctions,
	#superclass : #BaselineOf,
	#category : #BaselineOfSortFunctions
}

{ #category : #baselines }
BaselineOfSortFunctions >> baseline: spec [

	<baseline>
	spec for: #pharo do: [
		spec
			package: 'SortFunctions-Core';
			package: 'SortFunctions-Extensions'
			with: [ spec requires: 'SortFunctions-Core' ];
			package: 'SortFunctions-Pharo-Extensions'
			with: [ spec requires: 'SortFunctions-Core' ];
			package: 'SortFunctions-Tests' with: [
				spec requires:
						#( 'SortFunctions-Extensions' 'SortFunctions-Pharo-Extensions' ) ].
		spec
			group: 'Core'
			with: #( 'SortFunctions-Core' 'SortFunctions-Extensions'
				   'SortFunctions-Pharo-Extensions' );
			group: 'Tests' with: 'SortFunctions-Tests';
			group: 'default' with: #( 'Core' 'Tests' ) ]
]

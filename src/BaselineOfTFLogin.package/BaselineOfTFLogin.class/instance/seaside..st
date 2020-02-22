baselines
seaside: spec

	spec for: #loadSeaside do: [ 
		spec baseline: 'Seaside3' with: [ 
			spec
				loads: #('default');
				repository: 'github://SeasideSt/Seaside:master/repository' ]]
		
"Conditional loading - #loadSeaside is set in #customProjectAttributes."
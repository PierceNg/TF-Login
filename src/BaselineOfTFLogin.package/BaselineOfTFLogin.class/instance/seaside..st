baselines
seaside: spec

	(self class environment classNamed: #WAObject) ifNil: [
		spec baseline: 'Seaside3' with: [ 
			spec
				loads: #('default');
				repository: 'github://SeasideSt/Seaside:master/repository' ]]
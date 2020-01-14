baselines
baseline: spec
	<baseline>
	
	spec for: #'common' do: [
		spec blessing: #baseline.	
		self soup: spec.
		self cryptography: spec.
		spec
			package: 'TF-Login-Password' with: [ spec requires: #('Cryptography') ];
			package: 'TF-Login-Core' with: [ spec requires: #('TF-Login-Password') ];
			package: 'TF-Login-Seaside' with: [ spec requires: #('TF-Login-Core') ];
			package: 'TF-Login-Tests' with: [ spec requires: #('TF-Login-Core' 'TF-Login-Seaside' 'Soup') ].
		spec
			group: 'Core' with: #('TF-Login-Password' 'TF-Login-Core' 'TF-Login-Seaside');
			group: 'Tests' with: #('TF-Login-Tests');
			group: 'default' with: #('Core' 'Tests') ]
		
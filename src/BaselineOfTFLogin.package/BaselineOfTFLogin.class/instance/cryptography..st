baselines
cryptography: spec

	spec baseline: 'Cryptography' with: [ 
		spec 
			loads: #('default' 'PBKDF2' 'PBKDF2-Tests'); 
			repository: 'github://pharo-contributions/Cryptography/source' ].

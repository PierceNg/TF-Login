Baseline to load TF-Login. This baseline loads Seaside if Seaside is not already loaded.

If you are starting with a fresh Seaside-less image, then:

```smalltalk
Metacello new
	baseline: 'TFLogin';
	repository: 'github://PierceNg/TF-Login:pharo7/src';
	load.
```	
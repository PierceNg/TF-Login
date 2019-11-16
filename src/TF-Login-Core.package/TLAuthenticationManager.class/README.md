I am TLAuthenticationManager. I manage user accounts.

Persistence is accomplished using an instance of TLStorageAdaptor. The default storage adaptor is TLCachingFileStorageAdaptor. To use a different persistence mechanism, derive a new class from TLStorageAdaptor, implementing the subclassResponsibility methods. Then, in your application's initialization method, after instantiating TLLoginComponent set the storage adaptor like this:

```smalltalk 
myTLLoginComponent authenticationManager storageAdaptor: MyStorageAdaptor new. 
```

Note that pending unconfirmed user registrations, account changes, and password resets are not persisted and thus if the Smalltalk image is terminated without saving, they will be lost.
# GPG Keys

## Why to use?
GnuPG is a tool you use to protect your privacy. Your privacy is protected if you can correspond with others without eavesdroppers reading those messages.

## Install

Linux
```
apt-get install gnupg
```

macOS
```
brew install gnupg
```

## Generate Keys
Necessary if you expect to receive encrypted messages is a key pair. A public key that you can distribute on the internet as freely as you see fit and a private key which should be guarded and protected.

gpg provides a command option for this:
```
$ gpg --gen-key
```

If you are able to create a key successfully it should be in your list of keys, both the secret list and the public list:

```
$ gpg --list-keys
$ gpg --list-secrety-keys

/home/josh/.gnupg/secring.gpg
-----------------------------
sec   1024D/D0FE7AFB 2004-06-24
uid                  Josh Triplett
uid                  Josh Triplett
ssb   2048g/E75EAB2B 2004-06-24
```

## Publish on Keyserver
To send your key to a keyserver, you need to know your key ID. You can print the information on all keys you have the private key for by running **gpg --list-secret-keys**. This will generate output similar to the following:
```
/home/josh/.gnupg/secring.gpg
-----------------------------
sec   1024D/D0FE7AFB 2004-06-24
uid                  Josh Triplett
uid                  Josh Triplett
ssb   2048g/E75EAB2B 2004-06-24
```

From this, you can see my primary key ID, D0FE7AFB.
Now that you know your key ID, you can send your public key to the default keyserver with the --send-keys option:
```
$ gpg --send-keys D0FE7AFB
gpg: sending key D0FE7AFB to hkp server subkeys.pgp.net
```

# Slackscan and Slackup

## Introduction

The primary location of this project is:
https://github.com/glangshaw/slackscan

If you find any bugs/issues with any of them, please drop a note
to me at: gary.langshaw@gmail.com.

## slackscan

'slackscan' is a bash script that will recursively search the
locations specified in its config file for files matching the
Slackware package file naming conventions.  It will then compare the
installed packages of the host system to those found in the configured
locations and will generate lists of packages that should be
installed, upgraded or removed in order to bring the installed system
in sync with the packages available.

'slackscan' makes no changes to the installed system, its role is to
generate lists, which are written to the files specified by the -i, -u
and -r options.

Adhering to "The UNIX Philosophy", these lists may then in turn be
acted upon by other utilities.

One such utility is provied with slackscan and is named
slackscan_update_generator, another is slackup.

### slackscan_update_generator

This is an awk-script that will take the output generated by
slackscan's -i or -u options and generate a list of pkgtools'
upgradepkg commands for them.  The output of this awk-script can then
be passed to the shell for execution

When remote package URLS are encountered, 'curl' commands will be
added to the output stream in order to fetch them.  gpg --verify
commadns will also be included in the stream.

### slackup

'slackup' is a front end for slackscan which adds additional functionality
such as command-line patterm matching to limit operation to a subset of
packaes, and support for post-install scripts.

# PGP-KEY

All tags in this repo are signed with the following pgp-key, which is
available in the [PGP-KEY](PGP-KEY) file in this repo.
```
pub   2048R/97A08CC2 2015-08-27
      Key fingerprint = A497 723B 3AC6 8724 BB8D  BBC6 B208 65B9 97A0 8CC2
uid                  Gary Langshaw <gary.langshaw@gmail.com>
sub   2048R/1BB01B7E 2015-08-27
```

It would be better if you could get the key from somewhere else, but
with all the keyservers shutting down over GDPR "Right to be
forgotten" abuses, it'll have to do for now.


# Final words

I hope other slackware users may find them useful, but if not, that's
ok.  I wrote them for my own use.

Also, you may want to checkout my 'slackup' script, which is a front
end to slackscan that adds additional functionality.
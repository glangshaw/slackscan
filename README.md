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


### slackup

'slackup' is a front-end for slackscan which invokes slackscan and
generates on stdout, the stream of package-management commands
necessary to action any identified changes. If asked, it can also
directly execute the generated commands, but a prudent user will
likely want to examine them first.

'slackup' adds additional functionality such as command-line patterm
matching to limit operation to a subset of packages, and support for
the automated running of post-install scripts.

An update run using slackup might look like this:
```
slackup -sic | tee updates.sh
sh updates.sh
```

Or, if you like living dangerously, and don't want to check what is
about to be done to your system, just: `slackup -six`


### slackscan_update_generator

Unlike 'slackup' which is a front-end, this is a simple awk-script
that will take the already generated output of slackscan's -i or -u
options and convert them into a list of Slackware's 'pkgtools'
upgradepkg commands.  The output of this awk-script may then be passed
to the shell for execution.

When remote package URLS are encountered, 'curl' commands will be
added to the output stream in order to fetch them.  gpg --verify
commands will also be included in the stream.

Package removals are not catered for since they can be easily actioned
without any further modification using something like xargs.

An example update run using slackscan and slackscan_update_generator
might look something like this:
```
slackscan -i install.list -u update.list -r remove.list
cat install.list update.list | slackscan_update_generator | sh
xargs -r removepkg < remove.list
```


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

I hope other Slackware users may find these useful, but if not, that's
ok.  I wrote them for my own use.

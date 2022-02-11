# Slackscan

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
slackscan_update_generator.

### slackscan_update_generator

This is an awk-script that will take the output generated by
slackscan's -i or -u options and generate a list of pkgtools'
upgradepkg commands for them.  The output of this awk-script can then
be passed to the shell for execution

When remote package URLS are encountered, 'curl' commands will be
added to the output stream in order to fetch them.  gpg --verify
commadns will also be included in the stream.

### configuration

The configuration file is simply an ordered list of locations where
package files may be found.

A location may be either a local directory, or a http/https URL
pointing to a remote CHECKSUMS.md5 file.

The default configuration file for 'slackscan' is /etc/slackscan/default.conf

### usage

Usage is pretty simple, just specify where you want the output to go
```
Usage:
         slackscan [ -N ] [ -f filename ] [-i filename ] [ -u filename ] [ -r filename ] 

           where, 
             -f :   specifies the filename of the config file
             -p :   specifies slackup profile name as alternative way to select a config file
             -i :   specifies file to hold list of packages to be installed. 
             -u :   specifies file to hold list of packages to be upgraded. 
             -r :   specifies file to hold list of packages to be removed. 
             -N :   skip 'gpg --verify' of downloaded CHECKSUMS.md5 files (INSECURE). 
```

An example update run might look something along the lines of the
following, though you will likely want to include some grep in your
pipelines to include/exclude certain packages:
```
# slackscan -i install.list -u upgrade.list -r remove.list
# cat install.list upgrade.list | slackscan_updatre_generator | sh
# xargs -r -- removepkg <remove.list
```


### Some Important Notes on Usage

  - Installed packages that are no longer available in any configured
    location will be included in the removal list generated by slackscan.
    If you routinely delete package files after installing them you
    will need to prevent their removal by using grep -v on the generated
    lists prior to passing it to a removal utility.

    Personally, I favour keeping packages around until you're done with
    them.

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
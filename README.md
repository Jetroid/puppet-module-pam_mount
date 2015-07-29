# pam_mount

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Parameters](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs and configures the pam_mount module.

pam_mount mounts and unmounts volumes from a central filesystem. 

## Parameters

config
------

This parameter defines the contents of /etc/security/pam_mount.conf.xml
It should follow the following structure (Example using Ruby syntax):
[
  ['tagName1',{'parameter' => 'value'}],
  ['tagName2',{'parameter1' => 'value1',
             'parameter2' => 'value2',
	     'parameter3' => 'value3',}]
  ['tagname3','string']
]

The above structure would convert to this:
<tagName1 parameter="value"/>
<tageName2 parameter1="value1" parameter2="value2" parameter3="value3"/>
<tagname3>string</tagname3>

The nested arrays must contain exactly two parameters, the first being the name of the tag, 
and the second being the attributes in the form of either a hash or a string.
It is important to note that hashes and string produce different xml output.
Hashes:
['example',{'foo' => 'bar'}] produces <example foo="bar"/>
It is not certain which order the attributes will take, though this is not important in XML. 
Strings:
['example','foobar'] produces <example>foobar</example>

Hiera Example:

++++begin-hiera-yaml-example++++

pam_mount::config:
  - - debug
    - enable: "0"
  - - path
    - "/usr/bin:/usr/local/bin"

++++end-hiera-yaml-example++++

Puppet Example: 

++++begin-puppet-example++++

class {'::pam_mount':
  config = [
    ['debug', {'enable'   => '0'}],
    ['path', '/usr/bin:/usr/local/bin'],
  }

++++end-puppet-example++++

The full output in pam_mount.conf.xml for both of these examples is:


<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE pam_mount SYSTEM "pam_mount.conf.xml.dtd">
<!--
	This file is being maintained by Puppet.
 	DO NOT EDIT
	See pam_mount.conf(5) for a description.
-->

<pam_mount>
<debug enable="0"/>
<path>/usr/bin:/usr/local/bin</path>
</pam_mount>

## Limitations

Tested on Ubuntu 14.04 64bit.

## Release Notes/Contributors/Etc 

0.1.0 - Initial Release 

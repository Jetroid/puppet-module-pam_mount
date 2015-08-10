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

ensure
------

Defines if mounthomedir and its relevant packages are to be installed or removed.

Accepts: 'present', 'absent'
Default: 'present'

pam_mount_package
-----------------

The name of the pam mount package to install.

Accepts: String
Default: Depends on OS family and version.

config_file
-----------

Location of the pam_mount.conf.xml file.

Accepts: String
Default: '/etc/security/pam_mount.conf.xml'

extra_packages
--------------

A list of extra packages to install.

Accepts: Array
Default: []

config
------

This parameter defines the contents of /etc/security/pam_mount.conf.xml
Accepts: It should follow the following structure (Example using Ruby syntax):

```
[
  ['tagName1',{'parameter' => 'value'}],
  ['tagName2',{'parameter1' => 'value1',
             'parameter2' => 'value2',
	     'parameter3' => 'value3',}]
  ['tagname3','string']
]
```

The above structure would convert to this:
```
<tagName1 parameter="value"/>
<tageName2 parameter1="value1" parameter2="value2" parameter3="value3"/>
<tagname3>string</tagname3>
```

The nested arrays must contain exactly two parameters, the first being the name of the tag, 
and the second being the attributes in the form of either a hash or a string.
It is important to note that hashes and string produce different xml output.
Hashes:
['example',{'foo' => 'bar'}] produces <example foo="bar"/>
It is not certain which order the attributes will take, though this is not important in XML. 
Strings:
['example','foobar'] produces <example>foobar</example>

Hiera Example:

```
pam_mount::config:
  - - debug
    - enable: "0"
  - - path
    - "/usr/bin:/usr/local/bin"
```

Puppet Example: 

```
class {'::pam_mount':
  config = [
    ['debug', {'enable'   => '0'}],
    ['path', '/usr/bin:/usr/local/bin'],
  }
```

The full output in pam_mount.conf.xml for both of these examples is:
```
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
```

Default: Results in the following XML:
```<pam_mount>
<debug enable="0"/>
<mntoptions allow="nosuid,nodev,loop,encryption,fsck,nonempty,allow_root,allow_other"/>
<mntoptions require="nosuid,nodev"/>
<logout wait="0" hup="0" term="0" kill="0"/>
<mkmountpoint enable="0" remove="true"/>
</pam_mount>
```
## Limitations

Tested on Ubuntu 14.04 64bit/32bit; Centos 7 64bit; and Centos 6 64bit/32bit.

## Release Notes/Contributors/Etc 

0.1.0 - Initial Release 

# VDSCLI - VMware Distributed Switch CLI

vdscli.pl is single perl script leveraging VMware Perl SDK to emulate following CLI commands
* show mac-address-table
* show interface status

## Why

There are primerly two reasons why. 
1. Network admins like CLI. 
2. Some existing tools expect CLI to do screen scraping mechanism for some kind of automation. CLI emulation helps with integration to such tools.

## How

Before you can use the VDSCLI, you will need to build linux operating system with VMware vCLI. To do so, you need to manually download the vSphere SDK for Perl from VMware's website (which you must register).

* Download vSphere SDK for Perl (which includes vCLI) 6.5 from: https://my.vmware.com/group/vmware/details?downloadGroup=VS-PERL-SDK65&productId=614
* Download vdscli.pl from: https://github.com/davidpasek/vdscli/blob/master/vdscli.pl
* Download supporting shell wraper variables from: https://github.com/davidpasek/vdscli/blob/master/sh-wrapper-env.sh
* Download supporting shell wraper for show mac address table from: https://github.com/davidpasek/vdscli/blob/master/show-mac-address-table.sh
* Download supporting shell wraper for show interface status from: https://github.com/davidpasek/vdscli/blob/master/show-interface-status.sh
* Edit shell wrapper variables file (sh-wrapper-env.sh) with your specific vCenter hostname and credentials
* Now you can run shell wraper script show-mac-address-table.sh or show-interface-status.sh 

## Features

Here is the list of already implemented features
* show commands 
  - show interface
  - show mac-address-table

## Feature Requests

Here is the list of current feature requests
* additional show commands
  - show interface port <DVS-port> ... display details of particular DVS port (input statistics, output statistics, rate info)
  - show virtual-machine ... display virtual machine names and DVS ports where VM is connected
* formating and filtering commands output 
  - command | more - Paginate output
  - command | grep - Show only text that matches a pattern

To submit feature request contact me over a twitter @david_pasek or e-mail david.pasek (at) gmail.com

## Other resources

* [CLI for VMware Virtual Distributed Switch - projet overview](http://blog.igics.com/2017/06/cli-for-vmware-virtual-distributed.html)
* [CLI for VMware Virtual Distributed Switch - implementation procedure](http://blog.igics.com/2017/09/cli-for-vmware-virtual-distributed.html)

## Contact

If you want contact me use twitter handle @david_pasek or e-mail david.pasek (at) gmail.com

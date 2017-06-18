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
* Downlod vdscli.pl from: https://github.com/davidpasek/vdscli/blob/master/vdscli.pl
* Download supporting shell wraper for show mac-address-table from: https://github.com/davidpasek/vdscli/blob/master/show-mac-address-table.sh
* Download supporting shell wraper for show interface status from: https://github.com/davidpasek/vdscli/blob/master/show-interface-status.sh
* Edit shell wrappers with your specific vCenter hostname and credentials

## Contact

If you want contact me use twitter handle @david_pasek to do so.

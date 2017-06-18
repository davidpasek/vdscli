#!/usr/bin/perl -w
# Author: David Pasek
# Website: blog.igics.com

use strict;
use warnings;
use VMware::VILib;
use VMware::VIRuntime;
use Data::Dumper;

my @cmds = ('help','show-mac-address-table','show-port-status');

my %opts = (
   cmd => {
      type => "=s",
      help => "VMware Distributed Switch CLI commands: " . join(',',@cmds),
      required => 0,
   },
);

# validate options, and connect to the server
Opts::add_options(%opts);

# validate options, and connect to the server
Opts::parse();
Opts::validate();
Util::connect();

my $cmd = lc(Opts::get_option('cmd'));
if ( ($cmd eq 'help') || (!($cmd ~~ @cmds)) ) {
  # vds-cli help
  print "Use vds-cli command. Following commands are available.\n";
  print "  help - this help\n";
  print "  show-mac-address-table - show MAC address table of all Virtual Distributed Switches\n";
  print "  show-port-status - show port statuses of all Virtual Distributed Switches\n";
  exit;
}

my ($dvsName, $portId, $connectee, $macaddress, $portgroup, $state, $vlanId);

if ($cmd eq 'show-port-status') {
format OUTPUT_1 =
@<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<< @<<<<<<<
$portId,     $connectee,                    $macaddress,         $portgroup,                                         $state,   $vlanId
.
$~ = 'OUTPUT_1';
} elsif ($cmd eq 'show-mac-address-table') {
format OUTPUT_2 =
@<<<<<<<<< @<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<
$vlanId,   $macaddress,         $connectee,                    $portId,  $portgroup,                                          $state
.
$~ = 'OUTPUT_2';
}

($dvsName, $portId, $connectee, $macaddress, $portgroup, $state, $vlanId) = ('DVS NAME','PORT ID','CONNNECTEE','MAC ADDRESS','DVS - PORTGROUP','STATE','VLAN ID');
write;
$dvsName=$portId=$connectee=$macaddress=$portgroup=$state=$vlanId= '----------------------------------------------------';
write;
$dvsName=$portId=$connectee=$macaddress=$portgroup=$state=$vlanId= '--';

# get all Portgroups uder this vCenter
my %portgroups;
%portgroups = &getAllPortgroups();

# get all Distributed Virtual Switches under this vCenter
my $dvSwitches = Vim::find_entity_views(view_type => 'DistributedVirtualSwitch', properties => ['name','uuid','portgroup']);

foreach my $vds (@$dvSwitches) {
  $dvsName = $vds->name;
  my $vmCriteria = DistributedVirtualSwitchPortCriteria->new(connected => 'true');
  my $dvports = $vds->FetchDVPorts(criteria => $vmCriteria);
  foreach my $dvport (@$dvports) {
    $portId = $dvport->key;
    if (defined($dvport->state->runtimeInfo->linkPeer)) {
      $connectee = $dvport->state->runtimeInfo->linkPeer;
    } else {
      $connectee = "N/A"
    }
    my $dvPort_LinkUp = $dvport->state->runtimeInfo->linkUp;
    if ($dvPort_LinkUp) {$state='up';} else {$state='down';}
    my $dvPort_Blocked = $dvport->state->runtimeInfo->blocked;
    if ($dvPort_Blocked) {$state='blocked';}
    if (defined($dvport->state->runtimeInfo->macAddress)) {
      $macaddress = $dvport->state->runtimeInfo->macAddress;
    } else {
      if ($cmd eq 'show-mac-address-table') {
        next;
      }
      $macaddress = 'N/A';
    }
    $vlanId = $dvport->config->setting->vlan->vlanId;
    if (ref $vlanId eq 'ARRAY') {
      $vlanId = 'trunk';
    }

    my $dvPort_portgroupKey = $dvport->portgroupKey;
    $portgroup = $portgroups{$dvPort_portgroupKey};
    write; 
  }
}


Util::disconnect();
exit;

sub getAllPortgroups {
        my %portgroups;
	# get all Distributed Virtual Switches under this datacenter
	my $dvPortgroups_views = Vim::find_entity_views(view_type => 'DistributedVirtualPortgroup');

	foreach my $dvPortgroup (@$dvPortgroups_views) {
	  if ($dvPortgroup->isa("DistributedVirtualPortgroup")) {
	    my $dvs = Vim::get_view(mo_ref => $dvPortgroup->config->distributedVirtualSwitch, properties => ['name']);
	    my $dvSwitchName = $dvs->name;
	    my $pgName = $dvPortgroup->config->name;
	    my $pgNumPorts = $dvPortgroup->config->numPorts;
	    my $pgKey = $dvPortgroup->config->key; # "dvportgroup-1616"
	    my $pgDescription = $dvPortgroup->config->description;
	    my $vlanId=$dvPortgroup->config->defaultPortConfig->vlan->vlanId;
	    my $pgPortKeys = $dvPortgroup->portKeys; # "116","117","183","184","185"
	    my $pgVMs = $dvPortgroup->vm;

	    #print "Distributed Virtual Switch : $dvSwitchName\n";
	    #print "Portgroup name             : $pgName\n";
	    #print "Portgroup key              : $pgKey\n";
	    #print "\n"
            $portgroups{$pgKey}="$dvSwitchName - $pgName";
	  }
	}

	return %portgroups;
}




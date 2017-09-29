#!/bin/python
from ishell.console import Console
from ishell.command import Command
from subprocess import call

class ShowInterfaceCommand(Command):

    def run(self, line):
        call("./show-interface-status.sh");

class ShowMacAddressTableCommand(Command):

    def run(self, line):
        call("./show-mac-address-table.sh");

class ShowCommand(Command):
    def args(self):
        return ["interface", "mac-address-table"]

    def run(self, line):
        print "Command is not complete"

# MAIN CODE
console = Console(prompt="VDSCLI ", prompt_delim="#")

# show tree
show_command = ShowCommand("show", help="show configurations", dynamic_args=True)
showInterface_command = ShowInterfaceCommand("interface")
showMacAddressTable_command = ShowMacAddressTableCommand("mac-address-table")

console.addChild(show_command)
show_command.addChild(showInterface_command)
show_command.addChild(showMacAddressTable_command)

console.loop()

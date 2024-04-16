<#
11:00 am → 45 min
WinRM vs. OpenSSH: A Showdown for PowerShell Remoting
Paul Broadwith
rm 404
#>

# WinRM uses SOAP, very heavy

# WinRM is only on windows, not on linux

# SSH is generally more performant

# SSH was first created in 1995, v2 is a rewrite first introduced in 2006, release 2018

# MS OpenSSH is a fork of BSD's OpenSSH

# beta 1 is still prod, it is just from a support standpoint MS needs to have this
# comes on win oob now

# SSH very widely supported, cross platform, not OOB though, born in *nix land
# SSH is just oo big to fail at this time. Can use tunnels and do file transfers

# OpenSSH is enabled a sa feature, can enable, but than is should be upgraded right away

# Uses the default shell when connected, so even in windows you get cmd by default, bash in linux
# Set the value in hklm:\software\openssh to set the default shell on connection

# With openssh you have to configure the subsystem

# Currently, only two config managers handle openssh: Ansible and Puppet

# OpenSSH does not support JEA, has limited PS Coupling
# though development is underway, most of these things are going to be fixed

# Paul's opinion is that WinRm is still the winner for now' however, MS stated in the state of the
# shell talk that SSH will be the focus going forward
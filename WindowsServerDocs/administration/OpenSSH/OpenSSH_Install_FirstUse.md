---
ms.date:  01/07/2019
ms.topic: conceptual
keywords:  OpenSSH, SSH, SSHD, install, setup
contributor:  maertendMSFT
author: maertendMSFT
title:  Installation of OpenSSH For Windows
---

# Installation of OpenSSH For Windows Server 2019 and Windows 10 #

The OpenSSH Client and OpenSSH Server are separately installable components in Windows Server 2019 and Windows 10 1809.
Users with these Windows versions should use the instructions that follow to install and configure OpenSSH. 

> [!NOTE] 
> Users who acquired OpenSSH from the PowerShell Github repo (https://github.com/PowerShell/OpenSSH-Portable) should use the instructions from there, and __should not__ use these instructions. 


## Installing OpenSSH from the Settings UI on Windows Server 2019 or Windows 10 1809

OpenSSH client and server are installable features of Windows 10 1809. 

To install OpenSSH, start Settings then go to Apps > Apps and Features > Manage Optional Features. 

Scan this list to see if OpenSSH client is already installed. If not, then at the top of the page select "Add a feature", then: 

* To install the OpenSSH client, locate "OpenSSH Client", then click "Install". 
* To install the OpenSSH server, locate "OpenSSH Server", then click "Install". 

Once the installation completes, return to Apps > Apps and Features > Manage Optional Features and you should see the OpenSSH component(s) listed.

> [!NOTE]
> Installing OpenSSH Server will create and enable a firewall rule named "OpenSSH-Server-In-TCP". This allows inbound SSH traffic on port 22. 

## Installing OpenSSH with PowerShell 

To install OpenSSH using PowerShell, first launch PowerShell as an Administrator.
To make sure that the OpenSSH features are available for install:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# This should return the following output:

Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

Then, install the server and/or client features:

```powershell
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Both of these should return the following output:

Path          :
Online        : True
RestartNeeded : False
```

## Uninstalling OpenSSH

To uninstall OpenSSH using the Windows Settings, start Settings then go to Apps > Apps and Features > Manage Optional Features. 
In the list of installed features, select the OpenSSH Client or OpenSSH Server component, then select Uninstall.

To uninstall OpenSSH using PowerShell, use one of the following commands:

```powershell
# Uninstall the OpenSSH Client
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Uninstall the OpenSSH Server
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

A Windows restart may be required after removing OpenSSH, if the service is in use at the time it was uninstalled.


## Initial Configuration of SSH Server

To configure the OpenSSH server for initial use on Windows, launch PowerShell as an administrator, then run the following commands to start the SSHD service:

```powershell
Start-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup. 
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled 
```

## Initial use of SSH

Once you have installed the OpenSSH Server on Windows, you can quickly test it using PowerShell from any Windows device with the SSH Client installed. 
In PowerShell type the following command: 

```powershell
Ssh username@servername
```

The first connection to any server will result in a message similar to the following:

```
The authenticity of host 'servername (10.00.00.001)' can't be established.
ECDSA key fingerprint is SHA256:(<a large string>).
Are you sure you want to continue connecting (yes/no)?
```

The answer must be either “yes” or “no”. 
Answering Yes will add that server to the local system’s list of known ssh hosts.

You will be prompted for the password at this point. As a security precaution, your password will not be displayed as you type. 

Once you connect you will see a command shell prompt similar to the following:

```
domain\username@SERVERNAME C:\Users\username>
```

The default shell used by Windows OpenSSH server is the Windows command shell. 


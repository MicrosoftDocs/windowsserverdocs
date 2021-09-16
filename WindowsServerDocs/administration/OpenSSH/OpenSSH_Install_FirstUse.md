---
title:  Install OpenSSH
description: Installing OpenSSH Client and Server for Windows.
ms.date: 09/15/2021
ms.topic: conceptual
ms.author: inhenkel
author: IngridAtMicrosoft
ms.custom: contperf-fy21q4
---

# Install OpenSSH

>Applies to Windows Server 2019, Windows 10: Windows Server 2022,

OpenSSH is a connectivity tool for remote login that uses the SSH protocol. It encrypts all traffic between client and server to eliminate eavesdropping, connection hijacking, and other attacks.

OpenSSH can be used to connect Windows 10 (build 1809 and later) or Windows Server 2019 devices with OpenSSH Client installed to those devices with OpenSSH Server installed.

> [!IMPORTANT]
> If you downloaded OpenSSH from the GitHub repo at [PowerShell/openssh-portable](https://github.com/PowerShell/OpenSSH-Portable), follow the instructions listed there, not the ones in this article.

## Install OpenSSH using Windows Settings

Both OpenSSH components can be installed using Windows Settings on Windows Server 2019 and Windows 10 devices.

To install the OpenSSH components:

1. Open **Settings**, select **Apps > Apps & Features**, then select **Optional Features**.

2. Scan the list to see if the OpenSSH is already installed. If not, at the top of the page, select **Add a feature**, then:

    - Find **OpenSSH Client**, then click **Install**
    - Find **OpenSSH Server**, then click **Install**

Once setup completes, return to **Apps > Apps & Features** and **Optional Features** and you should see OpenSSH listed.

> [!NOTE]
> Installing OpenSSH Server will create and enable a firewall rule named `OpenSSH-Server-In-TCP`. This allows inbound SSH traffic on port 22. If this rule is not enabled and this port is not open, connections will be refused or reset.

## Install OpenSSH using PowerShell

To install OpenSSH using PowerShell, run PowerShell as an Administrator.
To make sure that OpenSSH is available, run the following cmdlet:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
```

This should return the following output if neither are already installed:

```
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

Then, install the server or client components as needed:

```powershell
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

Both of these should return the following output:

```
Path          :
Online        : True
RestartNeeded : False
```

## Start and configure OpenSSH Server

To start and configure OpenSSH Server for initial use, open PowerShell as an administrator, then run the following commands to start the `sshd service`:

```powershell
# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the firewall rule is configured. It should be created automatically by setup.
Get-NetFirewallRule -Name *ssh*

# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

## Connect to OpenSSH Server

Once installed, you can connect to OpenSSH Server from a Windows 10 or Windows Server 2019 device with the OpenSSH client installed using PowerShell as follows. Be sure to run PowerShell as an administrator:

```powershell
ssh username@servername
```

Once connected, you get a message similar to the following:

```
The authenticity of host 'servername (10.00.00.001)' can't be established.
ECDSA key fingerprint is SHA256:(<a large string>).
Are you sure you want to continue connecting (yes/no)?
```

Selecting **yes** adds that server to the list of known SSH hosts on your Windows client.

You are prompted for the password at this point. As a security precaution, your password will not be displayed as you type.

Once connected, you will see the Windows command shell prompt:

```
domain\username@SERVERNAME C:\Users\username>
```

## Uninstall OpenSSH using Windows Settings

To uninstall OpenSSH using Windows Settings:

1. Open **Settings**, then go to **Apps > Apps & Features**.
1. Go to **Optional Features**.
1. In the list, select **OpenSSH Client** or **OpenSSH Server**.
1. Select **Uninstall**.

## Uninstall OpenSSH using PowerShell

To uninstall the OpenSSH components using PowerShell, use the following commands:

```powershell
# Uninstall the OpenSSH Client
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Uninstall the OpenSSH Server
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

You may need to restart Windows afterwards if the service was in use at the time it was uninstalled.

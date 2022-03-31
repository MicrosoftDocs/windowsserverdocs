---
title:  Get started with OpenSSH
description: Installing OpenSSH Client and Server for Windows.
ms.date: 09/15/2021
ms.topic: conceptual
ms.author: inhenkel
author: IngridAtMicrosoft
ms.custom: contperf-fy21q4
---

# Get started with OpenSSH

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10 (build 1809 and later)

OpenSSH is a connectivity tool for remote login that uses the SSH protocol. It encrypts all traffic between client and server to eliminate eavesdropping, connection hijacking, and other attacks.

An OpenSSH-compatible client can be used to connect to Windows Server and Windows client devices.

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
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
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

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
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

## OpenSSH configuration files

OpenSSH has configuration files for both server and client settings. OpenSSH is open-source and is added to Windows Server and Windows Client operating systems, starting with Windows Server 2019 and Windows 10 (build 1809). As a result, documentation for OpenSSH configuration files is not repeated here. Client configuration files and can be found on the [ssh_config manual page](https://man.openbsd.org/ssh_config) and for OpenSSH Server configuration files can be found on the [sshd_config manual page](https://man.openbsd.org/sshd_config). Further Windows-specific OpenSSH Server configuration is detailed in [OpenSSH Server configuration for Windows](OpenSSH_Server_Configuration.md#windows-configurations-in-sshd_config).

In Windows, the OpenSSH Client (ssh) reads configuration data from a configuration file in the following order:

1. By launching ssh.exe with the -F parameter, specifying a path to a configuration file and an entry name from that file.
2. A user's configuration file at %userprofile%\\.ssh\config.
3. The system-wide configuration file at %programdata%\ssh\sshd_config.

Open SSH Server (sshd) reads configuration data from %programdata%\ssh\sshd_config by default, or a different configuration file may be specified by launching sshd.exe with the -f parameter. If the file is absent, sshd generates one with the default configuration when the service is started.

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

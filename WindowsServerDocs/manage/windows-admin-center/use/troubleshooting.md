---
title: Windows Admin Center Common Troubleshooting Steps
description: Windows Admin Center Common Troubleshooting Steps (Project Honolulu)
ms.technology: manage
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Windows Admin Center Common Troubleshooting Steps

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

This article describes common Windows Admin Center configuration issues and how to fix them.

Before troubleshooting, check to see if you are experiencing a [known issue.](known-issues.md)

## Verify Connectivity

If possible, log on to the gateway machine locally and try to ```Enter-PSSession <target machine>``` in PowerShell. Windows Admin Center is mostly remote PowerShell under the hood so if ```Enter-PSSession``` fails, Windows Admin Center will not work.

## Clear your browser cache

You may sometimes need to clear your browser cache if you find that portions of the interface are not responding.

## Delete data from previous install

If you have previously installed Windows Admin Center on as a gateway on Windows Server (not Windows 10), you may need to delete the application data if the service fails to start, or if your connection list appears corrupted. 

To remove the application data, delete the **Server Management Experience** folder under **C:\\Windows\\ServiceProfiles\\NetworkService\\AppData\\Roaming\\Microsoft**

> [!WARNING]
> This will delete all users connection lists and gateway settings that you have modified.

## Configure TrustedHosts

When installing Windows Admin Center, you are given the option to let Windows Admin Center manage the gateway's TrustedHosts setting. This is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must configure TrustedHosts manually.


> [!NOTE] 
> If you are installing on Windows 10 in a domain and using domain credentials to connect to the managed node, you do not need to modify TrustedHosts.

**To modify TrustedHosts using PowerShell commands:**

1. Open an Administrator PowerShell session.
2. View your current TrustedHosts setting:

        Get-Item WSMan:\localhost\Client\TrustedHosts

    > [!WARNING]
    > If the current setting of your TrustedHosts is not empty, the commands below will overwrite your setting. We recommend that you save the current setting to a text file with the following command so you can restore it if needed:

    > `Get-Item WSMan:localhost\Client\TrustedHosts | Out-File C:\OldTrustedHosts.txt`

3. Set TrustedHosts to the NetBIOS, IP, or FQDN of the machines you
intend to manage:

        Set-Item WSMan:localhost\Client\TrustedHosts -Value '192.168.1.1,server01.contoso.com,server02'

    > [!TIP] 
    >For an easy way to set all TrustedHosts at once, you can use a wildcard. Note though that including all hosts is less secure than setting them specifically.

    >     Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'

4. When you are done testing, you can issue the following command from an elevated PowerShell session to clear your TrustedHosts setting:

        Clear-Item WSMan:localhost\Client\TrustedHosts

5. If you had previously exported your settings, open the file, copy the values, and use this command:

        Set-Item WSMan:localhost\Client\TrustedHosts -Value '<paste values from text file>'## Credentials ##

Make sure the credentials you are using are a member of the target server's local administrators group. In some cases, WinRM also requires membership in the Remote Management Users group.

## Are you connecting with a local user account?

When entering credentials in the server connection's **Manage As** dialog box, you can use a local or domain account that is a member of the local administrators group on the target server. However, if you are using a local user account that is not the built-in administrator account, you will need to enable the policy on the target machine by running the following command in PowerShell or at a Command Prompt as Administrator on the target machine:

    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1

## Are you connecting to a workgroup machine on a different subnet?

To connect to a workgroup machine that is not on the same subnet as the gateway, make sure the firewall port for WinRM (TCP 5985) allows inbound traffic on the target machine. You can run the following command in PowerShell or at a Command Prompt as Administrator on the target machine to create this firewall rule:

- **Windows Server**

        Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any

- **Windows 10**

       Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any

## Hyper-V PowerShell not installed

If you've successfully connected to the server with the Hyper-V role, but the *Virtual Machines* tool does not appear, make sure that the Hyper-V Module for Windows PowerShell is installed.

**Enable Hyper-V PowerShell features**

1. Click **Roles and Features** in the **Tools** menu.
2. In **Roles and Features** find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for Windows PowerShell**.

![](../media/hyperv-powershell.png)
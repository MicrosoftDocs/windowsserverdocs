---
title: Remotely manage Hyper-V hosts
description: "Describes version compatibility between Hyper-V hosts and Hyper-V Manager and how to connect to remote hosts in different environments, including cross-domain and standalone."
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d34e98c-6134-479b-8000-3eb360b8b8a3
author: KBDAzure
ms.author: kathydav
ms.date: 11/29/2016
---
# Remotely manage Hyper-V hosts with Hyper-V Manager

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 8.1

This article lists the supported versions of Hyper-V hosts you can manage with supported versions of Hyper-V Manager and shows you how to set up Hyper-V Manager to connect to remote and local Hyper-V hosts. 

Hyper-V Manager lets you manage a small number of Hyper-V hosts, both remote and local. It's installed when you install the Hyper-V Management Tools, which you can do either through a full Hyper-V installation or a tools-only installation. The ability to install only the tools means you can use the tools even if your computer doesn't meet the hardware requirements to host Hyper-V.  For details about hardware for Hyper-V hosts, see [System requirements](..\System-requirements-for-Hyper-V-on-Windows.md). 

If Hyper-V Manager isn't installed, see the instructions below.

## Supported combinations of Hyper-V Manager and Hyper-V host versions

In some cases you can use a different version of Hyper-V Manager than the Hyper-V version on the host, as shown in the table. When you do this, Hyper-V Manager provides the features available for the version of Hyper-V on the host you're managing. For example, if you use the version of Hyper-V Manager in Windows Server 2012 R2 to remotely manage a host running Hyper-V in Windows Server 2012, you won't be able to use features available in Windows Server 2012 R2 on that Hyper-V host.

The following table shows which versions of a Hyper-V host you can manage from a particular version of Hyper-V Manager. Only supported operating system versions are listed. For details about the support status of a particular operating system version, see the [Microsoft Lifecycle Policy](https://support.microsoft.com/lifecycle). In general, older versions of Hyper-V Manager can only manage a Hyper-V host running the same version or the comparable Windows Server version.

|Hyper-V Manager version | Hyper-V host version|
|---|---|
|Windows 2016, Windows 10|- Windows Server 2016: all editions and installation options, including Nano Server, and corresponding version of Hyper-V Server <br>- Windows Server 2012 R2—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows Server 2012—all editions and installation options, and corresponding version of Hyper-V Server <br> - Windows 10 <br> - Windows 8.1  |
| Windows Server 2012 R2, Windows 8.1 | - Windows Server 2012 R2—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows Server 2012—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows 8.1 

## Connect to a Hyper-V host

To connect to a Hyper-V host from Hyper-V Manager, right-click **Hyper-V Manager** in the left pane, and then click **Connect to Server**.

## Manage Hyper-V on a local computer
Hyper-V Manager doesn't list any computers that host Hyper-V until you add the computer, including a local computer. To do this:

1. In the left pane, right-click **Hyper-V Manager**.
2. Click **Connect to Server**.
3. From **Select Computer**, click **Local computer** and then click **OK**.

If you can't connect:

* It's possible that only the Hyper-V tools are installed. Check that the Hyper-V Platform role is installed by . 
* Check that your hardware meets the requirements.See [System requirements](..\System-requirements-for-Hyper-V-on-Windows.md)
* Check that your user account belongs to the Administrators group or the Hyper-V Administrators group.

## Manage another Hyper-V host in the same domain ##

To add a remote Hyper-V host to Hyper-V Manager, select **Another computer** in the **Select Computer** dialogue box and enter the remote host's hostname, NetBIOS name, or FQDN into the text field.

![](media/HyperVManager-ConnectToRemoteHost.png)

To manage remote Hyper-V hosts, remote management must be enabled on both the local computer and remote host.

You can do this through `Server Manager -> Remote management` or by running the following PowerShell command as Administrator: 

``` PowerShell
Enable-PSRemoting
```

If your current user account matches a Hyper-V Administrator account on the remote host, click **OK** to Connect.  

> This is the only supported way to manage a remote host in Hyper-V Manager in Windows 8 or Windows 8.1.

Windows 10 greatly expanded the possible combinations of remote connection types.  
Now you can connect to a remote Windows 10 or later host using either the host name or IP address. Hyper-V Manager now supports alternate user credentials as well.  

### Connect to a Windows 2016 or Windows 10 remote host as a different user

Starting with Windows 2016 and Windows 10, Hyper-V Manager lets you use a different user account to connect remotely. To do this:

1. Select **Connect as another user** in the **Select Computer** dialogue box.
2. Select **Set User**.

![Screen shot that shows how to use a different user name and password to connect to a remote Hyper-V host.](media/HyperVManager-ConnectToRemoteHostAltCreds.png)

### Connect to the remote host using IP address

This is only available when connecting to a Windows 10 or Windows Server 2016 remote host

Sometimes it's easier to connect using IP address rather than host name. Windows 10 allows you to do just that.

To connect using IP address, type the IP address into the **Another Computer** text field.

## Manage a Hyper-V host outside your domain, or with no domain

This is only available when connecting to a Windows 10 or Windows Server 2016 remote host.

On the Hyper-V host to be managed, run the following as an administrator:

1. Create the necessary firewall rules for *private* network zones: 	
  - ```Enable-PSRemoting```
2. To allow remote access on public zones, enable firewall rules for CredSSP and WinRM:
  
   ```Enable-WSManCredSSP -Role server```

    For details, see [Enable-PSRemoting](https://technet.microsoft.com/library/hh849694.aspx) and [Enable-WSManCredSSP](https://technet.microsoft.com/library/hh849872.aspx).

From the computer you'll use to manage the Hyper-V host, open a PowerShell session as an administrator and run the following commands:

1. Set-Item WSMan:\localhost\Client\TrustedHosts -Value "fqdn-of-hyper-v-host"
2. [Enable-WSManCredSSP](https://technet.microsoft.com/en-us/library/hh849872.aspx) -Role client -DelegateComputer "fqdn-of-hyper-v-host"
3. Additionally you may need to configure the following group policy: ** Computer Configuration | Administrative Templates | System | Credentials Delegation | Allow delegating fresh credentials with NTLM-only server authentication **
    * Click **Enable** and add *wsman/fqdn-of-hyper-v-host*

## Install Hyper-V Manager

### Install from a UI-based tool

Hyper-V Manager is available through **Programs and Features** as **Hyper-V Management Tools** on [any Windows operating system that includes Hyper-V](../quick_start/walkthrough_compatibility.md#operating-system-requirements).

### Install from Windows PowerShell

On Win 10, add via PowerShell:

```add-windowsfeature rsat-hyper-v-tools```

## See also  
 
[Install Hyper-V](..\get-started\Install-the-Hyper-V-role-on-Windows-Server.md) 



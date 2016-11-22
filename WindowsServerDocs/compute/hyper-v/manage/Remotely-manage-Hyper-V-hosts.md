---
title: Remotely manage Hyper-V hosts
description: "Gives instructions for installing Hyper-V Manager and using it to remotely manage Hyper-V hosts."
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: XYZ
author: KBDAzure
ms.author: kathydav
ms.date: 11/22/2016
---
# Remotely manage Hyper-V hosts

>Applies To: Windows 10, Windows Server 2016

On Win 10, add via PowerShell:

```add-windowsfeature rsat-hyper-v-tools```

>---! from current article
Hyper-V Manager is an in-box tool for diagnosing and managing your local Hyper-V host and a small number of remote hosts. This article documents the configuration steps for connecting to Hyper-V hosts using Hyper-V Manager in all supported configurations.

Hyper-V Manager is available through **Programs and Features** as **Hyper-V Management Tools** on [any Windows OS with Hyper-V included](../quick_start/walkthrough_compatibility.md#operating-system-requirements). You can install and use the Hyper-V tools.

To connect to a Hyper-V host from Hyper-V Manager, right-click **Hyper-V Manager** in the left pane, and then click **Connect to Server**.

![Screenshot that shows how to connect to a server from Hyper-V Manager](media/HyperVManager-ConnectToHost.png)

## Supported Hyper-V host combinations with Hyper-V Manager
Hyper-V Manager in Windows 10 allows you to manage the following Hyper-V hosts:
* Windows 10
* Windows 8.1
* Windows 8
* Windows Server 2016 — all editions and installation options, including Nano Server, and corresponding version of Hyper-V Server
* Windows Server 2012 R2 — all editions and installation options, and corresponding version of Hyper-V Server
* Windows Server 2012 — all editions and installation options, and corresponding version of Hyper-V Server

Hyper-V Manager in Windows 8.1 and Windows Server 2012 R2 allows you to manage:
* Windows 8.1
* Windows 8
* Windows Server 2012 R2 — all editions and installation options, and corresponding version of Hyper-V Server
* Windows Server 2012 — all editions and installation options, and corresponding version of Hyper-V Server

Hyper-V Manager in Windows 8 and Windows Server 2012 allows you to manage:
* Windows 8
* Windows Server 2012 — all editions and installation options, and corresponding version of Hyper-V Server

Hyper-V Manager in Windows 7 and Windows Server 2008 R2 allows you to manage:
* Windows Server 2008 R2 — all editions and installation options, and corresponding version of Hyper-V Server

Hyper-V Manager in Windows Vista and Windows Server 2008 allows you to manage:
* Windows Server 2008  — all editions and installation options, and corresponding version of Hyper-V Server

> [!NOTE]
Hyper-V Manager functionality matches the functionality available for version you're managing. In other words, if you're managing a remote Windows Server 2012 host from Windows Server 2012 R2, the new Hyper-V Manager features from Windows Server 2012 R2 won't be available.

## Manage Hyper-V on a local computer
Hyper-V Manager doesn't list any computers that host Hyper-V until you add the computer, including a local computer. 

1. In the left pane, right-click **Hyper-V Manager**.
2. Click **Connect to Server**.
3. From **Select Computer**, click **Local computer** and then click **OK**.

![Screen shot that shows adding the local computer to the list of hosts in Hyper-V Manager.](media/HyperVManager-ConnectToLocalHost.png)

If you can't connect:

* It's possible that only the Hyper-V tools are installed. Check that the Hyper-V Platform role is installed by . 
* Check that your hardware meets the requirements.  
* Check that your user account belongs to the Administrators group or the Hyper-V Administrators group.

## Manage another Hyper-V host in the same domain ##

To add a remote Hyper-V host to Hyper-V Manager, select **Another computer** in the **Select Computer** dialogue box and enter the remote host's hostname, NetBIOS, or FQDN into the text field.

![](media/HyperVManager-ConnectToRemoteHost.png)

In order to manage remote Hyper-V hosts, remote management must be enabled on both the local computer and remote host.

You can do this through `Server Manager -> Remote management` or by running the following PowerShell command as Administrator: 

``` PowerShell
Enable-PSRemoting
```

If your current user account matches a Hyper-V Administrator account on the remote host, go ahead and press **OK** to Connect.  

> This is the only supported way to manage a remote host in Hyper-V Manager in Windows 8 or Windows 8.1.

Windows 10 greatly expanded the possible combinations of remote connection types.  
Now you can connect to a remote Windows 10 or later host using either the host name or IP address.  Hyper-V Manager now supports alternate user credentials as well.  

### Connect to a Windows 2016 or Windows 10 remote host as a different user

Hyper-V in Windows 2016 and Windows 10 lets you use a different user account to connect remotely. To do this:

1. Select **Connect as another user: ** in the **Select Computer** dialogue box.
2. Select **Set User...**.

![Screen shot that shows how to use a different user name and password to connect to a remote Hyper-V host.](media/HyperVManager-ConnectToRemoteHostAltCreds.png)


### Connect to the remote host using IP address
> This is only available when connecting to a Windows 10 or Windows Server 2016 Technical Preview 3 or later remote host

Sometimes it's easier to connect using IP address rather than host name. Windows 10 allows you to do just that.

To connect using IP address, enter the IP address into the **Another Computer** text field.


## Manage a Hyper-V host outside your domain (or with no domain) ##
> This is only available when connecting to a Windows 10 or Windows Server 2016 Technical Preview 3 or later remote host

On the Hyper-V host to be managed, run the following as an administrator:

1.	[Enable-PSRemoting](https://technet.microsoft.com/en-us/library/hh849694.aspx)
  * [Enable-PSRemoting](https://technet.microsoft.com/en-us/library/hh849694.aspx) will create the necessary firewall rules for *private* network zones. To allow this access on public zones you will need to enable the rules for CredSSP and WinRM.
2.  [Enable-WSManCredSSP](https://technet.microsoft.com/en-us/library/hh849872.aspx) -Role server

On the managing PC, run the following as an administrator:

1. Set-Item WSMan:\localhost\Client\TrustedHosts -Value "fqdn-of-hyper-v-host"
2. [Enable-WSManCredSSP](https://technet.microsoft.com/en-us/library/hh849872.aspx) -Role client -DelegateComputer "fqdn-of-hyper-v-host"
3. Additionally you may need to configure the following group policy: ** Computer Configuration | Administrative Templates | System | Credentials Delegation | Allow delegating fresh credentials with NTLM-only server authentication **
    * Click **Enable** and add *wsman/fqdn-of-hyper-v-host*

## See also  
 
[Install Hyper-V](..\get-started\Install-the-Hyper-V-role-on-Windows-Server.md) 



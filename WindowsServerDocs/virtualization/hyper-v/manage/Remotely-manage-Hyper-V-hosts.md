---
title: Remotely manage Hyper-V hosts
description: "Describes version compatibility between Hyper-V hosts and Hyper-V Manager and how to connect to remote hosts in different environments, including cross-domain and standalone."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d34e98c-6134-479b-8000-3eb360b8b8a3
author: KBDAzure
ms.author: kathydav
ms.date: 12/06/2016
---
# Remotely manage Hyper-V hosts with Hyper-V Manager

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 8.1

This article lists the supported combinations of Hyper-V hosts and Hyper-V Manager versions and describes how to connect to remote and local Hyper-V hosts so you can manage them. 

Hyper-V Manager lets you manage a small number of Hyper-V hosts, both remote and local. It's installed when you install the Hyper-V Management Tools, which you can do either through a full Hyper-V installation or a tools-only installation. Doing a tools-only installation means you can use the tools on computers that don't meet the hardware requirements to host Hyper-V. For details about hardware for Hyper-V hosts, see [System requirements](../System-requirements-for-Hyper-V-on-Windows.md).

If Hyper-V Manager isn't installed, see the [instructions](#install-hyper-v-manager) below.

## Supported combinations of Hyper-V Manager and Hyper-V host versions

In some cases you can use a different version of Hyper-V Manager than the Hyper-V version on the host, as shown in the table. When you do this, Hyper-V Manager provides the features available for the version of Hyper-V on the host you're managing. For example, if you use the version of Hyper-V Manager in Windows Server 2012 R2 to remotely manage a host running Hyper-V in Windows Server 2012, you won't be able to use features available in Windows Server 2012 R2 on that Hyper-V host.

The following table shows which versions of a Hyper-V host you can manage from a particular version of Hyper-V Manager. Only supported operating system versions are listed. For details about the support status of a particular operating system version, use the **Search product lifecyle** button on the [Microsoft Lifecycle Policy](https://support.microsoft.com/lifecycle) page. In general, older versions of Hyper-V Manager can only manage a Hyper-V host running the same version or the comparable Windows Server version.

|Hyper-V Manager version | Hyper-V host version|
|---|---|
|Windows 2016, Windows 10|- Windows Server 2016—all editions and installation options, including Nano Server, and corresponding version of Hyper-V Server <br>- Windows Server 2012 R2—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows Server 2012—all editions and installation options, and corresponding version of Hyper-V Server <br> - Windows 10 <br> - Windows 8.1  |
| Windows Server 2012 R2, Windows 8.1 | - Windows Server 2012 R2—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows Server 2012—all editions and installation options, and corresponding version of Hyper-V Server <br>- Windows 8.1
| Windows Server 2012 | - Windows Server 2012—all editions and installation options, and corresponding version of Hyper-V Server
| Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1 | - Windows Server 2008 R2—all editions and installation options, and corresponding version of Hyper-V Server
| Windows Server 2008, Windows Vista Service Pack 2 | - Windows Server 2008—all editions and installation options, and corresponding version of Hyper-V Server

>[!NOTE]
>Service pack support ended for Windows 8 on January 12, 2016. For more information, see the [Windows 8.1 FAQ](https://support.microsoft.com/help/18581).

## Connect to a Hyper-V host

To connect to a Hyper-V host from Hyper-V Manager, right-click **Hyper-V Manager** in the left pane, and then click **Connect to Server**.

## Manage Hyper-V on a local computer

Hyper-V Manager doesn't list any computers that host Hyper-V until you add the computer, including a local computer. To do this:

1. In the left pane, right-click **Hyper-V Manager**.
2. Click **Connect to Server**.
3. From **Select Computer**, click **Local computer** and then click **OK**.

If you can't connect:

* It's possible that only the Hyper-V tools are installed. To check that Hyper-V platform is installed, look for the Virtual Machine Management service. /(Open the Services desktop app: click **Start**, click the **Start Search** box, type **services.msc**, and then press **Enter**. If the Virtual Machine Management service isn't listed, install the Hyper-V platform by following the instructions in [Install Hyper-V](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md).
* Check that your hardware meets the requirements. See [System requirements](../System-requirements-for-Hyper-V-on-Windows.md).
* Check that your user account belongs to the Administrators group or the Hyper-V Administrators group.

## Manage Hyper-V hosts remotely  

To manage remote Hyper-V hosts, enable remote management on both the local computer and remote host.

On Windows Server, open Server Manager \>**Local Server** \>**Remote management** and then click **Allow remote connections to this computer**. 

Or, from either operating system, open Windows PowerShell as Administrator and run: 

```
Enable-PSRemoting
```

### Connect to hosts in the same domain

For Windows 8.1 and earlier, remote management works only when the host is in the same domain and your local user account is also on the remote host.

To add a remote Hyper-V host to Hyper-V Manager, select **Another computer** in the **Select Computer** dialogue box and type the remote host's hostname, NetBIOS name, or fully qualified domain name \(FQDN\).

Hyper-V Manager in Windows Server 2016 and Windows 10 offers more types of remote connection than previous versions, described in the following sections.  

### Connect to a Windows 2016 or Windows 10 remote host as a different user

This lets you connect to the Hyper-V host when you're not running on the local computer as a user that's a member of either the Hyper-V Administrators group or the Administrators group on the Hyper-V host. To do this:

1. In the left pane, right-click **Hyper-V Manager**.
1. Click **Connect to Server**.
1. Select **Connect as another user** in the **Select Computer** dialogue box.
1. Select **Set User**.

>[!NOTE]
> This will only work for Windows Server 2016 or Windows 10 **remote** hosts.

### Connect to a Windows 2016 or Windows 10 remote host using IP address

To do this:

1. In the left pane, right-click **Hyper-V Manager**.
1. Click **Connect to Server**.
1. Type the IP address into the **Another Computer** text field.

>[!NOTE]
> This will only work for Windows Server 2016 or Windows 10 **remote** hosts.

### Connect to a Windows 2016 or Windows 10 remote host outside your domain, or with no domain

To do this:

1. On the Hyper-V host to be managed, open a Windows PowerShell session as Administrator.

1. Create the necessary firewall rules for private network zones: 	
   
   ```
   Enable-PSRemoting
   ```

2. To allow remote access on public zones, enable firewall rules for CredSSP and WinRM:
  
   ```
   Enable-WSManCredSSP -Role server
   ```

    For details, see [Enable-PSRemoting](https://technet.microsoft.com/library/hh849694.aspx) and [Enable-WSManCredSSP](https://technet.microsoft.com/library/hh849872.aspx).

Next, configure the computer you'll use to manage the Hyper-V host.

1. Open a Windows PowerShell session as Administrator.
1. Run these commands:

     ```
     Set-Item WSMan:\localhost\Client\TrustedHosts -Value "fqdn-of-hyper-v-host"
     ```
     ```
     Enable-WSManCredSSP -Role client -DelegateComputer "fqdn-of-hyper-v-host"
     ```
1. You might also need to configure the following group policy: 
    * **Computer Configuration** \> **Administrative Templates** \> **System** \> **Credentials Delegation** \> **Allow delegating fresh credentials with NTLM-only server authentication**
    * Click **Enable** and add *wsman/fqdn-of-hyper-v-host*.
1. Open **Hyper-V Manager**.
1. In the left pane, right-click **Hyper-V Manager**.
1. Click **Connect to Server**.

>[!NOTE]
> This will only work for Windows Server 2016 or Windows 10 **remote** hosts.

For cmdlet details, see [Set-Item](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.management/set-item) and [Enable-WSManCredSSP](https://technet.microsoft.com/library/hh849872.aspx).

## Install Hyper-V Manager

To use a UI tool, choose the one appropriate for the operating system on the computer where you'll run Hyper-V Manager:

On Windows Server, open Server Manager \> **Manage** \> **Add roles and features**. Move to the **Features** page and expand **Remote server administration tools** \> **Role administration tools** \> **Hyper-V management tools**. 

On Windows, Hyper-V Manager is available on [any Windows operating system that includes Hyper-V](https://msdn.microsoft.com/virtualization/hyperv_on_windows/quick_start/walkthrough_compatibility).

1. On the Windows desktop, click the Start button and begin typing **Programs and features**. 
1. In search results, click **Programs and Features**.
1. In the left pane, click **Turn Windows features on or off**.
1. Expand the Hyper-V folder, and **click Hyper-V Management Tools**.
1. To install Hyper-V Manager, click **Hyper-V Management Tools**. If you want to also install the Hyper-V module, click that option.

To use Windows PowerShell, run the following command as Administrator:

```
add-windowsfeature rsat-hyper-v-tools
```

## See also  
 
[Install Hyper-V](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md) 


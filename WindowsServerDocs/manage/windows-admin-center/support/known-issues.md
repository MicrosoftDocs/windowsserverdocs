---
title: Windows Admin Center known issues
description: Windows Admin Center Known Issues (Project Honolulu)
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 06/07/2019
---
# Windows Admin Center known issues

>Applies to: Windows Admin Center, Windows Admin Center Preview

If you encounter an issue not described on this page, let us know at the [Windows Admin Center feedback page](https://aka.ms/WACfeedback).

## Installer

- When installing Windows Admin Center using your own certificate, if you copy the thumbprint from the certificate manager Microsoft Management Center (MMC) tool, when you pase it, [it contains an invalid character at the beginning](https://support.microsoft.com/help/2023835/certificate-thumbprint-displayed-in-mmc-certificate-snap-in-has-extra). As a workaround, enter the first character of the thumbprint, then copy and paste the characters that come after the first.

- Windows Admin Center doesn't support ports lower than 1024. In service mode, you can optionally configure port 80 to redirect to your specified port.

## General

- Self-signed certificates accessed on `https://localhost:[port]` can cause the Microsoft Edge and Google Chrome browsers to block Windows Admin Center. When this happens, you may see an error message that says your connection isn't private. To resolve this issue, update Windows Admin Center to the latest version.

- Using certain versions of extensions with earlier versions of Windows Admin Center may result in icons not displaying properly. To resolve this issue, update to the latest version of Windows Admin Center

- In the 1910.2 release of Windows Admin Center, you may not be able to connect to Hyper-V servers on specific hardware. To resolve this issue, either [download the previous version](https://aka.ms/wacprevious) or try updating to the latest version.

- If you have Windows Admin Center installed as a heavily used gateway on Windows Server 2016, the service may crash with an error in the event log that contains `Faulting application name: sme.exe` and `Faulting module name: WsmSvc.dll`. This error is because of a bug that we've fixed as of Windows Server 2019. However, we've also release a patch for Windows Server 2016 to address this issue in the February 2019 cumulative update, [KB4480977](https://www.catalog.update.microsoft.com/Search.aspx?q=4480977).

- If you have Windows Admin Center installed as a gateway and your connection list appears to be corrupted, follow these steps:

   > [!WARNING]
   >The procedure in these instructions deletes the connection list and settings for all Windows Admin Center users on the gateway.

  1. Uninstall Windows Admin Center.
  
  1. Go to **C:\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft** and delete the **Server Management Experience** folder.
  
  1. Reinstall Windows Admin Center.

- If you leave the tool open and idle for a long period of time, you may get several error messages that say "The runspace state is not valid for this operation." If this occurs, refresh your browser. If you encounter this, [send us feedback](https://aka.ms/WACfeedback).

- There may be minor differences between version numbers of open-source software (OSS) running in Windows Admin Center modules versus what's listed in the third Party Software Notice.

- You can access and use Windows Admin Center tool application programming interfaces (APIs) through other methods during an active session of Windows Admin Center if you have access to that session. The actions you take using these APIs only affect the machine you installed Windows Admin Center on, also known as the gateway machine. They won't affect machines managed remotely without authentication through the Windows Admin Center gateway.

### Extension Manager

- When you update Windows Admin Center, you must reinstall your extensions.

- If you add an extension feed that is inaccessible, no warning or error message appears.

## Partner extension issues

- Dell's EMC OpenManage Integration extension utilizes APIs provided by Windows Admin Center to push files onto target nodes. APIs such as NodeExtensionInstall only work when the user is a gateway administrator; it doesn't support non-admin use.

## Browser-specific issues

This section describes issues that can happen when you use Windows Admin Center in an internet browser.

### Microsoft Edge

If you have Windows Admin Center deployed as a service and you are using Microsoft Edge as your browser, connecting your gateway to Azure may fail after opening a new browser window. There isn't currently a solution for this issue, but you can work around it by adding `https://login.microsoftonline.com`, `https://login.live.com`, and the URL of your gateway as trusted sites and allowed sites for pop-up blocker settings on your client-side browser.

For more information, see the [troubleshooting guide](troubleshooting.md#azure-features-dont-work-properly-in-microsoft-edge).

### Google Chrome

- Prior to version 70 (released late October 2018) Chrome had a [bug](https://bugs.chromium.org/p/chromium/issues/detail?id=423609) that affected the WebSockets protocol and Windows New Technology Local Area Network Manager (NTLM) authentication. This bug also affects the following programs:

  - Windows Events
  
  - PowerShell
  
  - Remote Desktop

- Many credential prompts might appear while you're using Chrome, especially when you're adding connections in a workgroup environment.

- If you have Windows Admin Center deployed as a service, you must enable popups from the gateway URL to use Azure integration.

### Mozilla Firefox

- Windows Admin Center isn't tested with Mozilla Firefox, but most functionality should work.

- If you're using Windows 10, you need to import the Windows Admin Center Client certificate into Firefox to use Windows Admin Center.

## WebSocket compatibility when using a proxy service

Scenarios involving using Windows Admin Center with a proxy service often don't support the WebSocket protocol, which can affect the following programs:

- Remote Desktop

- PowerShell

- Packet Monitoring

- Windows Events

## Support for Windows Server 2012 R2, 2012, and 2008 R2

Windows Admin Center requires PowerShell features that aren't included in Windows Server 2012 R2, 2012, or 2008 R2. You must install Windows Management Framework (WMF) version 5.1 or later on any servers using these versions of Windows Server with Windows Admin Center.

To install WMF:

1. Open a PowerShell window.

1. Enter `$PSVersiontable` to verify if you have WMF installed and check the version number.

1. If you haven't already installed WMF, [download and install it](https://www.microsoft.com/download/details.aspx?id=54616).

## Role Based Access Control (RBAC)

- RBAC deployment won't work on machines configured to use Windows Defender Application Control (WDAC).

- To use RBAC in a cluster, you must deploy the configuration to each member node individually.

- When you deploy RBAC, you may get unauthorized errors incorrectly attributed to the RBAC configuration.

## Server Manager solution

This section describes common issues you can run into in Server Manager on Windows Admin Center.

### Certificates

Server Manager on Windows Admin Center doesn't currently support importing the .PFX Encrypted Certificate into the current user store.

### Events

- Events is affected by the issue described in [WebSocket compatibility when using a proxy service](#websocket-compatibility-when-using-a-proxy-service).

- You may get an error message that references “packet size” when exporting large log files.

  To resolve this issue:
  
  1. Open an elevated command prompt on the gateway machine.
  
  1. Run the following command:

   ```cmd
   winrm set winrm/config @{MaxEnvelopeSizekb="8192"}
   ```

### Files

Server Manager on Windows Admin Center doesn't currently support uploading or downloading files over 100 MB in size.

### PowerShell

- PowerShell is affected by the issue described in [WebSocket compatibility when using a proxy service](#websocket-compatibility-when-using-a-proxy-service).

- PowerShell in Server Manager doesn't support pasting into the window by right-clicking. To paste into the window, you need to right-click and select **Paste** from the drop-down context menu or use the **Ctrl+V** shortcut.

- PowerShell in Server Manager doesn't support the Ctrl+C shortcut to copy content to the clipboard. To copy content, highlight the text, right-click it, then select **Copy**.

- When you make the Windows Admin Center window smaller, the terminal content adjusts to fit the new window size. When you return the window to its original size, the content might not return to its original state. You can restore the text by using the `Clear-Host` command, or disconnect and reconnect using the button above the terminal.

<!--Where I left off.-->

### Registry Editor

Registry Editor for Windows Admin Center for Windows Server hasn't implemented search functionality.

### Remote Desktop

- When you deploy Windows Admin Center as a service, the Remote Desktop tool sometimes doesn't load after the Windows Admin Center service updates to a new version. To work around this issue, clear your browser cache.

- The Remote Desktop tool sometimes doesn't connect when managing Windows Server 2012.

- When using the Remote Desktop to connect to a machine that isn't Domain joined, you must enter your account in the `MACHINENAME\USERNAME` syntax.

- Some configurations can block Windows Admin Center's remote desktop client with group policy. If you encounter this, go to **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host Connections** and enable the **Allow Users to connect remotely by using Remote Desktop Services** setting.

- Remote Desktop is affected by the issue described in [Websocket compatibility when using a proxy service](#websocket-compatibility-when-using-a-proxy-service).

- The Remote Desktop tool doesn't currently support any text, image, or file copy and paste between the local desktop and the remote session.

- You can copy text the same way you would during a local session by either right-clicking and selecting **Copy** or pressing the **Ctrl+C** keys, but you can only paste by right-clicking and selecting **Paste**.

- Remote sessions don't support the following keys and keyboard shortcuts:

  - Alt+Tab

  - Function keys

  - Windows Key

  - PrtScn

### Roles and Features

- When you select roles or features that don't have available installation sources, the system skips them.

- If you choose to not automatically restart after installing a role, you won't see any more notification messages asking you to restart.

- If you do choose to automatically reboot, the reboot occurs before the status bar reaches 100%.

### Storage

- DVD, CD, and Floppy drives don't appear as volumes on down-level.

- Some properties in Volumes and Disks appear as unknown or blank in the Details panel because they aren't available in down-level storage.

- If you're creating a new Resilient File System (ReFS) volume, ReFS only supports an allocation unit size of 64K on Windows 2012 and 2012 R2 machines. If you create a ReFS volume with a smaller allocation unit size on down-level targets, file system formatting doesn't work, making the new volume unusable. To resolve this issue, delete the unusable volume, then create a new one with 64K allocation unit size.

### Updates

- After installing updates, the system sometimes caches the install status and requires a browser refresh.

- If you see an error message that says "Keyset does not exist" when attempting to set up Azure Update management, follow these directions on the managed node:

  1. Stop the **Cryptographic Services** service.
  
  1. Change the folder options to show hidden files, if required.
  
  1. Go to the **%allusersprofile%\Microsoft\Crypto\RSA\S-1-5-18** folder and delete all its contents.

  1. Restart the **Cryptographic Services** service.
  
  1. Reinstall Update Management with Windows Admin Center.

### Virtual machines

- If you're managing your virtual machines (VMs) on a Windows Server 2012 session host, the in-browser VM connect tool can't connect to the VM. You can resolve this issue by downloading the .rdp file to connect to the VM.

- If you've set up Azure Site Recovery on a host outside of Windows Admin Center, it can't protect VMs from inside Windows Admin Center.

- Windows Admin Center doesn't currently support advanced features available in Hyper-V Manager, such as Virtual SAN Manager, Move VM, Export VM, and VM Replication.

### Virtual switches

When you add network interface controllers (NICs) to a team for switch-embedded teaming (SET), you must make sure they're on the same subnet.

<!--Where I left off.-->

## Computer Management solution

The Computer Management solution contains some Server Manager tools, so the same known issues that apply to Server Manager apply here. We're aware of the following Computer Management solution-specific issues:

- If you sign in to your Windows 10 device with [a Microsoft Account](https://account.microsoft.com/account/) (MSA) or Azure Active Directory (Azure AD), you must use manage-as to provide credentials for a local administrator account.

- When you try to manage the local host, a message appears telling you to elevate the gateway process. If you select **No** in the User Account Control window that appears, you must cancel the connection attempt and start over.

- Windows 10 has WinRM and PowerShell remoting disabled by default.

  - To enable management of the Windows 10 Client, open an elevated PowerShell prompt and run the ```Enable-PSRemoting``` command.

  - You should also update your firewall to allow connections from outside the local subnet by running the ```Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any``` command. For more information about how to update your firewall in more restrictive network scenarios, see [Enable PSRemoting](/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-5.1&preserve-view=true).

## Cluster deployment

This section describes known issues that affect cluster deployment.

### Adding servers to cluster groups

Windows Admin Center doesn't currently support scenarios with mixed work group machines when adding servers. All machines you add to cluster groups must be part of the same work group. If they aren't, an error message appears that says "Cannot create a cluster with servers in different Active Directory domains. Verify the server names are correct. Move all the servers into the same domain and try again." You can't proceed with setting up the cluster unless you use machines from the same work group.

### Enabling Hyper-V on VMs

You can only install and enable Hyper-V on VMs running Azure Stack HCI. Trying to enable Hyper-V on VMs without Azure Stack HCI results in an error, as show in the following screenshot.

<!--Needs better alt text.-->

![Screenshot of Hyper-V enablement error](../media/cluster-create-install-hyperv.png)

To install Hyper-V on VMs running Azure Stack HCI, open an elevated POwerShell prompt and run the following command:

```PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V'
```

### Server restart time after updates

Sometimes servers can take longer than expected to restart after you install updates. Windows Admin Center cluster deployment checks the server restart state periodically to make sure the restart succeeds. However, if you try to restart the server manually without cluster deployment active, then Windows Admin Center can't capture the server state.

To work around this issue, close the cluster deployment feature before manually restarting the server. Once you've restarted the server, you can open cluster deployment again.

### Storage error after deleting a cluster

If you delete a cluster, you can encounter an error if you haven't cleared the storage pools from the deleted cluster yet. The storage pools are locked by the old cluster object, so you must manually clear them.

If you've already encountered this error message, here's how to clear the deleted cluster object from the storage pools:

1. Open an elevated PowerShell window.

1. On all nodes, run the following command:

   ```powershell
   Clear-ClusterNode
   ```

1. Next, remove all pervious storage pools.

1. Run the following commands:

    ```powershell
    get-storagepool
    get-storagepool -IsPrimordial 0 | remove-storagepool
    ```
  
1. If you've configured the storage pools to be read only, then you must change the storage pools to write mode before removing them by running the following command:

    ```powershell
    Get-StoragePool <PoolName> | Set-StoragePool -IsReadOnly $false
    ```

If you haven't encountered this error but want to avoid it, follow these instructions.

1. Open an elevated PowerShell window.

    ```PowerShell
    get-virtualdisk | Remove-VirtualDisk
    ```

1. Run this command to remove the virtual disk:

    ```PowerShell
    get-storagepool
    get-storagepool -IsPrimordial 0 | remove-storagepool
    ```

1. Next, Run this command to remove the storage pools:

    ```PowerShell
    get-storagepool
    get-storagepool -IsPrimordial 0 | remove-storagepool
    ```

1. After that, run this command to remove resources associated with the cluster:

    ```PowerShell
    Get-ClusterResource | ? ResourceType -eq "virtual machine" | Remove-ClusterResource
    Get-ClusterResource | ? ResourceType -like "*virtual machine*" | Remove-ClusterResource
    ```

1. Now, run this command to clean up:

    ```PowerShell
    Remove-Cluster -CleanupAD
    ```

1. Finally, run this command on all nodes:

    ```PowerShell
    Clear-ClusterNode
    ```

### Stretch cluster creation

It is recommended to use servers that are domain-joined when creating a stretch cluster. There is a network segmentation issue when trying to use workgroup machines for stretch cluster deployment due to WinRM limitations.

### Undo and start over

When using same machines repeatedly for cluster deployment, cleanup of previous cluster entities is important to get a successful cluster deployment in the same set of machines. See the page on [deploying hyper-converged infrastructure](../use/deploy-hyperconverged-infrastructure.md#undo-and-start-over) for instructions on how to clean up your cluster.

### CredSSP in cluster creation

The Windows Admin Center cluster deployment feature uses CredSSP. Sometimes, CredSSP can cause an error message that says "There was an error during the validation. Review error and try again" appear when you're validating a cluster, as shown in the following screenshot.

<!--Needs better alt text.-->

:::image type="content" source="../media/cluster-create-credssp-error.jpg" alt-text="Screenshot of cluster create CredSSP error.":::

To resolve this issue:

1. Open an elevated PowerShell window.

1. Disable CredSSP settings on all nodes and the Windows Admin Center gateway machine.

   - Run this command on your gateway machine:  

     ```PowerShell
     Disable-WsmanCredSSP -Role Client
     ```
  
   - Run this command on all nodes in your cluster:

     ```PowerShell
     Disable-WsmanCredSSP -Role Server
     ```

1. Run the following command on all nodes to repair their trusts.

   ```PowerShell
   Test-ComputerSecureChannel -Verbose -Repair -Credential <account name>
   ```

1. Next, open a command prompt and run the following command on all nodes to reset group policy propagated data:

   ```cmd
   gpupdate /force
   ```

1. Reboot each node.

1. After rebooting the nodes, open PowerShell again and run the following command to test the connectivity between your gateway machine and target nodes.

   ```PowerShell
   Enter-PSSession -computername <node fqdn>
   ```

## CredSSP

- When you use the Updates tool, you sometimes see an error message that says "You can't use Cluster-Aware updating tool without enabling CredSSP and providing explicit credentials" when you try to update new clusters, as shown in the following screenshot.

    :::image type="content" source="../media/updates-tool-credssp-error.png" alt-text="Screenshot of Updates tool using Cluster-Aware Updating with Cred S S P error.":::

    <!--Needs better alt text.-->

    To resolve this issue, update Windows Admin Center to version 2110 or later.

- The CredSSP session endpoint permission issue is a common CredSSP error that appears when Windows Admin Center is running on Windows client machines. To resolve this issue, you should add affected users to the Windows Admin Center CredSSP administrators group, then ask the user to sign back in to the desktop computer running WIndows Admin Center.

### Nested virtualization

When you're validating Azure Stack HCI cluster deployments on VMs, you must enable nested virtualization before you enable roles or features by running the following command in PowerShell:

```PowerShell
Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
```

If you're using virtual switch teaming in a VM environment, you also need to run this command on the session host after creating a VM:

```powershell
Get-VM | %{ set-VMNetworkAdapter -VMName $_.Name -MacAddressSpoofing On -AllowTeaming on }
```

If you are a deploying a cluster using the Azure Stack HCI OS, there's an extra requirement. The VM boot virtual hard drive must be preinstalled with Hyper-V features. To do this, run the following command before creating the virtual machines:

```PowerShell
Install-WindowsFeature –VHD <Path to the VHD> -Name Hyper-V, RSAT-Hyper-V-Tools, Hyper-V-PowerShell
```

## Remote direct memory access support

The cluster deployment feature in Windows Admin Center 2007 doesn't support remote direct memory access (RDMA) configurations. To resolve this issue, update to a later version of Windows Admin Center.

## Failover Cluster Manager solution

- When managing a hyper-converged or traditional cluster, you can sometimes see an error message that says "Shell not found." You can do one of the following things to resolve this issue:

  - Reload your browser
  - Go to another tool, then return to Failover Cluster Manager

- You can sometimes encounter an issue when managing a down-level cluster with an incomplete configuration. To resolve this issue, make sure the cluster has the RSAT-Clustering-PowerShell feature installed and enabled on each member node. If not, open PowerShell and enter the following command on each cluster node:
  
  ```powershell
  Install-WindowsFeature -Name RSAT-Clustering-PowerShell
  ```

- If Windows Admin Center can't discover the cluster, try adding it with the entire fully-qualified domain name (FQDN).

- When connecting to a cluster using Windows Admin Center installed as a gateway while using a username and password to authenticate, you must select **Use these credentials for all connections** so to make the credentials available to query the member nodes.

## Hyper-Converged Cluster Manager solution

Windows Admin Center has disabled certain commands, such as **Drives - Update firmware**, **Servers - Remove** and **Volumes - Open**, because it doesn't currently support them.

## Azure services

The following sections describe issues you can encounter when using Azure services while in Windows Admin Center.

### Azure login and gateway registration

- When attempting to register your Windows Admin Center gateway in the Azure China or Azure US Gov cloud domains in version 2211, you may be redirected to the Azure Global sign-in experience. To work around this issue, use an earlier version of Windows Admin Center.

- In the 2009 release, you may run into issues signing in to Azure or registering your Windows Admin Center gateway with Azure. Try doing the following things to troubleshoot the issue:

  - Before using any Azure features in Windows Admin Center, including gateway registration, make sure you've signed in to your Azure account in a different tab or window. We recommend you sign in through the [Azure portal](https://portal.azure.com/).  

  - If you successfully sign in to Azure during gateway registration but don't see visual confirmation on the **Azure** page of your Windows Admin Center settings, refresh the page by going to another page, then returning.

  - The Azure sign-in window sometimes appears more frequently in the 2009 version, forcing administrators to grant users Windows Admin Center permissions more frequently.

  - If you've already given admin approval for Windows Admin Center in the portal but still see an error message that says "Need admin approval," try signing in to Azure using the banners around Windows Admin Center instead of going to the Settings page.

  - If your proxy is misconfigured, you can see an error message that says "Error: Value cannot be null. Parameter name: httpClientFactory." To resolve this issue, go to the **Settings** page and adjust your settings to the correct configuration.

### Azure File Sync permissions

Azure File Sync requires permissions in Azure that Windows Admin Center didn't provide before version 1910. If you registered your Windows Admin Center gateway with Azure using a version earlier than 1910, you must update your Azure Active Directory application in order to use Azure File Sync in the latest version of Windows Admin Center. The additional permissions let Azure File Sync automatically configure storage account access as described in [Ensure Azure File Sync has access to the storage account](/azure/storage/files/storage-sync-files-troubleshoot?tabs=portal1%2cazure-portal#tabpanel_CeZOj-G++Q-5_azure-portal).

There are two ways you can update Azure AD.

<!--Do we change "Azure AD" to "Azure Entra?"-->

To update using the registration method:

1. Go to **Settings** > **Azure** > **Unregister**

1. Register Windows Admin Center with Azure again, making sure you choose to create a new Azure Active Directory application.

To update using Azure:

1. Open Azure AD.

1. Go go to **Settings** > **Azure** > **View in Azure**.

1. In teh **App Registration** tab, go to **API permissions**.

1. Select **Add a permission**.

1. Select **Azure Active Directory Graph** > **Delegated permissions** > **Directory** > **Directory.AccessAsUser.All**.

1. Finally, select **Add permissions** to save the changes you made to the app.

### Options for setting up Azure management services

Azure management services, including Azure Monitor, Azure Update Management, and Azure Security Center, all use the Microsoft Monitoring Agent for on-premises servers. Azure Update Management supports limited regions and needs its Log Analytics workspace linked to an Azure Automation account. If you want to set up multiple services in Windows Admin Center, you need to set up Azure Update Management first, then either Azure Security Center or Azure Monitor.

If you've already configured Azure management services that use the Microsoft Monitoring Agent before trying to use Azure Update Management in Windows Admin Center, the service only lets you configure Azure Update Management if existing resources linked to the Microsoft Monitoring Agent support it.

If the linked resources don't support Azure Update Management, there are two ways you can work around it.

To resolve the issue using the Control Panel:

1. On the Start menu, go to **Control Panel** > **Microsoft Monitoring Agent**.

1. Follow the directions in [How do I stop an agent from communicating wtih Log Analytics](/azure/azure-monitor/platform/log-faq#q-how-do-i-stop-an-agent-from-communicating-with-log-analytics) to disconnect your server from Azure Monitor, Azure Security Center, or other Azure management solutions you're currently using.

1. Set up Azure Update Management in Windows Admin Center.

1. Reconnect to the Azure management solutions you disconnected in step 2.

To resolve the issue using Azure Update Management:

1. Follow the instructions in [Update Management overview](/azure/automation/update-management/overview) to manually set up the Azure resources you need for Azure Update Management.

1. Follow the directions in [Adding or removing a workspace](/azure/azure-monitor/platform/agent-manage#adding-or-removing-a-workspace) to manually update the Microsoft Monitoring Agent outside of Windows Admin Center and add the new workspace for the Update Management solution you want to use.

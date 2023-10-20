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

The Computer Management solution contains a subset of the tools from the Server Manager solution, so the same known issues apply, and the following Computer Management solution-specific issues:

- If you use a Microsoft Account ([MSA](https://account.microsoft.com/account/)) or if you use Azure Active Directory (Azure AD) to log on to your Windows 10 machine, you must use "manage-as" to provide credentials for a local administrator account. [16568455]

- When you try to manage the localhost, you will be prompted to elevate the gateway process. If you click **no** in the User Account Control popup that follows, you must cancel the connection attempt and start over.

- Windows 10 doesn't have WinRM/PowerShell remoting on by default.

  - To enable management of the Windows 10 Client, you must issue the command ```Enable-PSRemoting``` from an elevated PowerShell prompt.

  - You may also need to update your firewall to allow connections from outside the local subnet with ```Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any```. For more restrictive networks scenarios, see how to [enable PSRemoting](/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-5.1&preserve-view=true).

## Cluster Deployment

### Step 1.2
Mixed workgroup machines are currently not supported when adding servers. All machines used for clustering need to belong to same workgroup. If they don't, the next button will be disabled, and the following error will appear: "Cannot create a cluster with servers in different Active Directory domains. Verify the server names are correct. Move all the servers into the same domain and try again."

### Step 1.4
Hyper-V needs to be installed on virtual machines running the Azure Stack HCI OS. Trying to enable the Hyper-V feature for these virtual machines will fail with the error below:

![Screenshot of Hyper-V enablement error](../media/cluster-create-install-hyperv.png)

To install Hyper-V on virtual machines running the Azure Stack HCI OS, run the following command:

```PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V'
```

### Step 1.7
Sometimes servers take longer than expected to restart after updates are installed. The Windows Admin Center cluster deployment wizard will check the server restart state periodically to know if the server was restarted successfully. However, if the user restarts the server outside of the wizard manually, then the wizard doesn't have a way to capture the server state in an appropriate way.

If you would like to restart the server manually, exit the current wizard session. After you have restarted the server, you may restart the wizard.

### Stage 4 Storage
In stage 4, an error can occur if a user has deleted a cluster and has not cleared the storage pools from the cluster. That means the storage pools that are on the system are locked by the old cluster object and only the user can manually clear them. 

To clear the configuration, the user needs to run:

1. On all nodes run: ```Clear-ClusterNode```
2. Remove all previous storage pools, you can then run: 
    ```PowerShell
    get-storagepool
    get-storagepool -IsPrimordial 0 | remove-storagepool
    ```
  > [!Note]
  > If the storage pools are set as readonly which can sometimes happen if the cluster is improperly destroyed, then the user needs to first make sure the storage pools are changed to editable before removing. Run the following before the commands above: ```
  Get-StoragePool <PoolName> | Set-StoragePool -IsReadOnly $false```

To avoid this scenario in the first place, the user will need to run the following: 

1. Remove virtual disk:
    ```PowerShell
    get-virtualdisk | Remove-VirtualDisk
    ```
2. Remove storage pools:
    ```PowerShell
    get-storagepool
    get-storagepool -IsPrimordial 0 | remove-storagepool
    ```
3. Remove cluster resources:
    ```PowerShell
    Get-ClusterResource | ? ResourceType -eq "virtual machine" | Remove-ClusterResource
    Get-ClusterResource | ? ResourceType -like "*virtual machine*" | Remove-ClusterResource
    ```
4. Cleaning up:
    ```PowerShell
    Remove-Cluster -CleanupAD
    ```
5. On all nodes run: 
    ```PowerShell
    Clear-ClusterNode
    ```

### Stretch cluster creation
It is recommended to use servers that are domain-joined when creating a stretch cluster. There is a network segmentation issue when trying to use workgroup machines for stretch cluster deployment due to WinRM limitations.

### Undo and start over
When using same machines repeatedly for cluster deployment, cleanup of previous cluster entities is important to get a successful cluster deployment in the same set of machines. See the page on [deploying hyper-converged infrastructure](../use/deploy-hyperconverged-infrastructure.md#undo-and-start-over) for instructions on how to clean up your cluster.

### CredSSP in cluster creation
The Windows Admin Center cluster deployment wizard uses CredSSP in several places. You run into the error message **There was an error during the validation. Review error and try again** (this occurs most frequently in the Validate cluster step):

:::image type="content" source="../media/cluster-create-credssp-error.jpg" alt-text="Screenshot of cluster create CredSSP error.":::

You can use the following steps to troubleshoot:

1. Disable CredSSP settings on all nodes and the Windows Admin Center gateway machine. Run the first command on your gateway machine and the second command on all of the nodes in your cluster:
   
   ```PowerShell
   Disable-WsmanCredSSP -Role Client
   ```
   
   ```PowerShell
   Disable-WsmanCredSSP -Role Server
   ```

2. Repair the trust on all nodes. Run the following command on all nodes:
   
   ```PowerShell
   Test-ComputerSecureChannel -Verbose -Repair -Credential <account name>
   ```

3. Reset group policy propagated data by running the following command on all nodes:
   
   ```Command Line
   gpupdate /force
   ```

4. Reboot each node. After reboot, test the connectivity between your gateway machine and target nodes, and your connectivity between nodes, using the following command:
   
   ```PowerShell
   Enter-PSSession -computername <node fqdn>
   ```
   
## CredSSP

- The **Updates** tool will sometimes throw the CredSSP error **You can't use Cluster-Aware updating tool without enabling CredSSP and providing explicit credentials**:

    :::image type="content" source="../media/updates-tool-credssp-error.png" alt-text="Screenshot of Updates tool using Cluster-Aware Updating with Cred S S P error.":::

    This error was widely seen when new clusters are created and then you try to access the **Updates** tool for these clusters in Windows Admin Center. This issue is fixed in Windows Admin Center v2110. [36734941]

- The CredSSP session endpoint permission issue is a common CredSSP error that can be seen when Windows Admin Center runs on Windows client machines. This issue is widely seen when the user who is using Windows Admin Center isn't the same user who installed Windows Admin Center on the client machine.

    To mitigate this problem, we have introduced the Windows Admin Center CredSSP administrators' group. The user facing this problem should be added to this group and then relogin to the desktop computer running Windows Admin Center. Below is an image of what the error notification was before (left) and after (right) the modification:

    :::image type="content" source="../media/notification-credssp-error.png" alt-text="A side by side comparison of the error notification for Cred S S P.":::

### Nested Virtualization
When validating Azure Stack HCI OS cluster deployment on virtual machines, nested virtualization needs to be turned on before roles/features are enabled using the below PowerShell command:

```PowerShell
Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
```

  > [!Note]
  > For virtual switch teaming to be successful in a virtual machine environment, the following command needs to be run in PowerShell on the host soon after the virtual machines are created: Get-VM | %{ set-VMNetworkAdapter -VMName $_.Name -MacAddressSpoofing On -AllowTeaming on }

If you are a deploying a cluster using the Azure Stack HCI OS, there's an extra requirement. The VM boot virtual hard drive must be preinstalled with Hyper-V features. To do this, run the following command before creating the virtual machines:

```PowerShell
Install-WindowsFeature –VHD <Path to the VHD> -Name Hyper-V, RSAT-Hyper-V-Tools, Hyper-V-PowerShell
```

### Support for RDMA
The cluster deployment wizard in Windows Admin Center version 2007 doesn't provide support for RDMA configuration.

## Failover Cluster Manager solution

- When managing a cluster, (either Hyper-Converged or traditional) you may encounter a **shell was not found** error. If this happens either reload your browser, or navigate away to another tool and back. [13882442]

- An issue can occur when managing a down-level (Windows Server 2012 or 2012 R2) cluster that hasn't been configured completely. The fix for this issue is to ensure that the Windows feature **RSAT-Clustering-PowerShell** has been installed and enabled on **each member node** of the cluster. To do this with PowerShell, enter the command `Install-WindowsFeature -Name RSAT-Clustering-PowerShell` on all the cluster nodes. [12524664]

- The Cluster may need to be added with the entire FQDN to be discovered correctly.

- When connecting to a cluster using Windows Admin Center installed as a gateway, and providing explicit username/password to authenticate, you must select **Use these credentials for all connections** so that the credentials are available to query the member nodes.

## Hyper-Converged Cluster Manager solution

- Some commands such as **Drives - Update firmware**, **Servers - Remove** and **Volumes - Open** are disabled and currently not supported.

## Azure services

### Azure login and gateway registration
When attempting to register your Windows Admin Center gateway in the Azure China or Azure US Gov cloud domains in version 2211, you may be redirected to the Azure Global sign-in experience. To work around this issue, please use an earlier version of Windows Admin Center.    
   
In the 2009 release, you may run into issues logging into Azure or registering your Windows Admin Center gateway with Azure. The guidance below should help you mitigate these issues: 

* Before using any Azure capabilities within Windows Admin Center, including gateway registration, make sure you are signed into your Azure account in a different tab or window. We suggest signing in through the [Azure portal](https://portal.azure.com/).  

* If you successfully sign into Azure during gateway registration but don't see visual confirmation on the **Azure** page of your Windows Admin Center settings, try navigating to a different page in settings before navigating back to the **Azure** page. 

* The Azure sign-in pop-up may appear more frequently in this build and may require administrators to grant Windows Admin Center permissions more frequently. 

* If you have already given admin approval for Windows Admin Center in the Azure portal and you are still seeing an error message saying “Need admin approval”, try signing into Azure using one of the banners around Windows Admin Center instead of in the **Settings** page. 
   
* If your proxy is mis-configured, then you may get the error message "Error: Value cannot be null. Parameter name: httpClientFactory." Ensure that your proxy is configured correctly by going to **Settings** page. 

### Azure File Sync permissions

Azure File Sync requires permissions in Azure that Windows Admin Center did not provide prior to version 1910. If you registered your Windows Admin Center gateway with Azure using a version earlier than Windows Admin Center version 1910, you will need to update your Azure Active Directory application to get the correct permissions to use Azure File Sync in the latest version of Windows Admin Center. The additional permission allows Azure File Sync to perform automatic configuration of storage account access as described in this article: [Ensure Azure File Sync has access to the storage account](/azure/storage/files/storage-sync-files-troubleshoot?tabs=portal1%2cazure-portal#tabpanel_CeZOj-G++Q-5_azure-portal).

To update your Azure Active Directory app, you can do one of two things
1. Go to **Settings** > **Azure** > **Unregister**, and then register Windows Admin Center with Azure again, making sure you choose to create a new Azure Active Directory application.
2. Go to your Azure Active Directory application and manually add the permission needed to your existing Azure Active Directory app registered with Windows Admin Center. To do this, go to **Settings** > **Azure** > **View in Azure**. From the **App Registration** blade in Azure, go to **API permissions**, select **Add a permission**. Scroll down to select **Azure Active Directory Graph**, select **Delegated permissions**, expand **Directory**, and select **Directory.AccessAsUser.All**. Click **Add permissions** to save the updates to the app.

### Options for setting up Azure management services

Azure management services including Azure Monitor, Azure Update Management, and Azure Security Center, use the same agent for an on-premises server: the Microsoft Monitoring Agent. Azure Update Management has a more limited set of supported regions and requires the Log Analytics workspace to be linked to an Azure Automation account. Because of this limitation, if you wish to set up multiple services in Windows Admin Center, you must set up Azure Update Management first, and then either Azure Security Center or Azure Monitor. If you've configured any Azure management services that use the Microsoft Monitoring Agent, and then try to set up Azure Update Management using Windows Admin Center, Windows Admin Center will only allow you to configure Azure Update Management if the existing resources linked to the Microsoft Monitoring Agent support Azure Update Management. If not, you have two options:

1. Go to the Control Panel > Microsoft Monitoring Agent to [disconnect your server from the existing Azure management solutions](/azure/azure-monitor/platform/log-faq#q-how-do-i-stop-an-agent-from-communicating-with-log-analytics) (like Azure Monitor or Azure Security Center). Then set up Azure Update Management in Windows Admin Center. After that, you can go back to set up your other Azure management solutions through Windows Admin Center without issues.
2. You can [manually set up the Azure resources needed for Azure Update Management](/azure/automation/update-management/overview) and then [manually update the Microsoft Monitoring Agent](/azure/azure-monitor/platform/agent-manage#adding-or-removing-a-workspace) (outside of Windows Admin Center) to add the new workspace corresponding to the Update Management solution you wish to use.

---
title: Install the BranchCache Feature and Configure the Hosted Cache Server by Service Connection Point
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d44071ba-62d4-476b-b9fe-a616a5f4f543
author: vhorne
---
# Install the BranchCache Feature and Configure the Hosted Cache Server by Service Connection Point
You can use this procedure to install the BranchCache feature on your hosted cache server, HCS1, and to configure the server to register a Service Connection Point \(SCP\) in Active Directory Domain Services \(AD DS\).  
  
When you register hosted cache servers with an SCP in AD DS, the SCP allows client computers that are configured correctly to automatically discover hosted cache servers by querying AD DS for the SCP. Instructions on how to configure client computers to perform this action are provided later in this guide.  
  
> [!IMPORTANT]  
> Before you perform this procedure, you must join the computer to the domain and configure the computer with a static IP address.  
  
To perform this procedure, you must be a member of the Administrators group.  
  
### To install the BranchCache feature and configure the hosted cache server  
  
1.  On the server computer desktop, in the Taskbar, right\-click the Windows PowerShell icon, right\-click the words **Windows PowerShell**, and then click **Run as Administrator**.  
  
    > [!NOTE]  
    > If you have previously run Windows PowerShell as an Administrator on this computer, you do not need to right\-click the words **Windows PowerShell**, because **Run as Administrator** is present as a right\-click menu option.  
  
2.  Windows PowerShell opens. Type the following command, and then press ENTER.  
  
    ```  
    Install-WindowsFeature BranchCache  
    ```  
  
3.  To configure the computer as a hosted cache server after the BranchCache feature is installed, and to register a Service Connection Point in AD DS, type the following command in Windows PowerShell, and then press ENTER.  
  
    ```  
    Enable-BCHostedServer -RegisterSCP  
    ```  
  
4.  To verify the hosted cache server configuration, type the following command and press ENTER.  
  
    ```  
    Get-BCStatus  
    ```  
  
    The results of the command display status for all aspects of your BranchCache installation. Following are a few of the BranchCache settings and the correct value for each item:  
  
    -   BranchCacheIsEnabled: True  
  
    -   HostedCacheServerIsEnabled: True  
  
    -   HostedCacheScpRegistrationEnabled: True  
  
5.  To prepare for the step of copying your data packages from your content servers to your hosted cache servers, either identify an existing share on the hosted cache server or create a new folder and share the folder so that it is accessible from your content servers. After you create your data packages on your content servers, you will copy the data packages to this shared folder on the hosted cache server.  
  
6.  If you are deploying more than one hosted cache server, repeat this procedure on each server.  
  

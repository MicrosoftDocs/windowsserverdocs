---
title: Install the BranchCache Feature and Configure the Hosted Cache Server by Service Connection Point
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: 9adf420b-5a58-4e59-9906-71bd58f757fd
ms.author: lizross
author: eross-msft
---

# Install the BranchCache Feature and Configure the Hosted Cache Server by Service Connection Point

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use this procedure to install the BranchCache feature on your hosted cache server, HCS1, and to configure the server to register a Service Connection Point \(SCP\) in Active Directory Domain Services \(AD DS\).

When you register hosted cache servers with an SCP in AD DS, the SCP allows client computers that are configured correctly to automatically discover hosted cache servers by querying AD DS for the SCP. Instructions on how to configure client computers to perform this action are provided later in this guide.

>[!IMPORTANT]
>Before you perform this procedure, you must join the computer to the domain and configure the computer with a static IP address.

To perform this procedure, you must be a member of the Administrators group.

## To install the BranchCache feature and configure the hosted cache server  

1. On the server computer, run Windows PowerShell as an Administrator. Type the following command, and then press ENTER.

    ``` 
    Install-WindowsFeature BranchCache
    ```

2.  To configure the computer as a hosted cache server after the BranchCache feature is installed, and to register a Service Connection Point in AD DS, type the following command in Windows PowerShell, and then press ENTER.

    ```  
    Enable-BCHostedServer -RegisterSCP
    ```  

3. To verify the hosted cache server configuration, type the following command and press ENTER.

    ```  
    Get-BCStatus  
    ```  
  
    The results of the command display status for all aspects of your BranchCache installation. Following are a few of the BranchCache settings and the correct value for each item:  
  
    -   BranchCacheIsEnabled: True

    -   HostedCacheServerIsEnabled: True

    -   HostedCacheScpRegistrationEnabled: True

4. To prepare for the step of copying your data packages from your content servers to your hosted cache servers, either identify an existing share on the hosted cache server or create a new folder and share the folder so that it is accessible from your content servers. After you create your data packages on your content servers, you will copy the data packages to this shared folder on the hosted cache server.
  
5. If you are deploying more than one hosted cache server, repeat this procedure on each server.

To continue with this guide, see [Move and Resize the Hosted Cache &#40;Optional&#41;](6-Bc-Move-Resize-Cache.md).

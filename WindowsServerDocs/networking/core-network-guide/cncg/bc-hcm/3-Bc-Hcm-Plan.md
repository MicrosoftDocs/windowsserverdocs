---
title: BranchCache Hosted Cache Mode Deployment Planning
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: bc44a7db-f7a5-4e95-9d95-ab8d334e885f
ms.author: lizross
author: eross-msft
---

# BranchCache Hosted Cache Mode Deployment Planning

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use this topic to plan your deployment of BranchCache in Hosted Cache mode.

>[!IMPORTANT]
>Your hosted cache server must be running Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012.

Before you deploy your hosted cache server, you must plan the following items:

- [Plan basic server configuration](#bkmk_basic)

- [Plan domain access](#bkmk_domain)

- [Plan the location and size of the hosted cache](#bkmk_cachelocation)

- [Plan the share to which the content server packages are to be copied](#bkmk_package)

- [Plan prehashing and data package creation on content servers](#bkmk_prehash)

## <a name="bkmk_basic"></a>Plan basic server configuration
  
If you are planning on using an existing server in your branch office as your hosted cache server, you do not need to perform this planning step, because the computer is already named and has an IP address configuration.

After you install Windows Server 2016 on your hosted cache server, you must rename the computer and assign and configure a static IP address for the local computer.

>[!NOTE]
>In this guide, the hosted cache server is named HCS1, however you should use a server name that is appropriate for your deployment.

## <a name="bkmk_domain"></a>Plan domain access

If you are planning on using an existing server in your branch office as your hosted cache server, you do not need to perform this planning step, unless the computer is not currently joined to the domain.
  
To log on to the domain, the computer must be a domain member computer and the user account must be created in AD DS before the logon attempt. In addition, you must join the computer to the domain with an account that has the appropriate group membership.

## <a name="bkmk_cachelocation"></a>Plan the location and size of the hosted cache

On HCS1, determine where on your hosted cache server you want to locate the hosted cache. For example, decide the hard disk, volume, and folder location where you plan to store the cache.

In addition, decide what percentage of disk space you want to allocate for the hosted cache.

## <a name="bkmk_package"></a>Plan the share to which the content server packages are to be copied

After you create data packages on your content servers, you must copy them over the network to a share on your hosted cache server.

Plan the folder location and sharing permissions for the shared folder. In addition, if your content servers host a large amount of data and the packages that you create will be large files, plan to perform the copy operation during off\–peak hours so that WAN bandwidth is not consumed by the copy operation during a time when others need to use the bandwidth for normal business operations.

## <a name="bkmk_prehash"></a>Plan prehashing and data package creation on content servers

Before you prehash content on your content servers, you must identify the folders and files that contain content that you want to add to the data package. 

In addition, you must plan on the local folder location where you can store the data packages before copying them to the hosted cache server.

To continue with this guide, see [BranchCache Hosted Cache Mode Deployment](4-Bc-Hcm-Deployment.md).

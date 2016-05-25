---
title: Install Windows Server 2008 on the First Domain Controller in a New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6c00f67d-2cd1-4388-98b5-4663f2526fab
author: Femila
---
# Install Windows Server 2008 on the First Domain Controller in a New Regional Domain
The first step in deploying the new regional domain is to install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] on the first computer that you want to make the domain controller.  
  
> [!IMPORTANT]  
> Before you install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], verify that Domain Name System \(DNS\) was never previously installed on the computer that you want to make the domain controller. If DNS was previously installed, configuration of the DNS resolver and forwarders might fail.  
  
### To install Windows Server 2008  
  
1.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DVD into the DVD drive of the domain controller, and then select the option to install the operating system.  
  
    As an alternative, you can use an automated installation method.  
  
2.  Use the NTFS file system to format the partitions.  
  
    Enter the computer name, static IP address, and subnet mask that are specified by your design. Enter a strong administrator password.  
  
3.  Enable Remote Desktop to enable administrators to log on remotely, if necessary.  
  
    To enable Remote Desktop, in **Server Manager**, click **Configure Remote Desktop**, and then click **Allow connections from computers running any version of Remote Desktop \(less secure\)** or **Allow connections only from computers running Remote Desktop with Network Level Authentication \(more secure\)**.  
  

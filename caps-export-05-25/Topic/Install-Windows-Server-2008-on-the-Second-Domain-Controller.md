---
title: Install Windows Server 2008 on the Second Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: baac4b12-e772-4274-a4a1-b1c8afcddd69
author: Femila
---
# Install Windows Server 2008 on the Second Domain Controller
The following procedure shows how to install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] on a computer that you want to make a domain controller.  
  
### To install Windows Server 2008  
  
1.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system DVD into the DVD drive of the domain controller, and then select the option to install the operating system.  
  
    As an alternative, you can use an automated installation method.  
  
2.  Use the NTFS file system to format the partitions.  
  
    Enter the computer name, static IP address, and subnet mask that are specified by your design. Enter a strong administrator password.  
  
3.  Enable Remote Desktop to enable administrators to log on remotely if necessary.  
  
    To enable Remote Desktop, in **Server Manager**, click **Configure Remote Desktop**, and then click **Allow connections from computers running any version of Remote Desktop \(less secure\)** or **Allow connections only from computers running Remote Desktop with Network Level Authentication \(more secure\)**.  
  

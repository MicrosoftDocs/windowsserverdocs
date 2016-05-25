---
title: Determine Supported Software Upgrades
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dfc01459-dc5f-41a6-89b6-7fad6814669c
author: Femila
---
# Determine Supported Software Upgrades
Identify the editions of Windows 2000 or Windows Server 2003 that are running in your environment. Then, determine if you can upgrade these editions or if you must perform complete operating system reinstallations.  
  
> [!IMPORTANT]  
> To upgrade Windows 2000 Active Directory domains to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Active Directory Domain Services \(AD DS\) domains, you must perform an in\-place upgrade of all existing domain controllers running Windows 2000 in the forest to domain controllers running Windows Server 2003. Then, perform an in\-place upgrade of those domain controllers to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. A direct in\-place upgrade of a Windows 2000 edition to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] edition is not supported.  
  
The following table lists Windows 2000 editions and indicates what editions can be upgraded directly to each edition of Windows Server 2003.  
  
|Windows 2000 editions|Upgrade to Windows Server 2003 Standard Edition|Upgrade to Windows Server 2003 Enterprise Edition|Upgrade to Windows Server 2003 Datacenter Edition|  
|-------------------------|---------------------------------------------------|-----------------------------------------------------|-----------------------------------------------------|  
|Windows 2000 Professional||||  
|Windows 2000 Server|![](../Image/table-bullet.gif)|![](../Image/table-bullet.gif)||  
|Windows 2000 Advanced Server||![](../Image/table-bullet.gif)||  
|Windows 2000 Datacenter Server|||![](../Image/table-bullet.gif)|  
  
The following table lists Windows Server 2003 editions and indicates what editions can be upgraded directly to each edition of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
> [!NOTE]  
> With the exception of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] editions for Itanium\-Based Systems, this table applies equally to 32\-bit and 64\-bit [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] editions. However, upgrades from 32\-bit to 64\-bit \(and from 64\-bit to 32\-bit\) are not supported.  
>   
> The information in this guide also applies to Windows Server 2008 R2. If you perform an in\-place upgrade of the existing domain controllers running Windows Server 2003 in the forest to Windows Server 2008 R2, remember that Windows Server 2008 R2 is an x64\-based operating system. If your server is running an x64\-based version of Windows Server 2003, you can successfully perform an in\-place upgrade of this computer's operating system to Windows Server 2008 R2. If your server is running an x86\-based version of Windows Server 2003, you cannot upgrade this computer to Windows Server 2008 R2. For more information about supported upgrade options, see [Supported in\-place upgrade paths](assetId:///255b83fa-5f20-455a-b6b0-bef198979268#BKMK_SupportedUpgrade).  
  
|Windows Server 2003 editions|Upgrade to [!INCLUDE[nextref_longhornstd](../Token/nextref_longhornstd_md.md)]|Upgrade to [!INCLUDE[nextref_longhornent](../Token/nextref_longhornent_md.md)]|Upgrade to [!INCLUDE[nextref_longhorndat](../Token/nextref_longhorndat_md.md)]|  
|--------------------------------|----------------------------------------------------------------------------------|----------------------------------------------------------------------------------|----------------------------------------------------------------------------------|  
|-   Windows Server 2003 Standard Edition with Service Pack 1 \(SP1\)<br />-   Windows Server 2003 Standard Edition with Service Pack 2 \(SP2\)<br />-   Windows Server 2003 R2 Standard Edition|![](../Image/table-bullet.gif)|![](../Image/table-bullet.gif)||  
|-   Windows Server 2003 Enterprise Edition with SP1<br />-   Windows Server 2003 Enterprise Edition with SP2<br />-   Windows Server 2003 R2 Enterprise Edition||![](../Image/table-bullet.gif)||  
|-   Windows Server 2003 Datacenter Edition with SP1<br />-   Windows Server 2003 Datacenter Edition with SP2<br />-   Windows Server 2003 R2 Datacenter Edition|||![](../Image/table-bullet.gif)|  
  

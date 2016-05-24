---
title: Adjust Forest Functional Level
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9e1e22d3-3de3-40cb-a159-1045920437c5
author: Femila
---
# Adjust Forest Functional Level
  You can use this procedure to adjust the forest functional level for a domain rename operation. The domain rename operation is supported within an Active Directory forest if, and only if, all domain controllers in the forest are running Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Standard Edition, Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Enterprise Edition, or Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Datacenter Edition, and the forest functionality has been raised to Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Therefore, before you can rename a domain in your Active Directory forest, you must ensure that the forest functionality has been set to at least Windows Server 2003 or raised to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
## Setting forest functional level to Windows Server 2003 or Windows Server 2008  
 You can set the forest functional level to Windows Server 2003 if all domain controllers in the forest run either Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating systems. If any domain controller in the forest is still running Windows 2000, you cannot set the forest functional level to Windows Server 2003.  
  
 You can set the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] if all domain controllers in the forest run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system. If any domain controller in the forest is still running Windows Server 2003, you cannot set the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 For more information, see Understanding AD DS Functional Levels \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124107](http://go.microsoft.com/fwlink/?LinkId=124107)\).  
  
#### To set the forest functional level to Windows Server 2003 or Windows Server 2008  
  
1.  Open the Active Directory Domains and Trusts snap\-in: click **Start**, click **Administrative Tools**, and then click **Active Directory Domains and Trusts**.  
  
2.  In the console tree, right\-click **Active Directory Domains and Trusts**, and then click **Raise Forest Functional Level**.  
  
3.  In **Select an available forest functional level**, do one of the following:  
  
    -   To raise the forest functional level to Windows Server 2003, click **Windows Server 2003**, and then click **Raise**.  
  
    -   To raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], click [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and then click **Raise**.  
  
    > [!CAUTION]  
    >  Do not raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] if you have, or will have, any domain controllers that are running Windows Server 2003 or earlier. After you raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you cannot change the level back to Windows Server 2003.  
  
  
---
title: Introduction to Administering Active Directory Domain Rename
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c2ffeb01-4bf6-4c7c-8d90-20ee7320002e
author: Femila
---
# Introduction to Administering Active Directory Domain Rename
  You can use the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain rename process to change the names of your Active Directory domains, and you can also use it to change the structure of the domain trees in your Active Directory forest. This process involves updating the Domain Name System \(DNS\) and trust infrastructures as well as Group Policy and Service Principal Names \(SPNs\).  
  
 The ability to rename domains gives you the flexibility to make important name changes and forest structural changes as the needs of your organization change. Using domain rename, you can change the name of a domain, but you can also change the structure of the domain hierarchy. You can also change the parent of a domain or move a domain in one domain tree to another domain tree. The domain rename process can accommodate scenarios involving acquisitions, mergers, or name changes in your organization, but it is not designed to accommodate forest mergers or the movement of domains between forests.  
  
> [!IMPORTANT]  
>  It is extremely important and highly recommended that you test the domain rename operation before you perform it in a production environment. First, perform the domain rename operation that is described in this section in a test environment that has a minimum of two domains. Familiarizing yourself with the specifics of each stage in the domain rename operation in a test environment will provide you with not only a much better understanding of the operation itself but also better prepare you to troubleshoot any issues that may arise during the domain rename operation in a production forest.  
  
 For more information, see Domain Rename Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122922](http://go.microsoft.com/fwlink/?LinkID=122922)\).  
  
## Domain rename requirements  
 The following conditions must be in effect before you can begin a domain rename operation:  
  
-   **Forest functionality**: You can rename domains only in a forest where all of the domain controllers are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 Standard Edition, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 Enterprise Edition, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 Datacenter Edition operating systems, and the Active Directory forest functional level has been raised to either Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The domain rename operation will not be successful if the forest functional level is set to Windows 2000 native. For more information about forest functional levels and for procedures to determine and set forest functional levels, see Enabling Windows Server 2008 Advanced Features for Active Directory Domain Services \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=105303](http://go.microsoft.com/fwlink/?LinkID=105303)\).  
  
-   **Administrative credentials**: You must have Enterprise Admins credentials to perform the various procedures for the domain rename operation. If you are running Microsoft Exchange, the account that you use must also have Full Exchange Administrator credentials.  
  
-   **Control station**: The computer that you use as the control station for the domain rename operation must be a member computer \(not a domain controller\) running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Standard Edition, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Enterprise Edition, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Datacenter Edition.  
  
-   **Distributed File System \(DFS\) root servers**: So that you can rename a domain with domain\-based DFS Namespace \(DFSN\) roots, all DFSN root servers must be running Windows 2000 with Service Pack 3 \(SP3\), Windows Server 2003, or Windows Server 2008 operating systems.  
  
-   **Exchange 2003 Service Pack 1 \(SP1\)**: If your forest contains Exchange 2003 Service Pack 1 \(SP1\) servers, you can run the Windows Server 2008 domain rename operation, but you must also use the Exchange Domain Rename Fix\-up Tool to update Exchange attributes. For more information, see Microsoft Exchange Server Domain Rename Fixup \(XDR\-Fixup\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122982](http://go.microsoft.com/fwlink/?LinkID=122982)\). The document that accompanies this tool describes when and how to perform Exchange\-related tasks. To perform a domain rename operation, Exchange must not be installed on any domain controllers. If a domain controller is running Exchange, move the Exchange data off the domain controller and then uninstall Exchange.  
  
    > [!IMPORTANT]  
    >  The domain rename operation is not supported in Microsoft Exchange Server 2007 or Exchange Server 2010. DNS domain rename is supported in Exchange Server 2003. However, renaming of the NetBIOS domain name is not supported in any version of Exchange Server. Other non\-Microsoft applications might also not support domain rename.  
    >   
    >  For more information about other Microsoft applications that are incompatible with domain rename, see [article 300684](http://go.microsoft.com/fwlink/?LinkId=185229) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=185229\) in the Microsoft Knowledge Base.  
  
> [!NOTE]  
>  You can use "Checklist: Satisfying Domain Rename Requirements" in [Appendix C: Checklists for the Domain Rename Operation](../Topic/Appendix-C--Checklists-for-the-Domain-Rename-Operation.md) to make sure that you have met all the necessary requirements for the domain rename operation.  
  
  
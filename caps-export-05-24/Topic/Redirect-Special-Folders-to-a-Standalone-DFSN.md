---
title: Redirect Special Folders to a Standalone DFSN
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 61bb130f-447a-4c1f-b2c4-cb3d2dbdee16
author: Femila
---
# Redirect Special Folders to a Standalone DFSN
  You can use this procedure to redirect special folders to the standalone Distributed File System Namespaces \(DFSN\) for domain rename. Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] help redirect a set of special folders for users, such as the My Documents folder, from the local computer to a network location. Folder Redirection is an extension to Group Policy that you can use to identify network locations for these folders on specific servers or DFSN. If you redirect folders to a network location that uses domain\-based DFSN \(*Domain\_Name*\\*DFSN\_Name*\), renaming the Active Directory domain invalidates the path to the domain\-based DFSN. If the redirected path is no longer valid, Folder Redirection stops working.  
  
> [!NOTE]  
>  If the NetBIOS name of a domain is used in a domain\-based DFSN and the NetBIOS name of the domain is not changed during the domain rename operation, the path to this domain\-based DFSN will continue to be valid.  
  
 So that Folder Redirection can continue to work after a domain rename operation, folders that are redirected to a domain\-based DFSN for a domain that is going to be renamed must instead be redirected to a standalone DFSN \(also known as server\-based DFSN\) before you rename the domain. Stand\-alone DFSNs are not affected by the domain rename operation. You can configure Folder Redirection to a stand\-alone DFSN instead of a domain\-based DFSN by using the Folder Redirection Group Policy extension. For information about how to use Group Policy to redirect special folders to a network location, see Use Folder Redirection \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124089](http://go.microsoft.com/fwlink/?LinkId=124089)\).  
  
  
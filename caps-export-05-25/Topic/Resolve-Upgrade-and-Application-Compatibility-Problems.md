---
title: Resolve Upgrade and Application Compatibility Problems
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9b722fba-8c52-4122-87eb-bafebaacd51c
author: Femila
---
# Resolve Upgrade and Application Compatibility Problems
For more information about upgrades to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Known Issues for Upgrades to Windows Server 2008 and Windows Server 2008 R2](assetId:///255b83fa-5f20-455a-b6b0-bef198979268#BKMK_KnownIssues).  
  
## Known issues for upgrading to Windows Server 2003  
Before upgrading a server to Windows Server 2003, use the **Winnt32.exe** command\-line tool with the **\/checkupgradeonly** parameter to identify potential upgrade problems such as inadequate hardware resources or compatibility problems.  
  
Two application compatibility problems you might need to resolve include the following:  
  
-   Distributed File System \(DFS\) root shares are not supported if they are hosted on a file allocation table \(FAT\) partition.  
  
    In Windows Server 2003, DFS root shares must be located on NTFS partitions with no files or directories under the DFS link.  
  
    For more information about deploying DFS, see Designing and Deploying File Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=27928](http://go.microsoft.com/fwlink/?LinkID=27928)\).  
  
-   Windows 2000–based computers running Windows Deployment Services might cause errors in a Windows Server 2003 Active Directory domain.  
  
    When using a Windows 2000–based Windows Deployment Services server in your Windows Server 2003 Active Directory domain, you might receive the following error when using the Client Installation Wizard:  
  
    ```  
    " Unable to create or Modify Computer account"   
    Error: 00004E4F  
    ```  
  
    This error occurs because Windows Server 2003 creates machine account objects differently from Windows 2000. To prevent this error from occurring when creating machine accounts, configure the Windows 2000–based Windows Deployment Services servers in your environment to point to a domain controller running Windows 2000. This is done by adding the **DefaultServer** registry parameter to the Windows 2000–based Windows Deployment Services servers.  
  
    For more information about configuring optional registry parameters for the Boot Information Negotiation Layer \(BINL\) service, see article 235979 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=106488](http://go.microsoft.com/fwlink/?LinkId=106488)\).  
  
    You must remove the Windows 2000 Administration Tools Pack before upgrading to Windows Server 2003. For more information about Windows 2000 administration tools and upgrade issues, see article 304718 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=106490](http://go.microsoft.com/fwlink/?LinkId=106490)\).  
  
Membership in the local **Administrator** account, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To identify potential upgrade and compatibility problems  
  
-   At the command line, connect to the I386 directory at your installation source, type the following command, and then press ENTER:  
  
    **winnt32 \/checkupgradeonly**  
  
|Parameter|Description|  
|-------------|---------------|  
|winnt32 \/checkupgradeonly|Checks your computer for upgrade compatibility with products in the Windows Server 2003 family.|  
  

---
title: Requirements for Installing AD DS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 398f446a-1c1b-4358-8916-ad65ec7909a9
author: Femila
---
# Requirements for Installing AD DS
  For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] hardware requirements, see Installing Windows Server 2008 at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111104](http://go.microsoft.com/fwlink/?LinkId=111104).  
  
 The following software and hardware requirements apply to a full installation or a Server Core installation of the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system. For information about configuring a Server Core installation, see Server Core Installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Step\-By\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=87786](http://go.microsoft.com/fwlink/?LinkId=87786)\).  
  
-   Install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Verify that a Domain Name System \(DNS\) infrastructure is in place. Before you add Active Directory Domain Services \(AD DS\) to create a domain or forest, be sure that a DNS infrastructure is in place on your network. When you install AD DS, you can include DNS server installation, if it is needed. When you create a new domain, a DNS delegation is created automatically during the installation process.  
  
     If a DNS infrastructure is not in place when you install an additional domain controller in a domain, then the option to install DNS server on that domain controller will not be available.  
  
-   Configure appropriate TCP\/IP and DNS server addresses.  
  
-   Verify that Adprep.exe operations are complete. Before you can add AD DS to a server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in an existing Active Directory environment, you must prepare the environment by running Adprep.exe. For more information about running Adprep.exe, see [Running Adprep.exe](../Topic/Running-Adprep.exe.md#BKMK_RunAdprep).  
  
    > [!NOTE]  
    >  In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is available in the \/sources\/adprep folder of the installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/support\/adprep folder.  
  
-   In order to install a read\-only domain controller \(RODC\), there must be a writable domain controller running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the domain. The Active Directory Domain Services Installation Wizard makes a DC Locator call during forest examination with specific options to find a writable domain controller \(using the DS\_WRITABLE\_REQUIRED flag\) that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(using the DS\_DIRECTORY\_SERVICE\_6\_REQUIRED flag\). If the call succeeds and a domain controller that matches these options is found, the check box to install an RODC is enabled. For more information about these options, see [DsGetDcName Function](http://go.microsoft.com/fwlink/?LinkId=100509) \( HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=100509" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=100509\).  
  
-   When you use an answer file to perform an unattended installation of AD DS, specify a \[DCINSTALL\] section in the answer file with appropriate parameters. For a list of entries for the \[DCINSTALL\] section of the answer file, see [Appendix of Unattended Installation Parameters](../Topic/Appendix-of-Unattended-Installation-Parameters.md).  
  
-   The drives that store the database, log files, and SYSVOL folder for Active Directory Domain Services \(AD DS\) must be placed on a local fixed volume. SYSVOL must be placed on a volume that is formatted with the NTFS file system. For security purposes, the Active Directory database and log files should be placed on a volume that is formatted with NTFS.  
  
     Traditionally, the Active Directory database and log files are placed on disk drives that are physically local to the domain controller computer. As an option, you can place the Active Directory database and log files on a nonlocal storage device if the device appears to be “local” to the GetDriveType function that Dcpromo.exe uses and it does not have advanced rollback, undo, or snapshot features enabled. For more information about the GetDriveType function, see GetDriveType Function \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102448](http://go.microsoft.com/fwlink/?LinkId=102448)\).  
  
     You must perform all backups and restores of AD DS, including rolling the contents of AD DS “back in time,” by using system state backups that are created by supported backup application programming interfaces \(APIs\) and methods.  
  
  
---
title: AD DS and DNS Server Migration: Preparing to Migrate
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d8f8a10d-e08c-4738-977d-7d48d0df48c7
author: Femila
---
# AD DS and DNS Server Migration: Preparing to Migrate
  Migration of Active Directory Domain Services \(AD DS\) Server and Domain Name System \(DNS\) Server includes the following tasks:  
  
-   [Plan migration](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md#BKMK_GenPrep)  
  
-   [Prepare your source server](#BKMK_PrepSource)  
  
-   [Prepare your destination server](#BKMK_PrepDest)  
  
 Complete the steps or procedures in these sections to plan for and prepare your environment for migration.  
  
## Download and install migration tools  
 Use the following tools to assist migration or to verify that AD DS Server and DNS Server are working after the migration:  
  
-   DNS snap\-in \(on the **Administrative Tools** menu\)  
  
-   Active Directory Users and Computers snap\-in \(on the **Administrative Tools** menu\)  
  
-   Domain Controller Diagnostics Tool \(Dcdiag.exe\). Dcdiag is installed as part of the operating system in Windows Server 2003 and later. You can download a version of the tool for Windows Server 2000 from [DCDiag.exe Utility Update](http://go.microsoft.com/fwlink/?LinkId=134759) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134759\). Be sure to use a version of the tool that is compatible with your operating system. For instructions for using Dcdiag, see [Domain Controller Diagnostics Tool \(dcdiag.exe\)](http://go.microsoft.com/fwlink/?LinkId=130631) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=130631\).  
  
-   Dnslint. To download Dnslint, see [article 321045](http://go.microsoft.com/fwlink/?LinkId=99857) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=99857\).  
  
-   Convergence Verification Script \(DNSconvergeCheck.cmd\). This script is available as part of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Migration Utilities that you can download from the [Microsoft Connect](http://go.microsoft.com/fwlink/?LinkId=135502) Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135502\).  
  
##  <a name="BKMK_GenPrep"></a> Plan migration  
 Complete the following steps or procedures to prepare for or plan a migration of AD DS Server and DNS Server from the source server to the destination server:  
  
-   Before you attempt the procedures in this guide, it is recommended that you introduce [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to your enterprise by installing a new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller elsewhere in your domain. This helps ensure that Adprep.exe commands have successfully prepared your forest and domain for domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. This domain controller does not have to be or become the destination server. For more information, see [Performing the Upgrade of Active Directory Domains to Windows Server 2008 AD DS Domains](http://go.microsoft.com/fwlink/?LinkId=134766) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134766\).  
  
-   Identify your source server and destination server.  
  
-   Ensure that the destination server has adequate capacity to be a domain controller. For more information, see [Assess Hardware Requirements](http://go.microsoft.com/fwlink/?LinkId=134767) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134767\).  
  
-   Before migration, install all critical updates and service packs on the source server that were released before [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. It is a recommended best practice that all current critical updates and service packs be installed on both the source and the destination servers.  
  
-   Ensure that the source DNS server is functioning properly by using the Dcdiag.exe and Dnslint.exe tools:  
  
    -   Verify that the core DNS configuration requirements exist on the source server by running the following **dcdiag** command:  
  
        ```  
        dcdiag /test:dns /s:<source server>  
        ```  
  
         The output of **dcdiag** is written to the console. Key success indicators are in the final few lines on the screen. They should show that for the test DNS, the source server either passed or was not applicable \(N\/A\) for the following categories: Auth, Basc, Forw, Del, Dyn, RReg, Ext.  
  
        > [!NOTE]  
        >  Throughout this guide, commands are formatted so that you can click **Copy Code** and copy the command string to your computer’s clipboard for convenient pasting into Windows PowerShell™ or another command\-line tool.  
  
    -   Ensure that the DNS resource records that are required for successful Active Directory replication are properly registered by running one of the following **dnslint** commands:  
  
        -   If your source server is running the Server Core installation option of the Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems, run the following command:  
  
            ```  
            dnslint /ad /s <source server IP address> /v /no_open  
            ```  
  
        -   If your source server is running the full installation option of the Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems—that is, Internet Explorer is available to display the **dnslint** report—run the following command:  
  
            ```  
            dnslint /ad /s <source server IP address> /v  
            ```  
  
         The **dnslint** command generates and displays an HTML file that contains the results of its tests. You can find two indicators of success toward the bottom of the page, as follows:  
  
        -   The total number of alias \(CNAME\) resource records on this server. This should be a nonzero value that correlates to the number of domain controllers in the entire forest.  
  
        -   The total number of alias \(CNAME\) resource records that are missing on this server. This number should be zero. It is indicative of either dynamic update failures or lack of replication convergence due to either an error or anticipated latency.  
  
         If DNSlint reports problems with your DNS configuration, use the information in the following article to troubleshoot DNS registration problems: [Troubleshooting Active Directory replication failures](http://go.microsoft.com/fwlink/?LinkId=151465) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=151465\).  
  
-   Count the number of network adapters in the source server and the destination server. You must ensure that both the source server and the destination server have the same number of network adapters. If the source server has multiple network adapters and the service is bound and serving IP addresses on different subnets, the destination server that has the AD DS Server and DNS Server roles must also have multiple network adapters, so that the destination server  can serve the same subnets as the source server.  
  
    > [!NOTE]  
    >  This step does not apply to migration of either AD DS Server or DNS Server to virtual machines \(VMs\).  
  
-   Decide how you will populate the Active Directory database on the destination server. This operation takes place when AD DS is installed on the destination server and that server becomes a domain controller. You can populate the database by replicating the contents of the directory from another domain controller over the network or by providing a copy of the directory on portable media with the install from media \(IFM\) option. For large directories, IFM can provide significant time savings. For more information about creating IFM installation media, see [Create Installation Media by Using Ntdsutil](http://go.microsoft.com/fwlink/?LinkId=134769) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134769\).  
  
    > [!NOTE]  
    >  Installation media for a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller can be created only from another [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller within the same domain. Installation media that is created on older versions of Windows Server cannot be consumed by [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Therefore, your first [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller will have to replicate over the network, rather than from IFM media.  
  
-   Obtain the [Convergence Verification Script](http://go.microsoft.com/fwlink/?LinkId=135502) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135502\). During migration you can use the Convergence Verification Script to verify that DNS records have been synchronized.  
  
-   Prepare a migration store file location. The store location must be accessible from the source server during the export and from the destination server during the import. Use a common drive that can contain all the information for AD DS Server and DNS Server from the source server. The storage location should be similar to the following: \\\\fileserver\\users\\username\\.  
  
### Back up your source server  
 Make a final backup of the source server. The backup should be an Active Directory or DNS backup, not a Windows backup, which backs up the entire system. For more information about how to back up [!INCLUDE[nextref_adds](../Token/nextref_adds_md.md)] in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see the [AD DS Backup and Recovery Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkID=177430) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=177430\). For more information about how to back up [!INCLUDE[nextref_adds](../Token/nextref_adds_md.md)] in Windows Server 2003, see [Introduction to Administering Active Directory Backup and Restore](http://go.microsoft.com/fwlink/?LinkId=184550) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=184550\).  
  
###  <a name="BKMK_PrepSource"></a> Prepare your source server  
 The information that you need to migrate the source server is organized in [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md). Use the worksheet to identify the migration data to use during migration. You should complete these steps and update the worksheet with all the necessary data before you begin the migration process. Some data or settings are collected and used during the migration. Some data or settings are collected and documented for later use in verification. Use the worksheet in AD DS and DNS Server Migration: [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md) for verifying the success of your migration. If you determine that your particular migration does not require the collection of certain data or settings, you can delete them from your final worksheet or mark them “Not Applicable \(N\/A\).”  
  
 After you collect the worksheet information, you are ready to begin preparing the destination server for the migration, as described in the next section.  
  
###  <a name="BKMK_PrepDest"></a> Prepare your destination server  
 Prepare for migration by installing the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system on the destination server. Choose the installation options for AD DS on the destination server, as indicated in the following section, to prepare the destination server for migration.  
  
 If the destination server is the first x64\-based [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server in your domain, complete the procedures for installing the first domain controller in a domain, as described in [Performing the Upgrade of Active Directory Domains](http://go.microsoft.com/fwlink/?LinkID=134766) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=134766\).  
  
 If you applied Extended Protection for Authentication to computers that run Windows Server 2003 or Windows XP, applications on those computers that use Digest authentication will fail when they authenticate to a domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Affected applications include applications that use Windows Communication Foundation \(WCF\), ASP.NET, or Internet Information Services \(IIS\) with static pages.  
  
 Extended Protection for Authentication is available from Windows Update. For more information, see [article 968389](http://go.microsoft.com/fwlink/?LinkId=186398) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186398\) in the Microsoft Knowledge Base.  
  
 This problem occurs because of a macro that identifies the size of a hash for a nonce. The value of the macro for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] differs from the value of the macro for Windows Server 2003 and for Windows XP. This difference causes Digest authentication to fail.  
  
 To resolve this problem, apply the hotfix from [article 977073](http://go.microsoft.com/fwlink/?LinkId=186394) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186394\) in the Microsoft Knowledge Base to all client computers running Windows Server 2003 or Windows XP that might authenticate with a domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
##### To prepare the destination server for migration  
  
1.  Install and configure the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system.  
  
2.  Assign the server a temporary name. This name will be replaced late in the migration process.  
  
3.  Assign the server a temporary IP address. This address will be replaced late in the migration process.  
  
4.  Join the destination server as a member server to the same domain as the source server. For instructions for joining a domain from a Server Core installation of the operating system, see the [Server Core Installation Option of Windows Server 2008 Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=149254) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=149254\).  
  
    > [!IMPORTANT]  
    >  Do not run Dcpromo at this time because the destination server must be a member server at this point in the migration process.  
  
### Additional migration strategy decisions  
 After you collect all the worksheet data, there may be additional decisions to make regarding possible modification of your network topology. These decisions can involve your total migration strategy:  
  
-   Determine whether you will remove the source server or retain it as a member server.  
  
-   If the source server has operations master roles \(also known as flexible single master operations or FSMO roles\), determine which operations master roles will be given to other computers and which roles will go to the destination server.  
  
-   If the source server has other server roles, determine which server roles will go to other computers and which server roles will go to the destination server, along with the order of their migration.  
  
-   For read\-only domain controllers \(RODCs\) and global catalog domain controllers, determine whether your destination server will also be an RODC or a global catalog server.  
  
## See Also  
 [Active Directory Domain Services and DNS Server Migration Guide](../Topic/Active-Directory-Domain-Services-and-DNS-Server-Migration-Guide.md)   
 [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md)  
  
  
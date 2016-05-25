---
title: AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7a1dde57-fc11-42cf-92ff-26c6f80bacfd
author: Femila
---
# AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles
  This topic contains steps and procedures for migrating the Active Directory Domain Services \(AD DS\) Server and Domain Name System \(DNS\) Server roles from a legacy source server to a new x64\-based [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] destination server.  
  
## Migrating AD DS Server and DNS Server  
 This topic does not contain steps for every possible migration scenario. However, these steps should apply to most organizations that require migration of AD DS Server and DNS Server to a new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server. Complete the steps to begin the migration of the server roles from the source server to destination server. At this point in the migration process, the source server is a domain controller and the destination server is a member server.  
  
### Overview of migration steps  
 The following steps are an overview of the migration process:  
  
1.  Make the destination member server a domain controller.  
  
2.  Record the DNS settings on the source server. Use the migration data collection worksheet in [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md).  
  
3.  Import source server DNS settings to the destination server.  
  
4.  Verify that settings replication is occurring between the source server and the destination server by running the Convergence Verification Script.  
  
5.  As an option, you can manually migrate the operations master \(also known as flexible single master operations or FSMO\) roles or the Intersite Topology Generator \(ISTG\) role from the source server to the destination server.  
  
6.  Migrate source IP addresses from the source server to the destination server.  
  
7.  Migrate the source server name to the destination server.  
  
8.  Verify the DNS setting migration using the verification worksheet in [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md).  
  
### Migrate AD DS Server and DNS Server  
 At this point in the migration process, a source server and a destination server are running in parallel, with different IP addresses and different server names. Complete the following procedure to migrate AD DS Server and DNS Server.  
  
##### To migrate AD DS Server and DNS Server  
  
1.  Use the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\) to make the destination server a domain controller. Much of the information that you collect in the migration data collection worksheet in [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md) is used by Dcpromo.exe. Run Dcpromo: click **Start**, click **Run**, type **dcpromo.exe**, and then click **OK**. Do not run Dcpromo on a Server Core installation of Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
    > [!IMPORTANT]  
    >  This step is different if your destination server is running the Server Core installation option. Because the Server Core installation option does not provide a wizard for Dcpromo.exe, ignore steps 1a to 1o. Use the command line, or create an answer file to provide Dcpromo with the necessary inputs.  
    >   
    >  For command\-line Help, at the command line on a Server Core installation, type the following command, and then press ENTER: `dcpromo /?:promotion`  
    >   
    >  To create an answer file, see [Installing an Additional Windows Server 2008 Domain Controller by Using an Answer File](http://go.microsoft.com/fwlink/?LinkID=128101) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128101\). This topic contains a detailed description of this method for promoting a domain controller on a Server Core installation.  
  
    > [!NOTE]  
    >  Based on your particular installation, the Dcpromo wizard may provide some steps that are different from the following steps. If a Dcpromo wizard step for your installation is different from one of the following steps, accepting the defaults is often the best approach if you are uncertain about how to respond to an undocumented wizard step.  
  
    ###### To make the destination server a domain controller  
  
    1.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, select the **Use advanced mode installation** check box, and then click **Next**.  
  
    2.  On the **Operating System Compatibility** page, review the warning about the default security settings for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers, and then click **Next**.  
  
    3.  On the **Choose a Deployment Configuration** page, click **Existing forest**, click **Add a domain controller to an existing domain**, and then click **Next**.  
  
    4.  On the **Network Credentials** page, type the name of the source server’s domain. Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**.  
  
    5.  In the **Windows Security** dialog box, type the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Administrators group or the Domain Administrators group. When you are finished providing credentials, click **Next**.  
  
    6.  On the **Select a Domain** page, select the domain of the new domain controller. This domain should be the same as the domain of the source server. Click **Next**.  
  
    7.  In the list on the **Select a Site** page, select a site that you designated in step 05 of the migration worksheet, and then click **Next**.  
  
    8.  On the **Additional Domain Controller Options** page, select the following options, as appropriate, and then click **Next**:  
  
        -   **DNS server**: This option is selected by default so that your domain controller can function as a DNS server. Review the information that you gathered in step 08 of the migration worksheet to determine if your source server also had DNS Server installed. If your source server had DNS Server installed, you must migrate that role to this server. Therefore, you should select this check box. If your source server did not have DNS Server installed, clear this check box.  
  
        -   **Global catalog**: This option is selected by default. It adds the global catalog, read\-only directory partitions to the domain controller, and it enables global catalog search functionality. Review the information that you gathered in step 04 of the migration worksheet to determine if your source server also functioned as a global catalog server. If your source server was a global catalog or if you want to add the global catalog functionality to this server, select the check box for this option; otherwise, clear this check box.  
  
        -   **Read\-only domain controller**: This option is not selected by default. It makes the additional domain controller a read\-only domain controller \(RODC\). Review the information that you gathered in step 04 of the migration worksheet to determine if your source server was an RODC. If your source server was an RODC, select this option. An RODC cannot function as a replacement for a writable domain controller. Make sure that you understand the limitations of RODCs before you decide to make the destination server an RODC. For more information, see [AD DS: Read\-Only Domain Controllers](http://go.microsoft.com/fwlink/?LinkID=130495) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=130495\).  
  
        > [!NOTE]  
        >  If the destination server is being promoted into a child domain and the DNS role is selected in the Dcpromo wizard, depending on your DNS infrastructure an additional prompt may appear that says "Update DNS Delegation." It is not necessary to update the delegation in the parent domain if, as part of the post\-migration process, the source server will eventually be decommissioned and the destination server will adopt the source server's name and IP address. If these conditions are not true either in full or in part, updating the delegation may make it necessary to manually verify its configuration in the parent DNS domain after the migration is complete to ensure that it references only servers that remain in production.  
  
    9. If you selected **Use advanced mode installation** on the **Welcome** page, the **Install from Media** page appears. If you created installation media as described in [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md), provide the location of that installation media so that it can be used to create the domain controller and configure AD DS.  
  
        > [!NOTE]  
        >  Some data will be replicated over the network even if you use the install from media \(IFM\) option. For information about using IFM to install the domain controller, see [Installing AD DS from Media](http://technet.microsoft.com/library/cc770654.aspx) \(http:\/\/technet.microsoft.com\/library\/cc770654.aspx\).  
  
    10. If you selected **Use advanced mode installation** on the **Welcome** page, the **Source Domain Controller** page appears. If your source server is not a read\-only domain controller \(RODC\) and you did not create installation media, as described in [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md), click **Use this specific domain controller** and specify the source server as the source for replication to create the new domain controller, and then click **Next**.  
  
    11. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the SYSVOL files on the destination server, and then click **Next**. The location of these files does not have to correspond to their location on the source server.  
  
    12. On the **Directory Services Restore Mode Administrator Password** page, type and confirm a Directory Services Restore Mode \(DSRM\) password, and then click **Next**. This password must be used to start AD DS in DSRM for tasks that must be performed offline.  
  
    13. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
    14. To save the settings that you selected to an answer file that you can use to automate subsequent Active Directory operations, click **Export settings**. Type a name for your answer file, and then click **Save**. When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
    15. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
     At this point, the destination server is a functioning domain controller. But operations master roles may still exist on the source server.  
  
2.  Use the following steps to determine the DNS settings on the source server, based on the information in your worksheet. You may want to save the information in a network\-accessible location. For more information, see “Prepare a migration store file location” in the “Plan migration” section in [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md).  
  
    1.  Enumerate the directory partitions on the source server by running the following command:  
  
        ```  
        dnscmd /EnumDirectoryPartitions  
        ```  
  
    2.  On the destination server, run the following command to enlist only those custom directory partitions that are enlisted on the source domain controller. The output of `dnscmd /EnumDirectoryPartitions` indicates whether a given partition is enlisted on the source domain controller. Do not enlist partitions that are identified as “Not\-Enlisted” on the source domain controller:  
  
        ```  
        dnscmd /EnlistDirectoryPartition <FQDN of partition>  
        ```  
  
        > [!IMPORTANT]  
        >  Because all partitions are not guaranteed to be in the same site, this process may take a long time. Verify that the zones have been created on the destination server by reviewing the information in the DNS Manager snap\-in.  
  
        > [!NOTE]  
        >  You can obtain the fully qualified domain name \(FQDN\) of the partition from the output of the `dnscmd /EnumDirectoryPartitions` command in the previous step. In some cases the DNS partition will already be enlisted. You can safely ignore the error message “DNS\_ERROR\_DP\_ALREADY\_ENLISTED 9904 0x26B0.”  
  
    3.  Stop the DNS Server service on the source server by running the following command:  
  
        ```  
        net stop "DNS Server"  
        ```  
  
    4.  Run the **reg** command on the source server to export the following registry keys:  
  
        -   To export **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\DNS\\Parameters**, type the following command, and then press ENTER:  
  
            ```  
            reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DNS\Parameters %Windir%\System32\DNS\Dns-Service.REG  
            ```  
  
        -   To export **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\DNS Server**, type the following command, and then press ENTER:  
  
            ```  
            reg export cHKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server" %Windir%\System32\DNS\Dns-Software.REG  
            ```  
  
    5.  On the source server, copy all files and subfolders under %windir%\\System32\\DNS to a network location or a universal serial bus \(USB\) key under the DNS\_migrate\_system32DNS folder. The following is a sample copy command:  
  
        ```  
        xcopy %windir%\system32\dns <DNS_migrate_system32DNS> /s  
        ```  
  
        > [!NOTE]  
        >  The samples folder should not be copied because its content is not required. If you attempt to copy it, you can safely ignore the error messages that appear.  
  
    6.  If necessary, copy all files on the source server under each custom database directory by manually reading from the registry at the following path:  
  
         **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\DNS\\Parameters\\DatabaseDirectory**  
  
    7.  Start the DNS Server service on the source server by running the following command:  
  
        ```  
        net start "DNS Server"  
        ```  
  
         At this point, because the source server and destination server have different IP addresses, the source server can still continue to service client computers and other DNS servers.  
  
3.  On the destination server, import the DNS settings from the source server:  
  
    1.  Stop the DNS Server service on the destination server by running the following command:  
  
        ```  
        net stop "DNS Server"  
        ```  
  
    2.  Copy the Dns\-Service.REG and Dns\-Software.REG files to the destination server, and then run them both.  
  
    3.  Copy all the files under DNS\_migrate\_system32DNS to %windir%\\System32\\DNS.  
  
    4.  Start the DNS Server service by running the following command:  
  
        ```  
        net start "DNS Server"  
        ```  
  
     At this point, you have one additional domain controller and DNS Server operating on the network.  
  
4.  Before you proceed, ensure that the destination server has an up\-to\-date replica of the source server’s DNS records. This information is synchronized through the normal Active Directory replication process, but it may take some time for replication to complete. Run the Convergence Verification Script \(DNSconvergeCheck.cmd\) to confirm that the source server and destination server have converged before you proceed with the migration process.  
  
    > [!NOTE]  
    >  If the source server is a read\-only domain controller \(RODC\), it is not necessary to run the Convergence Verification Script and you can skip this step.  
  
     Download the Migration Utilities package, which contains the [Convergence Verification Script](http://go.microsoft.com/fwlink/?LinkId=135502) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135502\), to a folder on any server in the domain. Run the script to confirm that the source and destination servers have converged. The script requires the name or address of the source server and destination server and the name of the domain being verified:  
  
     **DNSConvergeCheck.cmd \<source DNS server\> \<destination DNS server\> \<FQDN of domain\>**  
  
     The Convergence Verification Script creates a resource record on the source server and alerts the user when the resource record has replicated to the destination server. After it runs, the script writes to the console that the test has been a success and that the resource record has been replicated.  
  
5.  Review your plans regarding the migration of operations master \(also known as flexible single master operations or FSMO\) roles. If the source server holds any of the operations master roles, these roles are transferred automatically to suitable domain controllers in the same domain when the source server is demoted during the post\-migration process. However, these roles cannot be transferred to a specific domain controller during demotion. If it is important that the operations master roles be transferred to the destination server, you must migrate the roles manually by using Ntdsutil.exe. For more information, see [article 255504](http://go.microsoft.com/fwlink/?LinkID=70776) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=70776\).  
  
6.  Migrate the IP address of the source server to the destination server:  
  
    -   Change the source server to a different static IP address.  
  
    -   Change the destination server IP address to the original IP address of the source server.  
  
     You can perform this migration manually. For an alternative, see [IP Configuration Migration](http://go.microsoft.com/fwlink/?LinkID=128513) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128513\).  
  
    > [!CAUTION]  
    >  If your source server is running multiple server roles, renaming the source server or changing its IP address can cause other roles that are running on the source server to fail.  
  
7.  At this point in the migration process, rename the source server and migrate its previous identity to the destination server by following the next steps:  
  
    1.  Give the source server a different name. Restart the source server to complete the name change.  
  
    2.  Give the destination server the original name of the source server. Restart the destination server to complete the name change. The following is a sample command for renaming the servers:  
  
        ```  
        netdom renamecomputer %computername% /NewName:<new computer name>  
        ```  
  
    > [!NOTE]  
    >  If the destination server is not a Server Core installation, you can also use the SYSDM.CPL control panel’s system applet to rename the destination server.  
  
8.  Perform verification steps on the destination server to ensure that it is functioning as a new domain controller with AD DS Server and DNS Server installed. Use the Verification Worksheet in [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md).  
  
 Migration is now complete. At this point, the destination server is now running as a domain controller hosting AD DS Server and DNS Server. The destination server should be providing all the services to the network that were previously provided by the source server.  
  
 At some future time, when you are comfortable that you will not have to roll back to the previous source server configuration, you may want to demote the source server and make it a member server. If so, see [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md). As an alternative, you may choose to leave the source server operating as an auxiliary domain controller.  
  
## See Also  
 [Active Directory Domain Services and DNS Server Migration Guide](../Topic/Active-Directory-Domain-Services-and-DNS-Server-Migration-Guide.md)   
 [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md)  
  
  
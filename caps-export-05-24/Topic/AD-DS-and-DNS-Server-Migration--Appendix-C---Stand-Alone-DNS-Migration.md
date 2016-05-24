---
title: AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e7d14205-660f-41b1-b151-6a52fab4368c
author: Femila
---
# AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration
    
## Stand\-alone DNS migration  
 This appendix provides guidance for the stand\-alone migration of the Domain Name System \(DNS\) Server role from an x86\-based or x64\-based server running Windows Server 2003, Windows Server 2008, or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server.  
  
 Stand\-alone DNS Server migration consists of the following basic steps:  
  
1.  Consider all the migration prerequisites in this guide for the combined migration of both Active Directory Domain Services \(AD DS\) and Domain Name System \(DNS\). Most of these prerequisites also apply to a migration of DNS only.  
  
2.  Use the migration data collection worksheet to collect migration data, as provided in the [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md). Skip any data collection step that is specific to AD DS.  
  
3.  Skip any preparation step that is obviously specific to AD DS.  
  
4.  Follow the stand\-alone DNS migration steps in the next procedure.  
  
5.  Use the verification worksheet in the [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md). Skip any step that is specific to AD DS.  
  
#### To migrate DNS Server  
  
1.  When you migrate stand\-alone DNS servers, it is important to migrate primary and secondary servers in the following order:  
  
    1.  Identify the server that hosts the primary copy of the zone \(referred to as the “primary server”\) and all servers that host secondary copies of the zone \(referred to as “secondary servers”\).  
  
    2.  Migrate all secondary servers.  
  
    3.  Migrate the primary server.  
  
2.  Starting with secondary servers and then moving to the primary server, capture the DNS settings on the source server, based on the information in your worksheet:  
  
    1.  Prepare a neutral, network\-accessible, file storage location to assist the migration. This location must be accessible both from the source server, as a space in which to temporarily hold exported source server files, and from the destination server, as a space from which to retrieve and import those files. Select an accessible location that has enough capacity to contain all the AD DS and DNS server–related information that you export from the source server. For example, the storage location can be similar to the following: \\\\fileserver\\users\\username\\. This location can be a folder on the destination server itself, or it can be situated on another computer on your network.  
  
    2.  Stop the DNS Server service on the source server by running the following command:  
  
        ```  
        net stop "DNS Server"  
        ```  
  
    3.  Run the **reg** command to export the following registry keys:  
  
        -   **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\DNS\\Parameters**  
  
            ```  
  
            reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DNS\Parameters %Windir%\System32\DNS\Dns-Service.REG  
  
            ```  
  
        -   **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\DNS Server**  
  
            ```  
            reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server" %Windir%\System32\DNS\Dns-Software.REG  
  
            ```  
  
    4.  On the source server, copy all the files and subfolders under %windir%\\System32\\DNS \(except the Samples folder\) to a network location or a Universal Serial Bus \(USB\) key under the DNS\_migrate\_system32DNS folder. The following is a sample copy command:  
  
        ```  
        xcopy %windir%\system32\dns\ <DNS_migrate_system32DNS> /s  
        ```  
  
        > [!NOTE]  
        >  The Samples folder should not be copied because its content is not required. If you attempt to copy it anyway, you can safely ignore the errors that result.  
  
    5.  If necessary, copy all files under each custom database directory by reading from the registry at the following path:  
  
        ```  
        HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters\DatabaseDirectory  
        ```  
  
    6.  Start the DNS Server service by using the following command:  
  
        ```  
        net start "DNS Server"  
        ```  
  
     Because at this time the source server and destination server have different IP addresses, the source server can still continue to service clients and other DNS servers.  
  
3.  At this point, on the destination server, import the DNS settings from the source DNS Server:  
  
    1.  Stop the DNS Server service on the destination server by using the following command:  
  
        ```  
        net stop "DNS Server"  
        ```  
  
    2.  Copy the Dns\-Service.REG and Dns\-Software.REG files to the destination server, and run them both.  
  
    3.  Copy all the files under DNS\_migrate\_system32DNS to %windir%\\System32\\DNS.  
  
    4.  Start the DNS Server service by using the following command:  
  
        ```  
        net start "DNS Server"  
        ```  
  
4.  Perform this step only if the server being migrated is a secondary server. On the primary server, identify the zone transfer settings:  
  
    1.  If the primary server is configured to “Allow zone transfers to any server”, proceed to step 5.  
  
    2.  If the primary server is configured to “Allow zone transfers only to servers” listed on the **Name Server** tab:  
  
         Create a new name server \(NS\) resource record for the destination server by using the following command:  
  
        1.  ```  
            dnscmd /recordadd <FQDN of the zone> @ NS <FQDN of the destination server>  
            ```  
  
        2.  ```  
            dnscmd /recordadd <FQDN of the zone> <FQDN of the server>. A <Temp IP address of destination server>  
            ```  
  
    3.  If the primary server is configured to “Allow zone transfer only to the following servers”:  
  
        1.  Add the IP address of the destination secondary server to the list.  
  
        2.  On the destination server, open a command prompt and, to initiate a zone transfer from the primary server to the destination secondary server, type the following command:  
  
            ```  
            dnscmd /zonerefresh <zone name>  
            ```  
  
        3.  Verify that the zone transfer completes successfully by examining the resource records in the zone on the destination server and verifying that the records match the records that are present on the primary server.  
  
5.  At this point in the migration process, migrate the IP address of the source server to the destination server:  
  
    -   Change the source server to a different static IP address.  
  
    -   Change the destination server IP address to the original IP address that was used for the source server.  
  
     You can perform the migration manually, or you can follow the steps in [IP Configuration Migration](http://go.microsoft.com/fwlink/?LinkId=128513) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128513\) to perform the IP address migration.  
  
    > [!CAUTION]  
    >  If your source server is running multiple roles, renaming the source server or changing its IP address can cause other roles that are running on the source server to fail.  
  
6.  At this point in the migration process, the source server must be renamed and its previous identity must be migrated to the destination server. Complete the following steps to migrate the source server name:  
  
    1.  Rename the source server to a different name by using the following command:  
  
        ```  
        netdom renamecomputer %computername% /NewName:<new computer name>  
        ```  
  
    2.  Restart the source server to complete the name change.  
  
    3.  Rename the destination server to the original source server name by running the command in step a on the destination server.  
  
    4.  Restart the destination server to complete the name change.  
  
7.  Perform this step only if you are migrating a secondary server. On the primary server, revisit the zone transfer settings.  
  
    1.  If the primary server is configured to “Allow zone transfers to any server”, proceed to step 8.  
  
    2.  If the primary server is configured to “Allow zone transfers only to servers” listed on the **Name Server** tab:  
  
         Delete the name server \(NS\) resource record and the host \(A\) resource record that was created in step 4\(b\) by running the following command:  
  
        1.  ```  
            dnscmd /recorddelete <FQDN of the zone> @ NS <FQDN of the destination server>  
            ```  
  
        2.  ```  
            dnscmd /recorddelete <FQDN of the zone> <FQDN of the server>. A <Temp IP address of destination server>  
            ```  
  
            > [!NOTE]  
            >  The parameters in these commands are the same as the parameters that you entered in step 4\(b\).  
  
    3.  If the primary server is configured to “Allow zone transfer only to the following servers”:  
  
        1.  Delete the IP address of the destination secondary server in the list.  
  
            > [!NOTE]  
            >  This was the IP address that was added in step 4.c.i, which originally belonged to the destination server but now belongs to the source server after IP migration.  
  
        2.  On the destination server, open a command prompt, and to initiate a zone transfer from the primary to the destination secondary, type the following command, and then press ENTER:  
  
            ```  
            dnscmd /zonerefresh <zone name>  
            ```  
  
        3.  Verify that the zone transfer completes successfully by examining the resource records in the zone on the destination server and verifying that these resource records match the resource records on the primary server.  
  
8.  At this point in the migration process, perform verification steps on the destination server to ensure that it is functioning as the new DNS Server. Verify setting migration by using the Verification Worksheet in [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md).  
  
 Migration is now complete. The destination server should now be providing all the services to the network that were previously provided by the source server. At this point, the destination server is now running as a DNS server.  
  
## See Also  
 [Active Directory Domain Services and DNS Server Migration Guide](../Topic/Active-Directory-Domain-Services-and-DNS-Server-Migration-Guide.md)   
 [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md)   
 [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md)  
  
  
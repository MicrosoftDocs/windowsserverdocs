---
title: DHCP Server Migration: Verifying the Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d29e34db-965b-49a4-80a3-fc1dfef8a0d9
---
# DHCP Server Migration: Verifying the Migration
When all the migration steps are complete, you can use the following procedure to verify that the DHCP server role migration was successful. If the migration failed, you can return to the previous valid configuration by following the steps in [DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md).  
  
## <a name="BKMK_Verifydestinationserverconfiguration"></a>Verifying destination server configuration  
Follow these steps to confirm that the DHCP destination server is now serving the domain.  
  
Membership in **Domain Administrators**, or equivalent, is the minimum required to complete this procedure. Review details about how to use the appropriate accounts and group memberships at [Understanding Groups: Default groups](http://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).  
  
#### To verify the configuration of the destination server  
  
1.  Make sure that the destination server is authorized by running the following command in a Windows PowerShell window:  
  
    ```  
    netsh DHCP show server  
    ```  
  
    The output of this command must contain the name of the DHCP destination server.  
  
2.  Check whether DHCP server is running on the destination server. In Task Manager, on the **Services** tab, the DHCP server status should be **Started**. You also use Task Manager to confirm that the status of the source server is **Stopped**.  
  
3.  Verify that the client computers are correctly receiving IP addresses on request by running the following commands at a command prompt on a client computer:  
  
    ```  
    ipconfig /release  
    ```  
  
    ```  
    ipconfig /renew  
    ```  
  
    If the IP address of the DHCP server has not changed, you do not have to run the **ipconfig \/release** command. Running **ipconfig \/renew** should be sufficient.  
  
    The output of these commands should show that the client computer was issued an IP address.  
  
4.  Use the DHCP console to verify that the scopes and other settings were migrated. To connect to the destination server, click **Action**, click **Add Server**, and then type the IP address or host name of the DHCP server. In the console tree, expand the server node, and then expand the IPv4 and IPv6 nodes to confirm that the scopes have been migrated. Then locate the folders for the scopes and view the address range, reservations, scope options, and active leases to verify the same. You can also go to the Server Options folder and verify the migrated server options.  
  
## See also  
[Migrate DHCP Server to Windows Server 2012 R2](../Topic/Migrate-DHCP-Server-to-Windows-Server-2012-R2.md)  
  
[DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
[DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
[DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
[DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md)  
  

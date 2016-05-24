---
title: AD DS and DNS Server Migration: Post-Migration Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e87f8062-538d-4386-9326-d6bc1cb3abff
author: Femila
---
# AD DS and DNS Server Migration: Post-Migration Tasks
    
## Completing migration  
 After all migration steps are complete and you have verified the migration of Active Directory Domain Services \(AD DS\) Server and Domain Name System \(DNS\) Server, the next tasks are optional post\-migration tasks.  
  
### Retiring AD DS Server and DNS Server on your source server  
 AD DS Server and DNS Server are automatically retired on the source server when you use the Dcpromo tool to remove AD DS and demote the source server to member server status. At this point in the migration process, you can prepare to demote the source server.  
  
> [!CAUTION]  
>  Do not demote and retire your source server until you are sure that your corporate policy regarding server demotion and retirement is met. When the source server is demoted to be a member server, repurposed, or retired from service, you cannot roll back to your previous working state.  
  
 For instructions for decommissioning a domain controller, see [Decommissioning a Domain Controller](http://go.microsoft.com/fwlink/?LinkID=128290) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128290\).  
  
## Restoring the role in the event of migration failure  
 If your migration of AD DS Server fails, as long as the source server has not been demoted you can swap the IP address and server names to roll back to the previously working configuration.  
  
### Roll back a migration  
 To roll back a failed migration:  
  
1.  Rename the destination server with a different, unique name, and then restart the server.  
  
2.  Switch the IP addresses back by using the instructions in the IP Configuration Migration document to migrate the destination server IP address back to the source server and place the source server’s IP address on the destination server. For more information, see the [IP Configuration Migration Guide](http://go.microsoft.com/fwlink/?LinkID=128513) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128513\).  
  
3.  Rename the source server with its original server name.  
  
4.  Assess the severity of the migration error. If the migration error is severe, make the destination server a member server.  
  
 At this point, the original source server configuration is restored and the source server is providing domain controller services by running AD DS Server and DNS Server.  
  
### Estimated time to complete rollback  
 If the source server has not been demoted to be a member server, repurposed, or retired from service, you should be able to complete a rollback in approximately two hours.  
  
## Troubleshooting migration  
 If any particular verification procedure fails, you will have to troubleshoot the difficulty and assess the impact of the error on the operation of the destination server. If the impact is significant and you cannot fix the issue, follow the instructions in [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md) to roll back to your original configuration.  
  
## Additional references  
 For more information about the migration process, see the following resources:  
  
-   [Migrate to Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=128554) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128554\)  
  
-   [Using Netsh](http://go.microsoft.com/fwlink/?LinkId=128745) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128745\)  
  
-   [IP Configuration Migration](http://go.microsoft.com/fwlink/?LinkId=128513) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128513\)  
  
-   [DHCP Migration](http://go.microsoft.com/fwlink?LinkID=134770) \(http:\/\/go.microsoft.com\/fwlink?LinkID\=134770\)  
  
-   [File Migration](http://go.microsoft.com/fwlink/?LinkId=128746) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128746\)  
  
-   [Printer Migration](http://go.microsoft.com/fwlink/?LinkId=128749) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=128749\)  
  
## See Also  
 [Active Directory Domain Services and DNS Server Migration Guide](../Topic/Active-Directory-Domain-Services-and-DNS-Server-Migration-Guide.md)   
 [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md)   
 [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md)  
  
  
---
title: Post-Migration Tasks
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4110a843-14f7-4e42-9a74-b38eb2f6dfcb
---
# Post-Migration Tasks
After all migration steps are complete and you have verified the migration of the Network Policy Server \(NPS\) role service, perform the following post\-migration tasks.  
  
## Post migration tasks  
After verifying NPS configuration is working on the destination server, the following steps need to be performed:  
  
#### To decommission a source server using the same host and IP address  
  
1.  Remove the source server from your Active Directory domain.  
  
2.  Shut down the source server.  
  
3.  Rename the destination server from *tempNPS* to the name of the source server and configure the same static IP address as that used by the source server.  
  
4.  Perform verification steps in [Verifying the NPS Server Migration](../Topic/Verifying-the-NPS-Server-Migration.md) with the updated host name and IP address configured on the destination server.  
  
#### To decommission a source server using a different host and IP address  
  
1.  NPS server name\/ IP address should be updated on Remote RADIUS servers and RADIUS clients. It requires manual update of the configurations on RADIUS clients and Network Access Servers \(NAS\).  Please refer to your RADIUS client configuration guide for more information.  
  
2.  Perform verification steps in [Verifying the NPS Server Migration](../Topic/Verifying-the-NPS-Server-Migration.md).  
  
3.  When the destination server has been configured, tested, and verified, then the NPS role on the source server may be retired.  
  
## Restoring the role in the event of migration failure  
If the destination server is deployed simultaneously with the source server using a different host name and IP address, then the migration can be reversed by changing RADIUS clients, remote RADIUS server groups, and network access device settings to use the source NPS server name and IP address. If the destination server is replacing the source server using the same host name and IP address, then the destination server will need to be renamed, the IP address must be updated, and the destination server must be removed from the domain to reverse the migration and bring the source server back online.  
  

---
title: Remote Desktop Services: Post-Migration Tasks
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 393ba2e9-2f14-4d23-aa8c-46f1bf1eca47
author: lizap
---
# Remote Desktop Services: Post-Migration Tasks
This topic contains information about general post\-migration tasks that you can perform after you migrate Remote Desktop Services role services from a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
The post\-migration tasks include:  
  
1.  [Retire the source servers](../Topic/Remote-Desktop-Services--Post-Migration-Tasks.md#BKMK_Retire)  
  
## <a name="BKMK_Retire"></a>Retire the source servers  
In each case, the source server is retired by removing it from the domain. After you complete and verify the migration, the source server can be shut down or disconnected from the network.  
  
> [!CAUTION]  
> If there is more than one role service on the server, after removing the source server from the domain, you will not have access to the other role services on the computer.  
  
-   [Migrate Remote Desktop Services to Windows Server 2012 R2](../Topic/Migrate-Remote-Desktop-Services-to-Windows-Server-2012-R2.md)  
  
-   [Remote Desktop Services: Prepare to Migrate](../Topic/Remote-Desktop-Services--Prepare-to-Migrate.md)  
  
-   [Remote Desktop Services: Migrate Remote Desktop Services Role Services](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md)  
  
-   [Remote Desktop Services: Verify the Migration](../Topic/Remote-Desktop-Services--Verify-the-Migration.md)  
  
-   **You are here in this migration process document \->**Remote Desktop Services: Post\-migration Tasks  
  
-   [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
-   [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  

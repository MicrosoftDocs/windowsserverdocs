---
title: Step 1: Plan for WSUS Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4622f78-4eab-4672-b3ab-067820c60adf
author: britw
---
# Step 1: Plan for WSUS Migration
The first step in the migration of your Windows Server Update Services \(WSUS\) to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is to understand the supported and unsupported scenarios and the supported operating systems for this migration. The following checklist describes the steps involved in planning for your WSUS migration.  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Know supported operating systems](../Topic/Step-1--Plan-for-WSUS-Migration.md#BKMK_1.1)|Review the list of supported source operating systems and WSUS versions.|  
|[1.2. Review supported migration scenarios](../Topic/Step-1--Plan-for-WSUS-Migration.md#BKMK_1.2)|Review the list of supported migration scenarios.|  
|[1.3. Review migration scenarios that are not supported](../Topic/Step-1--Plan-for-WSUS-Migration.md#BKMK_1.3.)|Review the list of unsupported migration scenarios.|  
  
## <a name="BKMK_1.1"></a>1.1. Know supported operating systems  
Migration from the following operating systems is supported on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]:  
  
-   Windows Server 2008 R2 running WSUS 3.0 SP2  
  
-   Windows Server 2008 \(full installation option\) running WSUS 3.0 SP2  
  
-   Windows Server 2003 SP2 running WSUS 3.0 SP2  
  
## <a name="BKMK_1.2"></a>1.2. Review supported migration scenarios  
The following WSUS migration scenarios are supported:  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Standard and Datacenter editions, and servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] can be used as source or destination servers.  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Enterprise edition can be used as a source server.  
  
-   Migration between physical operating systems and virtual operating systems.  
  
-   Migration from a source server that is running SQL Server 2005 to a destination server that is running SQL Server 2008 R2 SP1.  
  
-   Migration from a source server that is running Windows Internal Database to a destination server that is running SQL Server 2008 R2 SP1.  
  
-   Migration from a domain to a workgroup or from a workgroup to a domain. However, if the source server is running SQL Server from a remote location, migration from the domain to a workgroup is not supported.  
  
-   The destination server must meet the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] WSUS role minimum system requirements for hardware and software.  
  
> [!IMPORTANT]  
> For more information about minimum system requirements and hardware capacity requirements for the WSUS server, see the [Deploying WSUS in the Organization](assetId:///5ad27d64-0749-4b84-a8c1-21ffe5bccd3f).  
  
## <a name="BKMK_1.3."></a>1.3. Review migration scenarios that are not supported  
The following WSUS migration scenarios are not supported:  
  
-   Migration from an unsupported version of WSUS \(prior to WSUS 3.0 SP2\). Upgrade the existing WSUS server to a supported version before you migrate the WSUS server role to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Migration from a Server Core installation option \(WSUS 3.0 SP2 does not support a Server Core installation\).  
  
-   Migration from a domain that is using SQL Server from a remote location to a workgroup.  
  
-   Migration from a source server that is running SQL Server to a destination server that is running Windows Internal Database.  
  
-   Migration from a source server that stores updates on Microsoft Update to a destination server that stores updates on a local WSUS server, and vice versa. Changing the configuration during the migration process is not supported.  
  
-   Migration from a source server to a destination server that is running an operating system in a different system UI language. The system UI language is the language of the localized installation package that was used to set up the Windows operating system. For example, you cannot use Windows Server Migration Tools to migrate roles, operating system settings, data, or shares from a computer that is running Windows Server 2008 in the French system UI language to a computer that is running Windows Server 2008 R2 in the German system UI language.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Prepare to Migrate WSUS](../Topic/Step-2--Prepare-to-Migrate-WSUS.md)  
  
-   [Migrate Windows Server Update Services to Windows Server 2012](../Topic/Migrate-Windows-Server-Update-Services-to-Windows-Server-2012.md)  
  
-   [WSUS server role description](assetId:///77f5db8a-4b8f-4bd5-8493-387310adf46e#BKMK_OVER)  
  

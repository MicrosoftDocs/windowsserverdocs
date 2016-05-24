---
title: HRA Server Migration: Preparing to Migrate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 87e773f6-412b-4fca-8360-64bd42468f0e
author: vhorne
---
# HRA Server Migration: Preparing to Migrate
Migration of Health Registration Authority \(HRA\) Server includes the following tasks:  
  
-   [Choose a migration file storage location](../Topic/HRA-Server-Migration--Preparing-to-Migrate.md#BKMK_location)  
  
-   [Prepare your source server](../Topic/HRA-Server-Migration--Preparing-to-Migrate.md#BKMK_PrepSource)  
  
-   [Prepare your destination server](../Topic/HRA-Server-Migration--Preparing-to-Migrate.md#BKMK_PrepDest)  
  
Complete the steps or procedures in these sections to prepare your environment for migration.  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## <a name="BKMK_location"></a>Choose a migration file storage location  
First, choose a location where migration files will be kept.  
  
#### To choose a storage location  
  
1.  Select a file storage location where migration files will be kept. The storage location can be a network share that is accessible by both the source and destination server, or portable media that can be transferred from one server to another.  
  
## <a name="BKMK_PrepSource"></a>Prepare your source server  
Follow these steps to prepare an x64 or x86\-based server running  [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)], [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], or [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] for HRA migration.  
  
#### To prepare the source server  
  
1.  Determine the domain, server name, IP address, and passwords on the source server.  
  
2.  Determine the group membership of the source server in Active Directory Domain Services \(AD DS\), including security group and OU membership. This can be done using the Active Directory Users and Computers console \(dsa.msc\) or Server Manager on a domain controller.  
  
## <a name="BKMK_PrepDest"></a>Prepare your destination server  
Follow these steps to prepare an x64\-based destination server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] for HRA migration.  
  
#### To prepare the destination server  
  
1.  Install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on the destination server.  
  
2.  Configure the host name of the computer, and configure network settings as desired. Do not join the computer to the domain yet.  
  
3.  Install all critical updates and service packs on the destination server.  
  
4.  Verify the server has access to the migration file storage location.  
  
## See Also  
[HRA Migration Guide](assetId:///560d19ff-2d28-4818-b5ef-99799b46e617)  
[HRA Server Migration: Migrating the HRA Server](assetId:///edea1652-8847-4b0a-823a-1bfd3d726d6c)  
[HRA Server Migration: Verifying the Migration](assetId:///add013b0-170d-46fe-9f1e-4e2d71388e35)  
[HRA Server Migration: Post-migration Tasks](../Topic/HRA-Server-Migration--Post-migration-Tasks.md)  
[Network Access Protection Design Guide](http://go.microsoft.com/fwlink/p/?linkid=229363)  
[Network Access Protection Deployment Guide](http://go.microsoft.com/fwlink/p/?linkid=229364)  
  

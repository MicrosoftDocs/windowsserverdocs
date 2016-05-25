---
title: Copy a Clustered Role to Another Cluster
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 34e052dd-ec68-4759-a861-325d29395300
---
# Copy a Clustered Role to Another Cluster
You can use the Copy Cluster Roles Wizard to copy clustered roles from a failover cluster that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
To copy clustered roles, you must be a local administrator on both the cluster node from which you want to copy clustered roles, and the node in the other cluster to which you want to copy the roles.  
  
Realize that although role settings are copied, cluster settings, network settings, and data files that are used by the role are not copied. Also, for virtual machines, it assumes that storage is reused.  
  
## See also  
  
-   [Migrate Clustered Roles to Windows Server 2012 R2](http://go.microsoft.com/fwlink/?LinkId=329936)  
  

---
title: 5 Known Issues and Limitations in Technical Preview 3
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6643ba09-a069-4be6-b22c-d522d7d528bb
robots: noindex,nofollow
---
# 5 Known Issues and Limitations in Technical Preview 3
1.  ***You must run Windows Update on all servers (physical and virtual) used in this scenario validation, install all available updates, and restart your server if needed. ***    
2.  An in-place upgrade from any previous release to Technical Preview 3 release of Windows Server vNext is not supported.    
3.  Host Guardian Service and Hyper-V hosts must use same Technical Preview 3 release version of Windows Server vNext.    
4.  The Host Guardian Service role on Server Core is not supported in Technical Preview 3.    
5.  You cannot mix HGS Technical Preview 2 and HGS Technical Preview 3 nodes in the same cluster.    
6.  You cannot convert the HGS attestation mode from Active Directory to TPM or vice versa. You must uninstall the HGS server (on all nodes in the case if HGS is clustered for high availability), and then install with correct attestation mode.    
7.  You cannot change the HGS cluster name – “HgsCluster50E07” – for the Host Guardian Service Cluster.    
8.  `Test-HGSServer –HgsDomainName <your domain name>` reports an incorrect status.    
9.  When you run the `Initialize-HgsServer` command to configure HgsServer, you will see following message: “There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below.”    
    1.  When you view the report file, you may see the following warning message: “An appropriate disk was not found for configuring the disk witness. As a best practice, configure a quorum witness to help achieve the high availability of the cluster.”    
    2.  Please open Failover Cluster manager and verify that the HgsClusterGroup role service is started and is running. If it is, you can ignore this warning message.
---
title: Review HGS prerequisites
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: f4b4d1a8-bf6d-4881-9150-ddeca8b48038
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Review prerequisites for the Host Guardian Service

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016


This topic covers HGS prerequisites and initial steps to prepare for the HGS deployment.

## Prerequisites 

-   **Hardware**: HGS can be run on physical or virtual machines, but physical machines are recommended.

    If you want to run HGS as a three-node physical cluster (for availability), you must have three physical servers. (As a best practice for clustering, the three servers should have very similar hardware.)
  
-   **Operating system**: Host key attestation requires Windows Server 2019 Standard or Datacenter edition operating with [v2 attestation](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md#versioned-attestation-policies). For TPM-based attestation, HGS can run Windows Server 2019 or Windows Server 2016, Standard or Datacenter edition.

-   **Server Roles**: Host Guardian Service and supporting server roles.

-   **Configuration permissions/privileges for the fabric (host) domain**: You will need to configure DNS forwarding between the fabric (host) domain and the HGS domain. 
    
## Supported upgrade scenarios

Before you deploy a guarded fabric, make sure the servers have installed the [latest Cumulative Update](https://support.microsoft.com/help/4000825/windows-10-and-windows-server-2016-update-history). 
If you deployed a guarded fabric before the release of the [October 27, 2016 Cumulative Update](https://support.microsoft.com/kb/3197954), the servers need to be upgraded:
- Guarded hosts can be upgraded in-place by installing the latest Cumulative Update.
- HGS servers need to be rebuilt, including configuring certificates and information about the hosts. 

Shielded VMs that ran on a guarded host with an earlier operating system version, such as TP5, can still run after the host is upgraded to Windows Server 2016. New shielded VMs cannot be created from template disks that were prepared using the template disk wizard from a Technical Preview build.

## Next step

>[!div class="nextstepaction"]
[Obtain certificates for HGS](guarded-fabric-obtain-certs.md)
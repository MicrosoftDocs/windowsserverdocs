---
title: Appendix B - Add HGS to an existing domain
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 93a7efb8-20c5-4577-9150-3898e5becf3d
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Appendix B - Add HGS to an existing domain

>Applies To: Windows Server 2016

The following instructions describe how to add HGS to an existing domain, rather than using the default process of allowing HGS to create its own forest and domain. The default process is described in [Setting up the Host Guardian Service - HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

## Domain requirements for adding HGS to an existing domain

Before you can add HGS to an existing domain, you will need:

-   A Group Managed Service Account (gMSA) that exists in the domain and is configured for use on the machine(s) that host HGS.

-   Two Active Directory groups that you will use for Just Enough Administration (JEA). One group is for users who can perform HGS administration through JEA, and the other is for users who can only view HGS through JEA.

-   For running HGS in a cluster, either prestaged cluster objects or, for the user who runs **Initialize-HgsServer**, permission to add computer objects to the domain (which is possible by default).

## Command parameters for adding HGS to an existing domain

The following tables describe **Install-HgsServer** parameters to use when you add HGS to an existing domain.

| **Required Parameter**  | **Description**    |
|-------------------------|--------------------|
| `-UseExistingDomain`      | Adds HGS to an existing domain.                                                                                              |
| `-JeaAdministratorsGroup` | Identifies the Active Directory group of users who can perform HGS administration (through Just Enough Administration, JEA). |
| `-JeaReviewersGroup`      | Identifies the Active Directory group of users who can view HGS (through JEA).                                               |
| `-ServiceAccount`         | Identifies the group Managed Service Account (gMSA) that will be used for the Key Protection Service.                        |

| **Optional Parameter** | **Description**     |
|------------------------|---------------------|
| `-ClusterName`           | Optionally, identifies the name of an existing cluster for HGS to use, rather than allowing a cluster to be automatically created by **Initialize-HgsServer**. |

## Example command line for adding HGS to an existing domain

`Install-HgsServer -UseExistingDomain '<DomainName>' -JeaAdministratorsGroup <AdministratorsGroupName> -JeaReviewersGroup <ReviewersGroupName>
-ServiceAccount <gMSAforKPS> -ClusterName <ExistingClusterName> –Restart`

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)

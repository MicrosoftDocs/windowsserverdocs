---
title: Prerequisites for planning for Active Directory Forest Recovery
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: c49b40b2-598d-49aa-85b4-766bce960e0d
ms.technology: identity-adds
---
# Active Directory Forest Recovery Prerequisites

> Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

The following document discuss prerequisites that you should be familiar with before devising a forest recovery plan or attempting a recovery.

## Assumptions for Using This Guide

1. You have worked with a Microsoft Support professional and:
   - Determined the cause of the forest-wide failure. This guide does not suggest a cause of the failure or recommend any procedures to prevent the failure.
   - Evaluated any possible remedies.  
   - Concluded, in consultation with Microsoft Support, that restoring the whole forest to its state before the failure occurred is the best way to recover from the failure. In many cases, forest recovery should be the last option.

1. That you have followed the Microsoft best-practice recommendations for using Active Directory–integrated Domain Name System (DNS). Specifically, there should be an Active Directory–integrated DNS zone for each Active Directory domain.
   - If this is not the case, you can still use the basic principles of this guide to perform forest recovery. However, you will need to take specific measures for DNS recovery based on your own environment. For more information about using Active Directory–integrated DNS, see [Creating a DNS Infrastructure Design](../../ad-ds/plan/Creating-a-DNS-Infrastructure-Design.md).

1. Although this guide is intended as a generic guide for forest recovery, not all possible scenarios are covered. For instance, beginning with Windows Server 2008, there is a Server Core version, which is a full version of Windows Server but without a full GUI. Although it is certainly possible to recover a forest consisting of just DCs that run Server Core, this guide has no detailed instructions. However, based on the guidance discussed here you will be able to design the required command-line actions yourself.  

> [!NOTE]
> Although the objectives of this guide are to recover the forest and maintain or restore full DNS functionality, recovery can result in a DNS configuration that is changed from the configuration before the failure. After the forest is recovered, you can revert to the original DNS configuration. The recommendations in this guide do not describe how to configure DNS servers to perform name resolution of other portions of the corporate namespace where there are DNS zones that are not stored in AD DS.  

## Concepts for Using This Guide

Before you begin planning for recovery of an Active Directory forest, you should be familiar with the following:  
  
- Fundamental Active Directory concepts  
- The importance of operations master roles (also known as flexible single master operations or FSMO). These roles include the following:  
  - Schema master
  - Domain naming master
  - Relative ID (RID) master
  - Primary domain controller (PDC) emulator master
  - Infrastructure master

In addition, you should have backed up and restored AD DS and SYSVOL in a lab environment on a regular basis. For more information, see [Backing up the System State data](AD-Forest-Recovery-Procedures.md) and [Performing a nonauthoritative restore of Active Directory Domain Services](AD-Forest-Recovery-Procedures.md).

## Next Steps

> [!div class="nextstepaction"]
> [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)

> [!div class="nextstepaction"]
> [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md)

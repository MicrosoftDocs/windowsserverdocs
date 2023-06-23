---
title: Active Directory Forest Recovery - Prerequisites  
description: The following document discusses prerequisites that you should be familiar with before devising a forest recovery plan or attempting a recovery.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Prerequisites

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012.

The following document discusses prerequisites that you should be familiar with
before devising a forest recovery plan or attempting a recovery.

## Assumptions

1. You have worked with a Microsoft Support professional and:
    - Determined the cause of the forest-wide failure. This guide doesn't
        suggest the causes for failure nor does it recommend procedures to prevent failure.
    - Evaluated possible remedies.
    - Concluded, in consultation with Microsoft Support, that restoring the
        whole forest to its state before the failure is the best way to
        recover from the failure. In many cases, forest recovery should be the
        last option.
1. You have followed the Microsoft best-practice recommendations for using
    Active Directory–integrated Domain Name System (DNS). Specifically, there
    should be an Active Directory–integrated DNS zone for each Active Directory
    domain.

    If this isn't the case, you can still use the basic principles of this guide to perform forest recovery. However, you'll need to take specific measures for DNS recovery based on your own environment. For more information about using Active Directory–integrated DNS, see [Creating a DNS Infrastructure Design](/windows-server/identity/ad-ds/plan/creating-a-dns-infrastructure-design).
1. You may have a special configuration for the handling of Domain Controller
    disk volumes in your physical or virtual hosting, such as solutions to
    protect access to disk volumes, like BitLocker. As part of the
    procedure you may require access to emergency situation information like
    BitLocker Recovery keys. Ensure this information is available
    when needed during recovery.
1. Although this guide is intended as a generic guide for forest recovery, not
    all possible scenarios are covered. For instance, there's a Server Core
    version, which is a version of Windows Server without a desktop
    experience. Although it's possible to recover a forest consisting of just
    DCs that run Server Core, this guide has no detailed instructions. However,
    based on the guidance discussed here, you'll be able to design the required
    command-line actions yourself.

> [!NOTE]
> Although the objectives of this guide are to recover the forest and maintain or restore full DNS functionality, recovery can result in a DNS configuration that is changed from the configuration before the failure. After the forest is recovered, you can revert to the original DNS configuration. The recommendations in this guide do not describe how to configure DNS servers to perform name resolution of other portions of the corporate namespace where there are DNS zones that are not stored in AD DS.

## Prerequisites

### You are familiar with Active Directory concepts

Before you begin planning for recovery of an Active Directory forest, you should
be familiar with the following:

- Fundamental Active Directory concepts
- The importance of operations master roles (formerly known as flexible singles master operations or FSMO) including:
  - Forest-wide Operation Master Roles:
    - Schema master
    - Domain naming master
  - Domain-wide Operation Master Roles:
    - Relative ID (RID) master
    - Primary domain controller (PDC) emulator master
    - Infrastructure master

### You have a documented recovery plan with procedures

You should have a documented recovery plan with procedures for AD DS
domain/forest recoveries, object/subtree recoveries, and SYSVOL recoveries that
have been tested in a lab environment using production backups. The recovery
procedures should be vetted on a routine basis (for example, annually) and the
documentation updated as required by OS upgrades, architectural changes to the
AD DS environment, or any other changes that ensure the procedures are kept up
to date. For more information and guidance on these procedures, refer to the [AD Forest Recovery – Procedures](ad-forest-recovery-procedures.md) section of this guide.

> [!TIP]
> Microsoft offers the **Active Directory Recovery Execution Service (ADRES)** service to assist customers with the development of this documentation/procedure. Contact your Customer Success Account Management (CSAM) for details.

### You have backed up and restored AD DS and SYSVOL in a lab environment

You should have backed up and restored AD DS and SYSVOL in a lab
environment on a regular basis. For more information, see [AD Forest Recovery - Backing up a full server](ad-forest-recovery-backing-up-a-full-server.md).
and [Performing Nonauthoritative Restore of Active Directory Domain Services](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc816627(v=ws.10)).

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]

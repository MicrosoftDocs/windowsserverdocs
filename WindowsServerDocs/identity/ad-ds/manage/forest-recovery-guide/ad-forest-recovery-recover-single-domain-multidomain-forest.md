---
title: Active Directory Forest Recovery - Recovering a single domain in a multidomain forest
description: In certain scenarios, it may be necessary to recover only a single domain within a forest that has multiple domains, rather than a full forest recovery. This topic covers considerations for recovering a single domain and possible strategies for recovery.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 07/10/2023
ms.topic: article
---

# Active Directory Forest Recovery - Recover a single domain in a multidomain forest

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

In certain scenarios, it may be necessary to recover only a single domain within
a forest that has multiple domains, rather than a full forest recovery. This
topic covers considerations for recovering a single domain and possible
strategies.

Similar to the forest recovery process, you restore one or more DCs from backup
in the domain and perform metadata cleanup of remaining
DCs. New domain controllers are then added by joining new members, installing AD
DS roles and promoting them. You can also use **DC Cloning** or **Install from Media** for the task.

A single domain recovery presents a unique challenge for rebuilding global
catalog (GC) servers. For example, if the first domain controller (DC) for the
domain is restored from a backup that was created one week earlier, then all
other GCs in the forest will have more up-to-date data for that domain than the
restored DC. To re-establish GC data consistency, there are a couple options:

- Unhost the recovered domains partition from all GCs in the forest, except those in the recovered domain, at the same time and once complete, rehost all GCs in the forest. Also make sure you don't overload the remaining GCs. In large environments, coordinating this activity can be very complex.

- Follow the forest recovery process to recover the domain, and then remove lingering objects from GCs in other domains.

The following sections provide general considerations for each option. The
complete set of steps that need to be done for the recovery will vary for
different Active Directory environments.

## Recreate Group Managed Service Accounts (gMSA)

> [!WARNING]
> If the KDS Root Key objects in the forest were compromised, you should re-create the gMSA accounts in multiple domains, even if the domain itself was not compromised.

The problem and resolution is discussed in [How to recover from a Golden gMSA attack](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack).

You must prevent an attacker from using data harvested from a stolen Domain
Controller backup to authenticate using gMSA calculated credentials. Replace all gMSAs in the domains of the forest that use the exposed KDS Root Key objects, with gMSA accounts using a new KDS Root Key object. The procedure is described in [Getting Started with Group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts)
with a few important changes:

- Disable all existing gMSA accounts, set the userAccountControl attribute to
    4098 (workstation type + disabled).
- Create a new KDS Root Key object as described in [Create the Key Distribution Services KDS Root Key](/windows-server/security/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key).

    > [!IMPORTANT]
    > Restart the Microsoft Key Distribution Service (KDSSVC) on the same domain controller. This is needed so the new object is picked up by KDSSVC. Create new gMSA accounts to replace the existing accounts on the same domain controller. At this point, edit the existing gMSA account as unique service principal names must be assigned to the active gMSA.

- After you have the member servers re-joined to the domain, update the components that used gMSA with the new accounts.

To ensure the new gMSA uses the new KDS Root Key object, check the attribute
`msDS-ManagedPasswordId` binary data has the GUID of the matching KDS Root key object. The object would have the CN of `CN=e3779ca1-bfa2-9f7b-b9a5-20cf44f2f8d6`.

:::image type="content" source="media/gmsa-cn.png" alt-text="gmsa cn value":::

`msDS-ManagedPasswordId` of the gMSA should have the GUID starting offset 24 with the first three parts of the GUID in byte-swapped order (red, green, blue), and the rest in normal byte order (orange):  

:::image type="content" source="media/guid.png" alt-text="guid with color coding":::

If the first gMSA was created using the new KDS Root Key, all subsequent gMSA
creations will be OK.

## Cleanup

- Delete the old gMSA accounts that used the old KDS Root Key Objects.
- Delete the old KDS Root Key Objects.

## Rehost all GCs

> [!WARNING] 
> The login name and password of the default Domain Administrator user account (“RID-500”) for all domains must available, and the account(s) enabled for use in case a problem that prevents access to a GC for logon.  

> [!NOTE]
> To allow logon without the GC verification, it's possible also to configure `HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\IgnoreGCFailures` value to 1.  
>
> *If unknown, obtain the* **Domain ID** *by using `whoami /all` for another account in each domain or run the following command to identify the RID 500.*
> `\$DomainSID = (Get-ADDomain).DomainSID.Value`
> `\$ObjSID = New-Object`
> `System.Security.Principal.SecurityIdentifier("\$DomainSID-500")`
> `\$RID500 = \$ObjSID.Translate([System.Security.Principal.NTAccount])`
> `\$RID500.Value`

Rehosting all GCs can be done using `repadmin /unhost` and `repadmin /rehost`
commands (part of `repadmin /experthelp`). You would run the `repadmin` commands on
every GC in each domain that isn't recovered. It needs to be ensured, that all
GCs don't hold a copy of the recovered domain anymore. To achieve this, unhost
the domain partition first from all domain controllers across all none-recovered
domains of the forest first. Since GCs don't contain the partition anymore,
you can rehost it. When rehosting, consider the site and replication structure
of your forest. For example, finish the rehost of one DC per site prior to
rehosting the other DCs of that site.

This option can be advantageous for a small organization that has only a few
domain controllers for each domain. All of the GCs could be rebuilt on a Friday
night and, if necessary, complete replication for all read-only domain
partitions before Monday morning. However, if you need to recover a large domain that
covers sites across the globe, rehosting the read-only domain partition on all
GCs for other domains can significantly impact operations and potentially
require down time.

## Check for and remove lingering objects

On the GCs of all other domains in the forest, you check and remove the
potentially lingering objects for the read-only partition of the recovered
domain.

The source for the lingering object cleanup must be a DC in the recovered
domain. To be certain that the source DC doesn't have any lingering objects for
any domain partitions, you can remove the global catalog.

Removing lingering objects is advantageous for larger organizations that can't
risk the down time associated with rehosting the domain naming context.

For more information, see [Use repadmin to remove lingering objects](/previous-versions/windows/it-pro/windows-server-2003/cc785298(v=ws.10)).

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]

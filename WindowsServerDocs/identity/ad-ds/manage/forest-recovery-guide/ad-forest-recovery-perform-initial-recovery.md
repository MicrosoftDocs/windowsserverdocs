---
title:  Active Directory Forest Recovery - Perform initial recovery
description: Beginning with a writeable DC in the forest root domain, complete the steps in this section in order to restore the first DC.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 07/10/2023
ms.topic: article
---

# Active Directory Forest Recovery - Perform the initial recovery

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

This section includes the following steps:

- [Restore the first writeable domain controller in each domain](ad-forest-recovery-perform-initial-recovery.md#restore-the-first-writeable-domain-controller-in-each-domain)
- [Reconnect each restored writeable domain controller to the network](ad-forest-recovery-perform-initial-recovery.md#reconnect-each-restored-writeable-domain-controller-to-a-common-network)
- [Add the global catalog to a domain controller in the forest root domain](ad-forest-recovery-perform-initial-recovery.md#add-the-global-catalog-to-a-domain-controller-in-the-forest-root-domain)

## Restore the first writeable domain controller in each domain

Beginning with a writeable DC in the forest root domain, complete the steps in
this section in order to restore the first DC. The forest root domain is
important because it stores the Schema Admins and Enterprise Admins groups. It
also helps maintain the trust hierarchy in the forest. In addition, the forest
root domain usually holds the DNS root server for the forest's DNS namespace.
Consequently, the Active Directory–integrated DNS zone for that domain contains
the alias (CNAME) resource records for all other DCs in the forest (which are
required for replication) and the global catalog DNS resource records.

After you recover the forest root domain, repeat the same steps to recover the
remaining domains in the forest. You can recover more than one domain
simultaneously; however, always recover a parent domain before recovering a
child to prevent any break in the trust hierarchy or DNS name resolution.

For each domain that you recover, restore one writeable DC from backup. This is
the most important part of the recovery because the DC must have a database that
hasn't been influenced by whatever caused the forest to fail. It's important
to have a trusted backup that is thoroughly tested before it's introduced into
the production environment.

Then perform the following steps. Procedures for performing certain steps are in
[AD Forest Recovery - Procedures](ad-forest-recovery-procedures.md).

1. If you plan to restore a physical server, ensure that the network cable of
    the target DC isn't attached and therefore isn't connected to the
    production network. For a virtual machine, you can remove the network
    adapter or use a network adapter that is attached to another network where
    you can test the recovery process while isolated from the production
    network.
1. Because this is the first writeable DC in the domain, you must perform a
    nonauthoritative restore of AD DS and an authoritative restore of SYSVOL.
    The restore operation must be completed by using an Active Directory-aware
    backup and restore application, such as Windows Server Backup (recommended).
    If Hyper-Vistor Generation ID is supported on the host, then you can also do
    the nonauthoritative restore using a VM snapshot.

    - An authoritative restore of SYSVOL is required on the first recovered
        DC, because replication of the SYSVOL folder must be restarted with the
        new instances after you recover from a disaster. All subsequent DCs that
        are added in the domain must resynchronize their SYSVOL folder with a
        copy of the folder that has been selected to be authoritative.

        >[!WARNING]
        > Perform an authoritative (or primary) restore operation of SYSVOL only for the first DC to be restored in the forest root domain. Incorrectly performing primary restore operations of the SYSVOL on other DCs leads to replication conflicts of SYSVOL data. There are two options perform a nonauthoritative restore of AD DS and an authoritative restore of SYSVOL:

    - Perform a full server recovery and then force an authoritative
        synchronization of SYSVOL. For detailed procedures, see [Performing a full server recovery](ad-forest-recovery-perform-full-server-recovery.md)
        and [Perform an authoritative synchronization of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-sysvol.md).

    - Perform a full server recovery followed by a system state restore. This
        option requires that you create both types of backups in advance: a full
        server backup and a system state backup. For detailed procedures, see
        [Performing a full server recovery](ad-forest-recovery-perform-full-server-recovery.md) and [Performing a nonauthoritative restore of Active Directory Domain Services](ad-forest-recovery-perform-nonauthoritative-restore.md).

1. After you restore and restart the writeable DC, verify that the failure didn't affect the data on the DC. If the DC data is damaged, then repeat step 2 with a different backup.

    - If the restored domain controller hosts an operations master role, you
        may need to add the following registry entry to avoid AD DS being
        unavailable until it has completed replication of a writeable directory
        partition:

        ```cli
        HKLM\System\CurrentControlSet\Services\NTDS\Parameters\Repl
        Perform Initial Synchronizations
        ```

        Create the entry with the data type **REG_DWORD** and a value of **0**.
        After the forest is recovered completely, you can reset the value of
        this entry to **1**, which requires a domain controller that restarts
        and holds operations master roles to have successful AD DS inbound and
        outbound replication with its known replica partners before it
        advertises itself as domain controller and starts providing services to
        clients. For more information about initial synchronization
        requirements, see [Active Directory FSMO Roles](/troubleshoot/windows-server/identity/fsmo-roles).

1. Continue to the Next steps only after you restore and verify the data and before you join this computer to the production network.
1. If you suspect that the forest-wide failure was related to network intrusion
    or malicious attack, reset the account passwords for all administrative
    accounts, including members of the Enterprise Admins, Domain Admins, Schema
    Admins, Server Operators, Account Operators groups, and so on. The krbtgt
    account complete password reset procedure is also needed.. The reset of
    administrative account passwords should be completed before additional
    domain controllers are installed during the next phase of the forest
    recovery.

    In this case also, work on replacing all GMSA passwords as if an
    administrative account was taken over, the attacker may have retrieved
    information that allows them to authenticate as GMSA. For details see the
    article about the [golden GMSA attack](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack).
1. If you suspect user accounts have been compromised, you also need to plan
    for a user password reset for all users in the domain.
1. On the first restored DC in the forest root domain, seize all domain-wide
    and forest-wide operations master roles. Enterprise Admins and Schema Admins
    credentials are needed to seize forest-wide operations master roles as
    required.

    In each child domain, seize domain-wide operations master roles as required.
    Although you might retain the operations master roles on the restored DC
    only temporarily, seizing these roles assures you regarding which DC hosts
    them at this point in the forest recovery process. As part of your
    post-recovery process, you can redistribute the operations master roles as
    needed. For more information about seizing operations master roles, see
    [Seizing an operations master role](ad-forest-recovery-seizing-operations-master-role.md).
    For recommendations about where to place operations master roles, see [What Are Operations Masters?](/previous-versions/windows/it-pro/windows-server-2003/cc779716(v=ws.10)).
    Also see [Flexible Single-Master Operation (FSMO) placement and optimization on AD DCs](/troubleshoot/windows-server/identity/fsmo-placement-and-optimization-on-ad-dcs).

1. Clean up metadata of all other writeable DCs in the forest root domain that
    you aren't restoring from backup (all writeable DCs in the domain except
    for this first DC). If you use the version of Active Directory Users and
    Computers or Active Directory Sites and Services that is included with
    Windows Server 2012 or later or RSAT for Windows 10 or later, metadata
    cleanup is performed automatically when you delete a DC object. In addition,
    the server object and computer object for the deleted DC are also deleted
    automatically. For more information, see [Cleaning metadata of removed writable DCs](ad-forest-recovery-cleaning-metadata-of-removed-dcs.md)and
    [Clean up AD DS server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

    Cleaning up metadata prevents possible duplication of NTDS-settings objects
    if AD DS is installed on a DC in a different site. Potentially, this could
    also save the Knowledge Consistency Checker (KCC) the process of creating
    replication links when the DCs themselves might not be present. Moreover, as
    part of metadata cleanup, DC Locator DNS resource records for all other DCs
    in the domain will be deleted from DNS.

    Until the metadata of all other DCs in the domain is removed, this DC, if it
    were a RID master before recovery, won't assume the RID master role and
    therefore won't be able to issue new RIDs. You might see event ID 16650
    in the System log in Event Viewer indicating this failure, but you should
    see event ID 16648 indicating success a little while after you have cleaned
    the metadata.

1. If you have DNS zones that are stored in AD DS, ensure that the local DNS
    Server service is installed and running on the DC that you have restored. If
    this DC wasn't a DNS server before the forest failure, you must install and
    configure the DNS server role on the DC or a DNS server needs to be
    available on the restoration environment.

    In the forest root domain, configure the restored DC with its own IP address
    as its preferred DNS server. You can configure this setting in the TCP/IP
    properties of the local area network (LAN) adapter. This is the first DNS
    server in the forest. For more information, see [Recommendations for Domain Name System (DNS) client settings](/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings#domain-controller-with-dns-installed).

    In each child domain, configure the restored DC with the IP address of the
    first DNS server in the forest root domain as its preferred DNS server. You
    can configure this setting in the TCP/IP properties of the LAN adapter. For
    more information, see [Recommendations for Domain Name System (DNS) client settings](/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings#domain-controller-with-dns-installed.md).

    In the \_msdcs and domain DNS zones, delete NS records of DCs that no longer
    exist after metadata cleanup. Check if the SRV records of the cleaned up DCs
    have been removed. To help speed up DNS SRV record removal, run:

    `nltest.exe /dsderegdns:server.domain.tld`
1. Raise the value of the available RID pool by 100,000. For more information,
    see [Raising the value of available RID pools](ad-forest-recovery-raise-rid-pool.md).
    If you have reason to believe that raising the RID Pool by 100,000 is
    insufficient for your particular situation, you should determine, taking
    into account the average RID consumption on your environment, the lowest
    increase that is still safe to use. RIDs are a finite resource that shouldn't be used up needlessly.

    If new security principals were created in the domain after the time of the
    backup that you use for the restore, these security principals might have
    access rights on certain objects. These security principals no longer exist
    after recovery because the recovery has reverted to the backup; however,
    their access rights might still exist. If the available RID pool isn't
    raised after a restore, new user objects that are created after the forest
    recovery might obtain identical security IDs (SIDs) and could have access to
    those objects, which wasn't originally intended.

    For example, there may have been a new employee. The user object no longer exists
    after the restore operation because it was created after the backup that was
    used to restore the domain. However, any access rights that were assigned to
    that user object might persist after the restore operation. If the SID for
    that user object is reassigned to a new object after the restore operation,
    the new object would obtain those access rights.

1. Invalidate the current RID pool. The current RID pool is invalidated after a
    system state restore. But if a system state restore wasn't performed, the
    current RID pool needs to be invalidated to prevent the restored DC from
    reissuing RIDs from the RID pool that was assigned at the time the backup
    was created. For more information, see [Invalidating the current RID pool](ad-forest-recovery-invaildate-rid-pool.md).

    >[!NOTE]
    > The first time that you attempt to create an object with a SID after you invalidate the RID pool you will receive an error. The attempt to create an object triggers a request for a new RID pool. Retry of the operation succeeds because the new RID pool will be allocated.

1. Reset the computer account password of this DC twice. For more information, see [Resetting the computer account password of the domain controller](ad-forest-recovery-reset-computer-account-dc.md).
1. Reset the krbtgt password twice. For more information, see [Resetting the krbtgt password](ad-forest-recovery-reset-the-krbtgt-password.md). Because the krbtgt password history is two passwords, reset passwords twice to remove the original (prefailure) password from password history.

    >[!NOTE]
    > If the forest recovery is in response to a security breach, you may also reset the trust passwords. For more information, see [Resetting a trust password on one side of the trust](ad-forest-recovery-reset-trust.md).

1. If the forest has multiple domains and the restored DC was a global catalog
    server before the failure, clear the **Global catalog** check box in the
    NTDS Settings properties to remove the global catalog from the DC. The
    exception to this rule is the common case of a forest with just one domain.
    In this case, it isn't required to remove the global catalog. For more information, see [Removing the global catalog](ad-forest-recovery-remove-gc.md).

    By restoring a global catalog from a backup that is more recent than other
    backups that are used to restore DCs in other domains, you might introduce
    lingering objects. Consider the following example. In domain A, DC1 is
    restored from a backup that was taken at time T1. In domain B, DC2 is
    restored from a global catalog backup that was taken at time T2. Suppose T2
    is more recent than T1, and some objects were created between T1 and T2.
    After these DCs are restored, DC2, which is a global catalog, holds newer
    data for domain A's partial replica than domain A holds itself. DC2, in this
    case, holds lingering objects because these objects aren't present on DC1.

    The presence of lingering objects can lead to problems. For instance, e-mail
    messages might not be delivered to a user whose user object was moved
    between domains. After you bring the outdated DC or global catalog server
    back online, both instances of the user object appear in the global catalog.
    Both objects have the same e-mail address; therefore, e-mail messages can't
    be delivered.

    Another problem is that a user account that no longer exists may still
    appear in the global address list.

    Addtionally, a universal group that no longer exists might still appear in a user's access token.

    If you did restore a DC that was a global catalog—either inadvertently or
    because that was the solitary backup that you trusted—we recommend that you
    prevent the occurrence of lingering objects by disabling the global catalog
    soon after the restore operation is complete. Disabling the global catalog
    flag will result in the computer losing all its partial replicas
    (partitions) and relegating itself to regular DC status.

1. If you're using gMSA accounts, you may need to re-create them as the
    password generation details may be exposed to an attacker, see:  
    [How to recover from a Golden gMSA attack](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack)  

    See [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](ad-forest-recovery-recover-single-domain-multidomain-forest.md) for steps on how to replace the gMSAs and make sure they use secure key material.  

1. Configure Windows Time Service. In the forest root domain, configure the PDC
    emulator to synchronize time from an external time source. For more
    information, see [Configure the Windows Time service on the PDC emulator in the Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731191%28v=ws.10%29).

## Reconnect each restored writeable domain controller to a common network

At this stage, you should have one DC restored (and recovery steps performed) in
the forest root domain and in each of the remaining domains. Join these DCs to a
common network that is isolated from the rest of the environment and complete
the following steps in order to validate forest health and replication.

>[!NOTE]
> When you join the physical DCs to an isolated network, you may need to change their IP addresses. As a result, the IP addresses of DNS records will be wrong. Because a global catalog server is not available, secure dynamic updates for DNS will fail. Virtual DCs are more advantageous in this case because they can be joined to a new virtual network without changing their IP addresses. This is one reason why virtual DCs are recommended as the first domain controllers to be restored during forest recovery.

## Verify forest replication health

After validation, join the DCs to the production network and complete the steps
to verify forest replication health.

- To fix name resolution, create DNS delegation records and configure DNS
    forwarding and root hints as needed.
- Run `repadmin /replsum` to check replication between DCs.
- If the restored DCs aren't direct replication partners, replication
    recovery will be much faster by creating temporary connection objects
    between them.
- To validate metadata cleanup, run `Repadmin /viewlist \*` for a list of
    all DCs in the forest. Run `Nltest /DCList:***\<domain\>*` for a list of all
    DCs in the domain.
- To check DC and DNS health, run `DCDiag /v` to report errors on all DCs in the
    forest.

## Add the global catalog to a domain controller in the forest root domain

A global catalog is required for these and other reasons:

- To enable logons for users.
- To enable the Net Logon service running on the DCs in each child domain to
    register and remove records on the DNS server in the root domain.

Although it's preferred that the forest root DC is a global catalog, it's
generally recommended to decide that all DCs to are a global catalog.

>[!NOTE]
> A DC will not be advertised as a global catalog server until it has completed a full synchronization of all directory partitions in the forest. Therefore, the DC should be forced to replicate with each of the restored DCs in the forest.

Monitor the Directory Service event log in Event Viewer for event ID 1119, which indicates that this DC is a global catalog server, or verify the following registry key has a value of 1:

```cli
**HKLM\System\CurrentControlSet\Services\NTDS\Parameters\Global Catalog
Promotion Complete**
```

For more information, see [Adding the global catalog](ad-forest-recovery-add-gc.md).

At this stage you should have a stable forest, with one DC for each domain and
one global catalog in the forest. You should make a new backup of each of the
DCs that you have just restored. You can now begin to redeploy other DCs in the
forest by installing AD DS and configuring additional Global Catalog servers.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]

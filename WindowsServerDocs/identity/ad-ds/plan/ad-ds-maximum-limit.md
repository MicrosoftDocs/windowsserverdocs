---
title: Active Directory maximum limits and scalability
description: 
author: Heidilohr
ms.author: helohr
manager: helohr
ms.date: 04/30/2024
ms.topic: conceptual
---

# Active Directory maximum limits and scalability

>Applies to: Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

This article describes the maximum limits for certain aspects of your Active Directory environment that can affect scalability. We recommend you keep these limits in mind while planning for your Active Directory deployment.

## Maximum number of objects

Each domain controller in an Active Directory forest can create almost 2.15 billion objects during its lifetime.

Each Active Directory domain controller has a unique identifier specific to the individual domain controller. These identifiers, which are called Distinguished Name Tags (DNTs), are unique values that aren't replicated or otherwise visible to other domain controllers. The range of values for DNTs is from 0 through 2,147,483,393 (231 minus 255). When you delete an object, no new objects you create afterwards can use the same DNT. Therefore, domain controllers are limited to creating under two billion objects, which also includes objects the domain controller replicates. This limit applies to the aggregate of all objects from all partitions hosted on the domain controller, including the domain NC<!--Acronym-->, configuration, schema, and any application directory partitions.

There are possible ways to work around the domain controller lifetime creation limit. For example, you can remove objects from the domain by deleting them permanently. You can also install a new domain controller that replicates the remaining objects from the potential domain controller. However, you must make sure the new domain controller receives the objects through replication, and that you don't promote it using the Install from Media (IFM) option. Domain controllers installed using IFM inherit the DNT values from the domain controller the IFM backup was based on.

When you reach the DNT limit on a database, you see the following error message:

```cmd
Error: Add: Operations Error. <1> Server error: 000020EF: SvcErr: DSID-0208044C, problem 5012 (DIR_ERROR), data -1076.
```

>[!NOTE]
>If you run into an issue where the size of your Active Directory database increases rapidly on a domain controller that hosts the DNS<!--acronym--> server role due to deleted DNS records, see [KB 2548145](https://support.microsoft.com/kb/2548145). This KB article describes a hotfix that changes how the DNS Server component deals with dnsNode object deletions during the garbage collection process.

You can run the following command to check the *approximateHighestInternalObjectID* attribute to see the highest DNT your domain controller currently uses:

```cmd
$ossupported = $false
 
# max possible DNTs
$maxdnts = [System.Math]::Pow(2, 31) - 255
 
# connect rootDSE
$root = [ADSI]"LDAP://rootDSE"
 
# get operational attribute dsaVersionString
$root.RefreshCache("dsaVersionString")
 
# get version string usable in System.Version
$osverstring = $root.dsaVersionString[0].Substring(0, $root.dsaVersionString[0].IndexOf(" "))
 
try
{
    $osver = New-Object System.Version $osverstring
 
    # we need at least W2K12 DC to see the approximateHighestInternalObjectID exposed
    if ($osver.Major -gt 6)
    { $ossupported = $true }
 
    elseif ($osver.Major -eq 6)
    { $ossupported = ($osver.Minor -ge 2) }
}
 
catch
{ Write-Host "ERROR: Could not evaluate DC OsVer!"  }
 
if ($ossupported)
{
    # get operational attribute approximateHighestInternalObjectID
    $root.RefreshCache("approximateHighestInternalObjectID")
 
    Write-Host "Approx highest committed DNT: $($root.approximateHighestInternalObjectID[0])"
 
    Write-Host "DNTs left for new assignments: $($maxdnts - $root.approximateHighestInternalObjectID[0]) from $maxdnts"
}
 
else
{ Write-Host "approximateHighestInternalObjectID not exposed (DC OsVer: $osverstring)" }
```

## Maximum number of security identifiers

The maximum number of security identifiers you can create over the lifetime of a domain controller is 2,147,483,647 RIDs. For more information about issuing and monitoring RIDs, see [Managing RID Issuance](https://technet.microsoft.com/library/jj574229.aspx).

This limit is due to the size of the global relative identifier (RID) pool that makes each SID assigned to user, group, and computer accounts in a domain unique. RIDs aren't reused even if you delete their security principals, so the maximum limit always applies no matter how many security principals are in the domain.

>[!NOTE]
>RIDs are assigned in blocks of 500 by default from the domain controller that holds the RID operations master role in each domain. If you demote a domain controller, the unused RIDs originally allocated to the domain controller don't return to the global RID pool and become unavailable for use in the domain.

Windows Server begins to prepare an artificial limit for RID issuance when the number of available RIDs reaches 90 percent of the available global RID space. When the number of available RIDs reaches comes within one percent of that limit, domain controllers that request RID pools will receive the Directory-Services-SAM warning event 16656 in their System event log.

A partial workaround to the RID limit is creating an extra domain for holding accounts, then migrating accounts to that new domain. However, you must create any required trust relationships for the new domain before you reach the limit. Creating a trust relationship requires a security principle, also known as a trust user account. For more information about the RID limit, see [KB 316201](https://go.microsoft.com/fwlink/?LinkID=115211) and [KB 305475](https://go.microsoft.com/fwlink/?LinkId=115212).

>[!NOTE]
> The Active Directory database doesn't set limits on the number of objects in a container, but does set limits when you work with many thousands of objects. Microsoft configured these limits to provide a certain level of application or service availablility. You can adjust these limits by either reconfiguring Filter Options settings on the view menu or changing the Lightweight Directory Access Protocol (LDAP) policies. For more information, see [KB 315071](https://go.microsoft.com/fwlink/?LinkID=135481).

## Maximum Number of entries in Discretionary and Security Access Control Lists

This limitation applies to how many entries you can have in a discretionary access control list (DACL) or a security access control list (SACL) of an Active Directory object using the ntSecurityDescriptor attribute. The limit itself is based on the size limitations of the access control list (ACL), which is 64K. Because access control entries (ACEs) can vary in size, the actual maximum number of entries (SIDs) is about 1,820. For more details, see [How Security Descriptors and Access Control Lists Work](https://go.microsoft.com/fwlink/?LinkId=214683).

## Group Memberships for security principals

Security principals, such as user, group, and computer accounts, can be members of a maximum of 1,015 groups. This limitation is because the access token that you create for each security principal has a size limit, which isn't affected by how you nest the groups. For more information, see [KB 328889](https://go.microsoft.com/fwlink/?LinkID=115213) and [Addressing Problems Due to Access Token Limitation](https://go.microsoft.com/fwlink/?LinkId=146571).

For more information about how a domain controller creates the data structure that is used for authorization decisions, see the following articles:

- [MS-PAC: Privilege Attribute Certificate Data Structure](https://msdn.microsoft.com/library/cc237917(PROT.13).aspx)

- [Initial Population of the PAC](https://msdn.microsoft.com/library/cc233956(PROT.13).aspx)

- [Domain Local Group Membership](https://msdn.microsoft.com/library/cc233950(PROT.13).aspx)

## FQDN length limitations

Fully qualified domain names (FQDNs) in Active Directory can't exceed 64 characters in total length, including hyphens and periods. This limitation exists because the Win3 application programming interfaces (APIs) and Group Policy objects (GPOs) stored in the SYSVOL share define the MAX_PATH value as 260 characters. For more information, see [KB 245809](https://go.microsoft.com/fwlink/?LinkID=115219) and [KB 909264](https://go.microsoft.com/fwlink/?LinkID=106629).

## Filename and path limitations

The physical files that Active Directory components use, such as SYSVOL, database (NTDS.DIT), and log file paths, are limited by the MAX_PATH length of 260 characters, as defined by the Win32 APIs. When deciding where to place your SYSVOL and database files during Active Directory installation, avoid nested folder structures that make the full file path to any physical files in your Active Directory longer than 260 characters. For more information, see [KB 245809](https://go.microsoft.com/fwlink/?LinkId=115219).

## Other name length limitations

The following name length limits, which are described in [KB 909264](https://go.microsoft.com/fwlink/?LinkID=106629), also apply to resource and file names in Active Directory:

- NetBIOS computer and domain names can only be 15 characters long.

- Domain Name System (DNS) host names can only be 24 characters long.

- OU names can only be 64 characters long.

## Name length limits from the schema

The schema imposes the following default limits on attribute names for Active Directory objects:

- Display names can only be 256 characters long, as described in [Display-Name Attribute](https://go.microsoft.com/fwlink/?LinkId=153705).

- Common names can only be 64 characters long, as described in [Common-Name Attribute](https://go.microsoft.com/fwlink/?LinkId=153706).

- The SAM-Account-Name attribute can only be 256 characters long in the schema. However, for the purpose of backward compatibility, the Active Directory limit is 20 characters long. For more information, see [SAM-Account-Name Attribute](https://go.microsoft.com/fwlink/?LinkId=153707).

## Name length limitations for LDAP simple bind operations

During binds to the directory, simple LDAP bind operations limit the distinguished name (DN) for the user to 255 characters. If you attempt a simple LDAP bind with more than 255 characters, you might experience authentication errors, such as the following:

```text
Error <49>: ldap_simple_bind_s() failed: Invalid Credentials
Server error: 80090308: LdapErr: DSID-0C0903AA, comment: AcceptSecurityContext error, data 57, v1771
Error 0x80090308 The token supplied to the function is invalid
```

You can avoid this issue by ensuring that the applications, scripts, and utilities that attempt to bind to your directory use secure LDAP binds. You can also try reducing the depth of the OU structure or the length of the OU names. For example, the following distinguished name is 261 characters:

```text
CN=BobKelly,OU=CorporateVicePresidents,OU=CorporateOfficers,OU=ViewOfPugetSoundOffices,OU=TopFloor,OU=Building1557,OU=CorporateCampus,OU=Redmond,OU=Washington,OU=NorthWestern,OU=UnitedStatesOfAmerica,OU=NorthAmerica,DC=BusinessGroup,DC=humongousinsurance,DC=com
```

If you shorten the OU named `CorporateVicePresidents` to `CVP`, the distinguished name for the `BobKelly` user account is now only 242 characters and is therefore within the limit.

## Maximum number of GPOs applied

Active Directory limits the amount of GPOs you can apply to a user or computer account to 999. This limit doesn't mean the total number of policy settings on the system is limited to 999. Instead, a single user or computer can't process more than 999 GPOs. This limitation exists to prevent performance issues caused by processing too many GPOs at the same time.

## Trust limitations

Trust limitations apply to the number of trusted domain objects (TDOs), the length of trust paths, and the ability of clients to discover available trusts. The trust limitations for Active Directory include the following:

- Kerberos clients can traverse up to 10 trust links to locate a requested resource in another domain. If the trust path between the domains exceeds this limit, the attempt to access the domain fails.

- When a client searches out a trust path, the search is limited to trusts established directly with a domain and trusts that are transitive within a forest.

- Previous testing shows that the increased time to complete TDO-related operations, such as authentication across domains, deteriorates performance noticeably if the Active Directory implementation in an organization contains more than 2,400 TDOs.

For more information about trust limitations, see [Practical limitations of trusts](/previous-versions/windows/it-pro/windows-server-2003/cc773178(v=ws.10)?redirectedfrom=MSDN#practical-limitations-of-trusts).

## Maximum number of accounts per LDAP transaction

When you write scripts or design applications that perform LDAP transactions, we recommend that you perform no more than 5,000 operations per LDAP transaction. An LDAP transaction is a group of directory operations that are treated as one unit, such as add, delete, and modify. If you perform more than 5,000 operations in one LDAP transaction, you're at risk of running into resource limits and an operational time-out. If you run into that issue, all operations in the transaction are rolled back, causing you to lose any changes you made during the transaction. To learn more about the LDAP data structure that commits changes, see [LDAPModA Structure](/windows/win32/api/winldap/ns-winldap-ldapmoda).

## Recommended maximum number of users in a group

<!---Stopped here--->

For Windows 2000 Active Directory environments, the recommended maximum number of members in a group is 5,000. This recommendation is based on the number of concurrent atomic changes that can be committed in a single database transaction.

Starting with Windows Server 2003, the ability to replicate discrete changes to linked multivalued properties was introduced as a technology called Linked Value Replication (LVR). To enable LVR, you must increase the forest functional level to at least Windows Server 2003 interim. Increasing the forest functional level changes the way that group membership (and other linked multivalued attributes) is stored in the database and replicated between domain controllers. This allows the number of group memberships to exceed the former recommended limit of 5,000 for Windows 2000 or Windows Server 2003 at a forest functional level of Windows 2000.

So far, testing in this area has yet to reveal any new recommended limits to the number of members in a group or any other linked multivalued attribute. Production environments have been reported to exceed 4 million members, and Microsoft scalability testing reached 500 million members.

>[!IMPORTANT]
>Increasing the forest functional level to Windows Server 2003 interim or higher does not modify the way that existing group members are stored or replicated. To do that, you must remove the members that were added to the group before the forest functional level was increased to Windows Server 2003 and then add them back again to the appropriate groups. Any group members that you either add or remove after the forest functional level is increased will be LVR enabled, even if the group contains other members that are not LVR enabled. For more information about linked attributes, see Linked Attributes (https://go.microsoft.com/fwlink/?LinkId=142909). For more information about the replication process, see How the Active Directory Replication Model Works (https://go.microsoft.com/fwlink/?LinkId=142908).

## Recommended Maximum Number of Domains in a Forest

For Windows 2000 Server, the recommended maximum number of domains in a forest is 800. For Windows Server 2003, the recommended maximum number of domains when the forest functional level is set to Windows Server 2003 (also known as forest functional level 2) is 1,200. This restriction is a limitation of multivalued, nonlinked attributes in Windows Server 2003. For more information, see “Maximum Database Record Size” in How the Data Store Works (https://go.microsoft.com/fwlink/?LinkId=134791).

## Recommended Maximum Number of Domain Controllers in a Domain

To ensure reliable recovery of SYSVOL, we recommend a limit of 1200 domain controllers per domain.  

If any Active Directory domain in your network is expected to exceed 800 domain controllers and those domain controllers are hosting Active Directory–integrated Domain Name System (DNS) zones, review article 267855 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=115222).

For more information about FRS limitations, see the FRS Technical Reference (https://go.microsoft.com/fwlink/?LinkId=115302).

## Recommended Maximum Kerberos Settings

The maximum recommended size for a Kerberos ticket is 48,000 bytes, which is configured through the MaxTokenSize REG_DWORD value in the registry (HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Lsa\Kerberos\Parameters) or through Group Policy, as described in KB article [938118](https://support.microsoft.com/kb/938118).

>[!NOTE]
>The maximum allowed value of MaxTokenSize is 65,535 bytes. If you are using Kerberos for IPSEC key management, the limit of 65,536 bytes. However, because of HTTP’s base64 encoding of authentication context tokens, we do not recommend that you set the maxTokenSize registry entry to a value larger than 48,000 bytes. Starting with Windows Server 2012, the default value of the MaxTokenSize registry entry is 48,000 bytes.

For additional information about Kerberos tickets, including error conditions that can occur when Kerberos ticket size limits are set too low or too high, see Additional Resources for Troubleshooting Kerberos (https://go.microsoft.com/fwlink/?LinkId=134740).

## Maximum number of non-linked attribute values

The Active Directory database stores non-linked attribute values in a linked directory that has to fit on a database page. This results in a maximum limit of non-linked attribute values of approximately 1300 entries for an object that carries only this attribute. In real-world deployments, errors begin to occur when reaching approximately 1200 attribute values.

The status code is 0x00000b and maps to error "LDAP_ADMIN_LIMIT_EXCEEDED Administration limit on the server has exceeded."

The limit is discussed in the [AD database details article](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc772829(v=ws.10)#maximum-database-record-size).

For example, this limit might be reached when there are [many DNS records on a single DNS name](https://learn.microsoft.com/en-us/troubleshoot/windows-server/identity/problems-with-dc-ad-integrated-dns-zones). That’s the case when an Active Directory domain has many DCs.

This article describes the problem when it happens during replication:

[Active Directory replication error 8304: "The maximum size on an object has been exceeded"](https://learn.microsoft.com/en-us/troubleshoot/windows-server/identity/active-directory-replication-error-8304)

## Maximum size of Active Directory objects

To change an attribute with a lot of data, the new and old values must be stored in the database transaction. That allows to roll back the transaction if the database is closed in the middle of the transaction. The maximum size of a transaction limits the total blob size of attribute value data to approximately 5 MB.

The limit of the maximum number of group members prior to link-value replication and to the maximum number of transactions in group membership changes actually exist because of the maximum size of an AD transaction you can have.

Instances of this limit being reached occur with DFS volumes prior to Windows Server 2008. In versions prior to Window Server 2008, all DFS volume meta-data was stored in a single attribute “PKT” for the volume. When this attribute is updated, the total size of the transaction sometimes exceeds the database limit, causing the update to fail.

Starting with Windows Server 2008, DFS-N added version 2 namespaces where each DFS target is stored in a separate Active Directory object, thus avoiding this limit.

For more information about DFS v1 volumes, see [How DFS Works](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc782417(v=ws.10)), section “Characteristics of Namespace Types”.


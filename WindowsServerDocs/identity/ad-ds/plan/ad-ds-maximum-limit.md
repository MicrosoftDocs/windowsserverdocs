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

A partial workaround to the RID limit is creating an additional domain for holding accounts, then migrating accounts to that new domain. However, you must create this account and any required trust relationships before you reach the limit. 


A partial work-around to this limitation is to create an additional domain to hold accounts and then migrate accounts to the new domain. However, you must create a trust relationship to migrate accounts in advance of reaching the limit. Creating a trust requires the creation of a security principal, which is also known as a trust user account. For more information about this limit, see articles [316201](https://go.microsoft.com/fwlink/?LinkID=115211) and [305475](https://go.microsoft.com/fwlink/?LinkId=115212) in the Microsoft Knowledge Base.

>[!NOTE]
>The Active Directory database does not set limits on the number of objects in a container, such as organizational units (OUs). You might experience limits when you work with multiple thousands of objects. These limits are configured to help provide a certain level of application or service availability. For example, the Active Directory Users and Computers snap-in is configured by default to display a maximum of 2,000 objects per container. You can adjust this value by using the Filter Options settings on the View menu. There are also adjustable Lightweight Directory Access Protocol (LDAP) policies that are set by default to improve domain controller performance. These policies are described in article [315071](https://go.microsoft.com/fwlink/?LinkID=135481).

## Maximum Number of entries in Discretionary and Security Access Control Lists

The limitation for the number of entries in a discretionary access control list (DACL) or a security access control list (SACL) of an Active Directory object using the ntSecurityDescriptor attribute comes from a limitation in the size of the access control list (ACL), which is 64K. Since access control entries (ACEs) vary in size, the actual number of entries (SIDs) is approximately 1,820. For additional details, see [How Security Descriptors and Access Control Lists Work](https://go.microsoft.com/fwlink/?LinkId=214683).

## Group Memberships for Security Principals

Security principals (that is, user, group, and computer accounts) can be members of a maximum of approximately 1,015 groups. This limitation is due to the size limit for the access token that is created for each security principal. The limitation is not affected by how the groups may or may not be nested. For more information, see article 328889 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkID=115213). For a detailed discussion of access token limitations, see Addressing Problems Due to Access Token Limitation (https://go.microsoft.com/fwlink/?LinkId=146571).

For more information about how a domain controller creates the data structure that is used for authorization decisions, see:

[MS-PAC]: Privilege Attribute Certificate Data Structure (https://msdn.microsoft.com/en-us/library/cc237917(PROT.13).aspx)

3.3.5.3.2 Initial Population of the PAC (https://msdn.microsoft.com/en-us/library/cc233956(PROT.13).aspx)

3.3.5.4.3 Domain Local Group Membership (https://msdn.microsoft.com/en-us/library/cc233950(PROT.13).aspx)

## FQDN Length Limitations

Fully qualified domain names (FQDNs) in Active Directory cannot exceed 64 characters in total length, including hyphens and periods (.). For example, the following host name has 65 characters; therefore, it is not valid in an Active Directory domain:

server10.branch-15.southaz.westernregion.northamerica.contoso.com

This is an important limitation to keep in mind when you name domains. This limitation is due to the MAX_PATH length of 260 characters that the Win32 application programming interfaces (APIs) define, in combination with the way in which Group Policy objects (GPOs) are stored in the SYSVOL share. For more information, see article 245809 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkID=115219). For more information about naming limitations, see article 909264 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkID=106629).

## File Name and Path Length Limitations

The physical files that Active Directory components use, such as SYSVOL, database (NTDS.DIT), and log file paths, are constrained by the MAX_PATH length of 260 characters, as defined by the Win32 APIs. When you are determining where to place your SYSVOL and database files during Active Directory installation, avoid nested folder structures that make the full file path to the SYSVOL folder, database, and log files longer than 260 characters. For more information, see article 245809 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=115219).

## Additional Name Length Limitations

There are additional limitations regarding name lengths in Active Directory. The following limits are described in article 909264 in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkID=106629):

NetBIOS computer and domain names are limited to 15 characters.

Domain Name System (DNS) host names are limited to 24 characters.

OU names are limited to 64 characters.

## Name Length Limits from the Schema

Default limits on attribute names for Active Directory objects that are imposed by the schema include the following. These items provide examples of schema-limited name attributes:

Display names are limited to 256 characters. For more information, see Display-Name Attribute (https://go.microsoft.com/fwlink/?LinkId=153705).

Common names are limited to 64 characters. For more information, see Common-Name Attribute (https://go.microsoft.com/fwlink/?LinkId=153706).

The SAM-Account-Name attribute (also known as the pre–Windows 2000 user logon name) is limited to 256 characters in the schema. However, for the purpose of backward compatibility the limit is 20 characters. For more information, see SAM-Account-Name Attribute (https://go.microsoft.com/fwlink/?LinkId=153707).

## Name Length Limitations for LDAP Simple Bind Operations

During binds to the directory, simple LDAP bind operations limit the distinguished name (also known as DN) of the user to 255 total characters. If you attempt a simple LDAP bind with more than 255 characters, you might experience authentication errors, such as the following:

```text
Error <49>: ldap_simple_bind_s() failed: Invalid Credentials
Server error: 80090308: LdapErr: DSID-0C0903AA, comment: AcceptSecurityContext error, data 57, v1771
Error 0x80090308 The token supplied to the function is invalid
```

You can avoid this issue by ensuring that the applications, scripts, and utilities that attempt to bind to your directory use secure LDAP binds. You can also avoid this issue by reducing the depth of the OU structure or the length of the OU names. For example, the following distinguished name is 261 characters:

```text
CN=BobKelly,OU=CorporateVicePresidents,OU=CorporateOfficers,OU=ViewOfPugetSoundOffices,OU=TopFloor,OU=Building1557,OU=CorporateCampus,OU=Redmond,OU=Washington,OU=NorthWestern,OU=UnitedStatesOfAmerica,OU=NorthAmerica,DC=BusinessGroup,DC=humongousinsurance,DC=com
```

If the OU named CorporateVicePresidents is shortened to CVP, the distinguished name for the user account BobKelly is only 242 characters.

## Maximum Number of GPOs Applied

There is a limit of 999 Group Policy objects (GPOs) that you can apply to a user account or computer account. This does not mean that the total number of policy settings on the system is limited to 999. Rather, a single user or computer will not be able to process more than 999 GPOs. This limit exists for performance reasons.

## Trust Limitations

Trust limitations arise from the number of trusted domain objects (TDOs), the length of trust paths, and the ability of clients to discover available trusts. Limitations that apply include the following:

- Kerberos clients can traverse a maximum of 10 trust links to locate a requested resource in another domain. If the trust path between the domains exceeds this limit, the attempt to access the domain fails.

- When a client searches out a trust path, the search is limited to the trusts that are established directly with a domain and the trusts that are transitive within a forest.

- Previous testing shows that the increased time to complete TDO-related operations, such as authentication across domains, deteriorates performance noticeably if the Active Directory implementation in an organization contains more than 2,400 TDOs.

For more information about trust limitations, see “Practical Limitations of Trusts” in How Domain and Forest Trusts Work (https://go.microsoft.com/fwlink/?LinkID=35356).

## Maximum Number of Accounts per LDAP Transaction

When you write scripts or applications that perform LDAP transactions, the recommended limit is to perform no more than 5,000 operations per LDAP transaction. An LDAP transaction is a group of directory operations (such as add, delete, and modify) that are treated as one unit. If your script or application performs more than 5,000 operations in a single LDAP transaction, you are at risk of running into resource limits and an operational time-out. If that happens, all the operations (changes, additions, and modifications) in the transaction are rolled back, which means that you lose all those changes.

As an example, if you are using Active Directory Service Interfaces (ADSI) to write a script, the SetInfo method completes a transaction. For more information about ADSI Methods, see Active Directory Service Interfaces (https://go.microsoft.com/fwlink/?LinkID=4487).

As another example, when you use the System.DirectoryServices (S.DS) namespace in the Microsoft .NET Framework, the DirectoryEntry.CommitChanges method completes an LDAP transaction. For more information about the DirectoryEntry.CommitChanges method, see DirectoryEntry.CommitChanges () (https://go.microsoft.com/fwlink/?LinkId=115220).

>[!NOTE]
>Regardless of the method that you use for LDAP transactions, you should plan to send less than 5,000 directory operations in a single transaction. To learn more about the LDAP data structure that commits changes, see LDAPMod (https://go.microsoft.com/fwlink/?LinkId=115221).

## Recommended Maximum Number of Users in a Group

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


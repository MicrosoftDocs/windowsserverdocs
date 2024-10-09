---
title: Get started with Group Managed Service Accounts
description: Learn how to enable and use Group Managed Service Accounts (gMSA) in Windows Server.
ms.topic: article
ms.assetid: 7130ad73-9688-4f64-aca1-46a9187a46cf
ms.author: wscontent
author: robinharwood
ms.date: 08/26/2024
---

# Get started with Group Managed Service Accounts

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

In this article, learn how to enable and use Group Managed Service Accounts (gMSA) in Windows Server.

Authentication protocols supporting mutual authentication such as Kerberos can't be used unless all the instances of the services use the same principal. For example, when a client computer connects to a service that uses load balancing or another method where all the servers appear to be the same service to the client. Meaning each service has to use the same passwords or keys to prove their identity. Group Managed Service Accounts are a type of account that can be used with multiple servers. A gMSA is a domain account that can be used to run services on multiple servers without having to manage the password. The gMSA provides automatic password management and simplified service principal name (SPN) management, including delegation of management to other administrators.

> [!NOTE]
> Failover clusters don't support gMSAs. However, services that run on top of the Cluster service can use a gMSA or a sMSA if they are a Windows service, an App pool, a scheduled task, or natively support gMSA or sMSA.

Services can choose the principal to use. Each principal type supports different services and has different limitations.

|Principals|Services supported|Password management|
|-------|-----------|------------|
|Computer Account of Windows system|Limited to one domain joined server|Computer manages|
|Computer Account without Windows system|Any domain joined server|None|
|Virtual Account|Limited to one server|Computer manages|
|Windows standalone Managed Service Account|Limited to one domain joined server|Computer manages|
|User Account|Any domain joined server|None|
|Group Managed Service Account|Any Windows Server domain-joined server|The domain controller manages, and the host retrieves|

A Windows computer account, a Windows standalone Managed Service Account (sMSA), or virtual accounts can't be shared across multiple systems. When you use virtual accounts, the identity is also local to the machine and not recognized by the domain. If you configure one account for services on server farms to share, you would have to choose a user account or a computer account apart from a Windows system. Either way, these accounts don't have the capability of single-point-of-control password management. Without password management, each organization needs to update keys for the service in Active Directory and distribute these keys to all instances of those services.

With Windows Server, services and service administrators don't need to manage password synchronization between service instances when using gMSA. You create the gMSA in Active Directory and then configure the service that supports Managed Service Accounts. Use of the gMSA is scoped to any machine that is able to use LDAP to retrieve the gMSA's credentials. You can create a gMSA using the `New-ADServiceAccount` cmdlets that are part of the Active Directory module. The following services support the service identity configuration on the host.

- Same APIs as sMSA, so products that support sMSA support gMSA

- Services that use Service Control Manager to configure logon identity

- Services that use the IIS manager for application pools to configure identity

- Tasks using Task Scheduler.

## Prerequisites

The following table lists the operating system requirements for Kerberos authentication to work with services using gMSA. The Active Directory requirements are listed after the table.

A 64-bit architecture is required to run the Windows PowerShell commands used to administer gMSA.

### Operating system

| Element                                 | Requirement                                                            |
|-----------------------------------------|------------------------------------------------------------------------|
| Client Application host                 | RFC compliant Kerberos client                                          |
| User account's domain DCs               | RFC compliant KDC                                                      |
| Shared service member hosts             |                                                                        |
| Member host's domain DCs                | RFC compliant KDC                                                      |
| gMSA account's domain DCs               | Windows Server 2012 or later DCs available for host to retrieve the password   |
| Backend service host                    | RFC compliant Kerberos application server                              |
| Backend service account's domain DCs    | RFC compliant KDC                                                      |
| Windows PowerShell for Active Directory | The Active Directory Domain Services Remote Server Administrator Tools |

### Active Directory Domain Services

Group Managed Service Accounts have the following requirements in Active Directory Domain Services (AD DS).

- The Active Directory domain and forest functional level must be Windows Server 2012 or later. To learn more about updating the schema, see [How to raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).

- If you're managing the service host permission to use gMSA by group, then new or existing security group.

- If managing service access control by group, then new or existing security group.

- The Key Distribution Services (KDS) root key for Active Directory must be created in the domain. The result of its creation can be verified in the KdsSvc Operational log, `Event ID 4004`. To learn more about creating the KDS (*kdssvc.dll*) root key, see [Create the Key Distribution Services KDS Root Key](create-the-key-distribution-services-kds-root-key.md).

## Deploy a new server farm

The process of creating and managing a server farm using the gMSA feature typically involves the following tasks.

- Deploying a new server farm

- Adding member hosts to an existing server farm

- Decommissioning member hosts from an existing server farm

- Decommissioning an existing server farm

- Removing a compromised member host from a server farm if necessary

When the service administrator deploys a new server farm, they need to determine the following information.

- The service supports using gMSAs

- The service requires inbound or outbound authenticated connections

- The computer account names for the member hosts for the service using the gMSA

- The NetBIOS name for the service

- The DNS host name for the service

- The Service Principal Names (SPNs) for the service

- The password change interval (default is 30 days)

### Create Group Managed Service Accounts

You can create a gMSA only if the forest schema is Windows Server 2012 or later. You must also deploy the KDS root key for Active Directory, and have at least one Windows Server 2012 or later domain controller in the domain where you want to create a gMSA.

> [!IMPORTANT]
> gMSA account names must be unique within a forest level and not just a domain. Attempting to create a gMSA account with a duplicate name will fail, even in different domains.

Membership in *Domain Admins* or the ability to create `msDS-GroupManagedServiceAccount` objects, is the minimum required to complete the following procedures.

To create a gMSA using PowerShell, follow these steps.

1. On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1. At the command prompt for the Windows PowerShell, type the following commands, and then press ENTER. (The Active Directory module loads automatically.)

   `New-ADServiceAccount [-Name] <string> -DNSHostName <string> [-KerberosEncryptionType <ADKerberosEncryptionType>] [-ManagedPasswordIntervalInDays <Nullable[Int32]>] [-PrincipalsAllowedToRetrieveManagedPassword <ADPrincipal[]>] [-SamAccountName <string>] [-ServicePrincipalNames <string[]>]`

   > [!NOTE]
   > A value for the `-Name` parameter is always required (whether you specify `-Name` or not), with `-DNSHostName`, `-RestrictToSingleComputer`, and `-RestrictToOutboundAuthentication` being secondary requirements for the three deployment scenarios.

   |Parameter|String|Example|
   |-------|-----|------|
   |Name|Name of the account|ITFarm1|
   |DNSHostName|DNS host name of service|ITFarm1.contoso.com|
   |KerberosEncryptionType|Any encryption types supported by the host servers|None, RC4, AES128, AES256|
   |ManagedPasswordIntervalInDays|Password change interval in days (default is 30 days if not provided)|90|
   |PrincipalsAllowedToRetrieveManagedPassword|The computer accounts of the member hosts or the security group that the member hosts are a member of|ITFarmHosts|
   |SamAccountName|NetBIOS name for the service if not same as Name|ITFarm1|
   |ServicePrincipalNames|Service Principal Names (SPNs) for the service|http/ITFarm1.contoso.com/contoso.com, http/ITFarm1.contoso.com/contoso, http/ITFarm1/contoso.com, http/ITFarm1/contoso, MSSQLSvc/ITFarm1.contoso.com:1433, MSSQLSvc/ITFarm1.contoso.com:INST01|

   > [!IMPORTANT]
   > The password change interval can only be set during creation. If you need to change the interval, you must create a new gMSA and set it at creation time.

   For example, use the following command to create a new gMSA called `ITFarm1` for the group. The gMSA allows the service to use the Kerberos encryption types RC4, AES128, and AES256. The service is allowed to use the SPNs `http/ITFarm1.contoso.com/contoso.com`, `http/ITFarm1.contoso.com/contoso`, `http/ITFarm1/contoso.com`, and `http/ITFarm1/contoso`.

   Enter the command on a single line, even though they might appear word-wrapped across several lines here because of formatting constraints.

   ```Powershell
    New-ADServiceAccount ITFarm1 -DNSHostName ITFarm1.contoso.com -PrincipalsAllowedToRetrieveManagedPassword ITFarmHosts$ -KerberosEncryptionType RC4, AES128, AES256 -ServicePrincipalNames http/ITFarm1.contoso.com/contoso.com, http/ITFarm1.contoso.com/contoso, http/ITFarm1/contoso.com, http/ITFarm1/contoso
   ```

Membership in *Domain Admins*, *Account Operators*, or ability to create `msDS-GroupManagedServiceAccount` objects, is the minimum required to complete this procedure. For detailed information about using the appropriate accounts and group memberships, see [Active Directory security groups](../../../manage/understand-security-groups.md).

To create a gMSA for outbound authentication only using PowerShell, follow the steps.

1. On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1. At the command prompt for the Windows PowerShell Active Directory module, use the following command.

   `New-ADServiceAccount [-Name] <string> -RestrictToOutboundAuthenticationOnly [-ManagedPasswordIntervalInDays <Nullable[Int32]>] [-PrincipalsAllowedToRetrieveManagedPassword <ADPrincipal[]>]`

   The example creates a gMSA using the parameters in the following table.

   |Parameter|String|Example|
   |-------|-----|------|
   |Name|Name the account|ITFarm1|
   |ManagedPasswordIntervalInDays|Password change interval in days (default is 30 days if not provided)|75|
   |PrincipalsAllowedToRetrieveManagedPassword|The computer accounts of the member hosts or the security group that the member hosts are a member of|ITFarmHosts|

   > [!IMPORTANT]
   > The password change interval can only be set during creation. If you need to change the interval, you must create a new gMSA and set it at creation time.

   The example command uses these parameters as follows.

   ```PowerShell
   New-ADServiceAccount ITFarm1 -RestrictToOutboundAuthenticationOnly - PrincipalsAllowedToRetrieveManagedPassword ITFarmHosts$
   ```

## Configure service identity application service

To configure the services in Windows Server, see the following articles:

- [Application Pool Identities](/iis/manage/configuring-security/application-pool-identities)

- [Windows Services](/windows/win32/services/services)

- [Task Scheduler for developers](/windows/win32/taskschd/task-scheduler-start-page)

Other services could support gMSA. See the appropriate product documentation for details on how to configure those services.

## Add member hosts to an existing server farm

If using security groups for managing member hosts, add the computer account for the new member host to the security group (that the gMSA's member hosts are a member of) using one of the following methods.

Membership in *Domain Admins*, or the ability to add members to the security group object, is the minimum required to complete these procedures.

- Method 1: Active Directory Users and Computers

    To use the Active Directory Users and Computers snap-in, see [Add a computer account to a group](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733097(v=ws.11)) and [Manage Different Domains in Active Directory Administrative Center](../../../get-started/adac/Advanced-AD-DS-Management-Using-Active-Directory-Administrative-Center--Level-200-.md#manage-different-domains-in-active-directory-administrative-center).

- Method 2: `dsmod`

    To use the command line, see [Add a computer account to a group](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733097(v=ws.11)).

- Method 3: Windows PowerShell Active Directory cmdlet `Add-ADPrincipalGroupMembership`

    To use PowerShell, see [Add-ADPrincipalGroupMembership](/powershell/module/activedirectory/add-adprincipalgroupmembership).

If using computer accounts, find the existing accounts and then add the new computer account.

Membership in *Domain Admins*, *Account Operators*, or ability to manage `msDS-GroupManagedServiceAccount` objects, is the minimum required to complete this procedure. For detailed information about using the appropriate accounts and group memberships, see Local and Domain Default Groups.

### Add member hosts using PowerShell

1. On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1. At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

    `Get-ADServiceAccount [-Identity] <string> -Properties PrincipalsAllowedToRetrieveManagedPassword`

1. At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

    `Set-ADServiceAccount [-Identity] <string> -PrincipalsAllowedToRetrieveManagedPassword <ADPrincipal[]>`

The following example adds a member to a server farm using the parameters in the table.

|Parameter|String|Example|
|-------|-----|------|
|Name|Name the account|ITFarm1|
|PrincipalsAllowedToRetrieveManagedPassword|The computer accounts of the member hosts or the security group that the member hosts are a member of|Host1, Host2, Host3|

The following example gets the current members of the farm `ITFarm1`.

```PowerShell
Get-ADServiceAccount [-Identity] ITFarm1 -Properties PrincipalsAllowedToRetrieveManagedPassword
```

The following example adds member hosts to an existing server farm `ITFarm1`.

```PowerShell
Set-ADServiceAccount [-Identity] ITFarm1 -PrincipalsAllowedToRetrieveManagedPassword Host1$,Host2$,Host3$
```

## Update the gMSA properties

Membership in *Domain Admins*, *Account Operators*, or the ability to write to msDS-GroupManagedServiceAccount objects, is the minimum required to complete these procedures.

Open the Active Directory Module for Windows PowerShell, and set any property by using the `Set-ADServiceAccount` cmdlet.

For detailed information how to set these properties, see [Set-ADServiceAccount](/powershell/module/activedirectory/set-adserviceaccount) in the TechNet Library or by typing `Get-Help Set-ADServiceAccount` at the Active Directory module for Windows PowerShell command prompt and pressing ENTER.

## Remove member hosts from an existing server farm

Membership in *Domain Admins*, or ability to remove members from the security group object, is the minimum required to complete these procedures.

If using security groups for managing member hosts, remove the computer account for the decommissioned member host from the security group that the gMSA's member hosts are a member of by using either of the following methods.

- Method 1: Active Directory Users and Computers

    To use the Active Directory Users and Computers snap-in, see [Delete a Computer Account](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754624(v=ws.11)) and [Manage Different Domains in Active Directory Administrative Center](../../../get-started/adac/Advanced-AD-DS-Management-Using-Active-Directory-Administrative-Center--Level-200-.md#manage-different-domains-in-active-directory-administrative-center).

- Method 2: `drsm`

    To use the command line, see [Delete a Computer Account](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754624(v=ws.11)).

- Method 3: Windows PowerShell Active Directory cmdlet `Remove-ADPrincipalGroupMembership`

    To use PowerShell, see  [Remove-ADPrincipalGroupMembership](/powershell/module/activedirectory/remove-adprincipalgroupmembership) in the TechNet Library, or type `Get-Help Remove-ADPrincipalGroupMembership` in the Active Directory module for Windows PowerShell command prompt and press ENTER.

If listing computer accounts, retrieve the existing accounts and then add all but the removed computer account.

Membership in *Domain Admins*, *Account Operators*, or ability to manage `msDS-GroupManagedServiceAccount` objects, is the minimum required to complete this procedure. For detailed information about using the appropriate accounts and group memberships, see Local and Domain Default Groups.

### Remove member hosts using PowerShell

1. On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1. At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

   `Get-ADServiceAccount [-Identity] <string> -Properties PrincipalsAllowedToRetrieveManagedPassword`

1. At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

   `Set-ADServiceAccount [-Identity] <string> -PrincipalsAllowedToRetrieveManagedPassword <ADPrincipal[]>`

The example removes a member to a server farm using the parameters in the following table.

|Parameter|String|Example|
|-------|-----|------|
|Name|Name the account|ITFarm1|
|PrincipalsAllowedToRetrieveManagedPassword|The computer accounts of the member hosts or the security group that the member hosts are a member of|Host1,  Host3|

The following example gets the current members of the farm `ITFarm1`.

```PowerShell
Get-ADServiceAccount [-Identity] ITFarm1 -Properties PrincipalsAllowedToRetrieveManagedPassword
```

The following example removes member hosts from an existing server farm `ITFarm1`.

```PowerShell
Set-ADServiceAccount [-Identity] ITFarm1 -PrincipalsAllowedToRetrieveManagedPassword Host1$,Host3$
```

### Remove gMSA from the system

Remove the cached gMSA credentials from the member host using `Uninstall-ADServiceAccount` or the `NetRemoveServiceAccount` API on the host system.

Membership in *Administrators*, or equivalent, is the minimum required to complete these procedures.

### Remove gMSA using PowerShell

1. On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1. At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

   `Uninstall-ADServiceAccount <ADServiceAccount>`

   The following example uninstalls an Active Directory managed service account from a computer.

   ```PowerShell
   Uninstall-ADServiceAccount ITFarm1
   ```

For more information about the `Uninstall-ADServiceAccount` cmdlet, at the Active Directory module for Windows PowerShell command prompt, type `Get-Help Uninstall-ADServiceAccount`, and then press ENTER, or see the information on the TechNet web at [Uninstall-ADServiceAccount](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617202(v=technet.10)).

## Related content

- [Group Managed Service Accounts Overview](group-managed-service-accounts-overview.md)

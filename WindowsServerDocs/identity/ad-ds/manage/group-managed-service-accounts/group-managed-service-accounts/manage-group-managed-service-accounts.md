---
title: Manage Group Managed Service Accounts
description: Learn how to manage and use Group Managed Service Accounts (gMSA) in Windows Server.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 07/01/2025
---

# Manage group Managed Service Accounts

In this article, learn how to enable and use group Managed Service Accounts (gMSA) in Windows Server.

Authentication protocols supporting mutual authentication such as Kerberos can't be used unless all the instances of the services use the same principal. For example, when a client computer connects to a service that uses load balancing or another method where all the servers appear to be the same service to the client. Meaning each service has to use the same passwords or keys to prove their identity. Group Managed Service Accounts are a type of account that can be used with multiple servers. A gMSA is a domain account that can be used to run services on multiple servers without having to manage the password. The gMSA provides automatic password management and simplified service principal name (SPN) management, including delegation of management to other administrators.

> [!NOTE]
> Failover clusters don't support gMSAs. However, services that run on top of the Cluster service can use a gMSA or a sMSA if they're a Windows service, an App pool, a scheduled task, or natively support gMSA or sMSA.

Services can choose the principal to use. Each principal type supports different services and has different limitations.

| Principals | Services supported | Password management |
|--|--|--|
| Computer Account of Windows system | Limited to one domain joined server | Computer manages |
| Computer Account without Windows system | Any domain joined server | None |
| Virtual Account | Limited to one server| Computer manages |
| Windows standalone Managed Service Account | Limited to one domain joined server | Computer manages|
| User Account|Any domain joined server | None |
| Group Managed Service Account | Any Windows Server domain-joined server | The domain controller manages, and the host retrieves |

A Windows computer account, a Windows standalone Managed Service Account (sMSA), or virtual accounts can't be shared across multiple systems. When you use virtual accounts, the identity is also local to the machine and not recognized by the domain. If you configure one account for services on server farms to share, you would have to choose a user account or a computer account apart from a Windows system. Either way, these accounts don't have the capability of single-point-of-control password management. Without password management, each organization needs to update keys for the service in Active Directory (AD) and distribute these keys to all instances of those services.

With Windows Server, services and service administrators don't need to manage password synchronization between service instances when using gMSA. You create the gMSA in AD and then configure the service that supports Managed Service Accounts. Use of the gMSA is scoped to any machine that is able to use the Lightweight Directory Access Protocol (LDAP) to retrieve the gMSA's credentials. You can create a gMSA using the `New-ADServiceAccount` cmdlets that are part of the AD module. The following services support the service identity configuration on the host.

- Same APIs as sMSA, so products that support sMSA support gMSA

- Services that use [Service Control Manager](/windows/win32/services/services) to configure logon identity

- Services that use the Internet Information Services (IIS) manager for [application pools](/iis/manage/configuring-security/application-pool-identities) to configure identity

- Tasks using [Task Scheduler](/windows/win32/taskschd/task-scheduler-start-page).

## Prerequisites

To manage gMSAs, your device must meet the following requirements:

- Your device must have the **Active Directory Domain Services** (AD DS) role installed. To learn more, see [Add or remove roles and features in Windows Server](/windows-server/administration/server-manager/add-remove-roles-features).

- You must be a member of the **Domain Admins** or **Enterprise Admins** group.

- Both the domain and forest functional levels should be set to Windows Server 2012 or later to support gMSA features for all devices. To learn more about updating the schema, see [Raise domain and forest functional levels in Active Directory Domain Services](/windows-server/identity/ad-ds/plan/raise-domain-forest-functional-levels).

- A Key Distribution Services (KDS) root key must be created in the domain for secure password management. Verify its creation using the KdsSvc Operational log (Event ID 4004). To learn more about creating the KDS (kdssvc.dll) root key, see [Create the Key Distribution Services KDS Root Key](create-the-key-distribution-services-kds-root-key.md).

> [!TIP]
> To control which hosts or services can use a gMSA, add their computer accounts to a designated security group (either new or existing) and assign the necessary permissions to this group. Likewise, use a security group to manage access for services running under gMSAs, ensuring the group has all required permissions for service operation and resource access.

For Kerberos authentication to work with services using gMSAs, the following are required:

- Ensure that the SPNs are correctly registered for each service using a gMSA. This allows Kerberos to identify and authenticate the service.

- Ensure DNS records are set up correctly for name resolution, which Kerberos relies on for locating domain services.

- Ensure that firewalls and network policies allow Kerberos traffic and necessary service communications.

- For the Kerberos ticket lifetime settings, configure the ticket expiration and renewal policies in line with your security and operational requirements.

- All systems involved in the authentication process must have synchronized clocks. Kerberos is sensitive to time configuration, and discrepancies can cause authentication failures.

If you're managing AD from a computer that isn't a domain controller, install the Remote Server Administration Tools (RSAT) to access the necessary management features. RSAT provides the AD module for PowerShell. After installing RSAT, open PowerShell as an administrator and run `Import-Module ActiveDirectory` to enable AD management cmdlets. This allows administrators to manage AD remotely and securely, minimizing the load on domain controllers.

### Create a gMSA

To create a gMSA using PowerShell, follow these steps in an elevated PowerShell window:

> [!IMPORTANT]
> gMSA account names must be unique within a forest level and not just a domain. Attempting to create a gMSA account with a duplicate name fails, even in different domains.

1. Create the KDS Root Key, if one doesn't exist, by following the guidance in [Create the Key Distribution Services KDS Root Key](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/create-the-key-distribution-services-kds-root-key). If a key already exists, skip this step.

1. To create a gMSA, run the following command. Replace `<gMSAName>` with your desired gMSA name and `<domain>` with your domain's name. Replace `<SecurityGroup>` with the name of the security group or computer accounts that should have access to retrieve the gMSA's password.

   ```powershell
   New-ADServiceAccount -Name <gMSAName> -DNSHostName <gMSAName>.<domain> -PrincipalsAllowedToRetrieveManagedPassword <SecurityGroup>
   ```

   To create a gMSA for outbound authentication only, run the following command. Replace `<Days>` with a numerical value. If a value isn't provided, it defaults to `30` days.

   ```powershell
   New-ADServiceAccount -Name <gMSAName> -DNSHostName <gMSAName>.<domain> -RestrictToOutboundAuthenticationOnly -ManagedPasswordIntervalInDays <Days> -PrincipalsAllowedToRetrieveManagedPassword <SecurityGroup>
   ```

   > [!IMPORTANT]
   > The password change interval can only be set during creation. If you need to change the interval, you must create a new gMSA and set it at creation time.

1. Run the following command to verify see if the target device has access to retrieve the gMSA password.

   ```powershell
   Test-ADServiceAccount -Identity <gMSAName>
   ```

Membership in the appropriate security group or having the necessary delegated permissions to create `msDS-GroupManagedServiceAccount` objects is required to complete this procedure. While members of **Account Operators** can manage certain user and group objects in AD, they don't have default rights to create gMSAs unless those permissions are delegated to them. For detailed information about using the appropriate accounts and group memberships, see [Active Directory security groups](../../../manage/understand-security-groups.md).

You can also update the gMSA properties using the `Set-ADServiceAccount` cmdlet. For example, to update the computers display name, run the following command replacing `<gMSAName>` and `<NewDisplayName>` with your values:

```powershell
Set-ADServiceAccount -Identity "<gMSAName>" -DisplayName "<NewDisplayName>"
```

For detailed information on how to set other properties for the gMSA, see [Set-ADServiceAccount](/powershell/module/activedirectory/set-adserviceaccount#examples).

## Verify changes to a gMSA

After making changes to a gMSA, you can verify if the gMSA is updated correctly. These changes include adding, removing, and uninstalling a gMSA. You can also perform this step at any time when updates are made to the gMSA properties.

Run the following command replacing `<gMSAName>` with the name of the gMSA you created:

```powershell
Get-ADServiceAccount -Identity "<gMSAName>" | Select-Object *
```

## Add member hosts to a security group

> [!NOTE]
>
> - **Group-centric management** (`Add-ADGroupMember` / `Remove-ADGroupMember`): Use these cmdlets when you want to manage the membership of a specific group. They're best suited for adding or removing multiple users, computers, or other objects to or from a single group efficiently.
>
> - **Principal-centric management** (`Add-ADPrincipalGroupMembership` / `Remove-ADPrincipalGroupMembership`): Choose these cmdlets when your goal is to manage a specific user or computer's membership across multiple groups. They allow you to add or remove a principal from several groups in a single operation, making it easier to update group affiliations for individual accounts.

If you use security groups to manage member hosts, add the computer account for the new member host to the security group that contains the gMSA's member hosts. You can do this using one of the following methods:

# [ADUC](#tab/aduc)

To use the Active Directory Users and Computers (ADUC) snap-in, see [Add a computer account to a group](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733097(v=ws.11)) and [Manage User Accounts in Active Directory Users and Computers](/windows-server/identity/ad-ds/manage-user-accounts-in-windows-server).

# [CMD](#tab/cmd)

To use the `dsmod group` command line tool, see [Dsmod group](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc732423(v=ws.11)) and [Use the Directory Service command-line tools to manage Active Directory objects](/troubleshoot/windows-server/active-directory/directory-service-manage-objects).

# [PowerShell](#tab/powershell)

Open an elevated PowerShell window and follow these steps.

Run the following command to add a device to a security group. Replace `<ComputerName>` and `<SecurityGroup>` with your values.

```powershell
Add-ADPrincipalGroupMembership -Identity <ComputerName> -MemberOf <SecurityGroup>
```

To learn more about these cmdlets, see [Add-ADPrincipalGroupMembership](/powershell/module/activedirectory/add-adprincipalgroupmembership) and [Add-ADGroupMember](/powershell/module/activedirectory/add-adgroupmember).

Alternatively, you can run the following commands.

1. To add a single device to a security group, run this command replacing `<SecurityGroupName>` and `<ComputerName>` with your values:

   ```powershell
   $securityGroup = "SecurityGroupName"
   $computerName = "ComputerName"

   $params = @{
      Identity = $securityGroup
      Members  = $computerName
   }
   Add-ADGroupMember @params
   ```

1. To add multiple devices to a security group, run this command replacing `<SecurityGroupName>` and `<Computer#>` with your values:

   ```powershell
   $securityGroup = "SecurityGroupName"
   $computerNames = @("Computer1", "Computer2", "Computer3")

   foreach ($computers in $computerNames) {
   $params = @{
      Identity = $securityGroup
      Members  = $computers
    }
   Add-ADGroupMember @params
   }
   ```

---

If using computer accounts, find the existing accounts and then add the new computer account.

## Remove member hosts from a security group

# [ADUC](#tab/aduc)

To use the ADUC snap-in, see [Delete a Computer Account](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754624(v=ws.11)) and [Remove a user account](/windows-server/identity/ad-ds/manage-user-accounts-in-windows-server#remove-a-user-account).

# [CMD](#tab/cmd)

To use the `dsrm` command line tool, see [Delete a user account](/troubleshoot/windows-server/active-directory/directory-service-manage-objects#delete-a-user-account) and the [Dsrm](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731865(v=ws.11)) command reference.

# [PowerShell](#tab/powershell)

Open an elevated PowerShell window and follow these steps.

Run the following command to remove a device from a security group. Replace `<ComputerName>` and `<SecurityGroup>` with your values.

```powershell
Remove-ADPrincipalGroupMembership -Identity <ComputerName> -MemberOf <SecurityGroup> -Confirm:$false
```

To learn more about these cmdlets, see [Remove-ADPrincipalGroupMembership](/powershell/module/activedirectory/remove-adprincipalgroupmembership) and [Remove-ADGroupMember](/powershell/module/activedirectory/remove-adgroupmember).

Alternatively, you can run the following commands.

1. To remove a single device from a security group, run this command replacing `<SecurityGroupName>` and `<ComputerName>` with your values:

   ```powershell
   $securityGroup = "SecurityGroupName"
   $computerName = "ComputerName"

   $params = @{
      Identity = $securityGroup
      Members  = $computerName
   }
   Remove-ADGroupMember @params -Confirm:$false
   ```

1. To remove multiple devices from a security group, run this command replacing `<SecurityGroupName>` and `<Computer#>` with your values:

   ```powershell
   $securityGroup = "SecurityGroupName"
   $computerNames = @("Computer1", "Computer2", "Computer3")

   foreach ($computers in $computerNames) {
   $params = @{
      Identity = $securityGroup
      Members  = $computers
    }
   Remove-ADGroupMember @params -Confirm:$false
   }
   ```

---

## Uninstall a gMSA from your system

While you can't uninstall gMSAs in ADUC, you can manually delete a gMSA by finding it in the **Managed Service Accounts** container and deleting it like any other AD object. However, keep in mind that this doesn't perform the same clean-up operations that `Uninstall-ADServiceAccount` would in PowerShell.

To uninstall a gMSA, open an elevated PowerShell window and follow these steps.

1. To remove a single gMSA from your environment, run the following command replacing `<gMSAName>` with your value:

   ```powershell
   Uninstall-ADServiceAccount -Identity <gMSAName>
   ```

1. To remove multiple gMSAs from your environment, run the following command replacing `<gMSA#$>` with your values:

   ```powershell
   $gMSANames = @("gMSA1$", "gMSA2$", "gMSA3$")

   foreach ($gMSAs in $gMSANames) {
     Uninstall-ADServiceAccount -Identity $gMSAs
   }
   ```

For more information about the `Uninstall-ADServiceAccount` cmdlet, see  [Uninstall-ADServiceAccount](/powershell/module/activedirectory/uninstall-adserviceaccount).

## See also

- [Group Managed Service Accounts overview](group-managed-service-accounts-overview.md)


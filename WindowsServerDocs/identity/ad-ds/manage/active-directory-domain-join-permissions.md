---
title: Active Directory domain join permissions in Windows Server
description: This article describes the permissions required in Active Directory to successfully join computers to a Windows Server domain using a new computer account or an existing account.
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
ms.date: 08/26/2025
---

# Active Directory domain join permissions

This article describes the permissions required in Active Directory (AD) for successful domain join operations. Domain join is the process of adding a computer to an AD domain, enabling centralized management and authentication. The permissions required for domain join depend on whether you're *creating a new computer account* or *reusing an existing account*. Proper configuration of these permissions is essential for security and operational efficiency, as misconfigured permissions can lead to failed domain joins or introduce security risks. The following sections provide guidance for the given scenarios, including recommended practices and troubleshooting tips.

## Scenario 1: Permissions for creating computer accounts

This scenario applies when users join their own computers to the domain without prior provisioning of computer accounts. During domain join, if the computer account with the name you're joining doesn't exist in AD, the system creates it using an [Ldap_Add()](/windows/win32/api/winldap/nf-winldap-ldap_add) operation, performed with the provided user credentials. To learn more, see [NetJoinDomain function (lmjoin.h)](/windows/win32/api/lmjoin/nf-lmjoin-netjoindomain). The user joining the computer must either have the **Add workstations to domain** user right (also known as `SeMachineAccountPrivilege`, managed by `Ms-Ds-Machine-Account-Quota`), or permission to create computer objects in the organizational unit (OU) or container where the account is created. Because of the vulnerabilities described in [Add workstations to domain](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/add-workstations-to-domain), Microsoft doesn't recommend using this option.

When a computer account already exists in AD, and a different user needs to join the computer to the domain using that account, the process typically involves a delegated administrator (or service account) that pre-provisions computer accounts. This setup enables another user to perform the domain join by reusing the existing account. Lets say **Admin01** creates the computer account and **Admin02** performs the join. In this example, **Admin01** must be delegated the **Create Computer Accounts** permission using *Create Child* [ACTRL_DS_CREATE_CHILD](/windows/win32/SecAuthZ/directory-services-access-rights) on the relevant OU or container.

> [!IMPORTANT]
> Delegate with care, and ensure appropriate security protections and monitoring are in place. See [KB5008383 - Active Directory permissions updates (CVE-2021-42291)](https://support.microsoft.com/topic/kb5008383-active-directory-permissions-updates-cve-2021-42291-536d5555-ffba-4248-a60e-d6cbc849cde1) for details.

## Scenario 2: Reusing computer accounts during domain join

A more common scenario involves domain joining a device with a precreated computer account. For example, **Admin01** at `contoso.com` has the **Create Computer Account** permissions on `OU=Workstations,DC=Contoso,DC=com`. **Admin01** creates a computer account in the Workstations OU called **NewPC1** and **Admin02** needs to join this computer to the domain during the build process. In cases where troubleshooting is necessary, such as when **Admin03** needs to unjoin and rejoin a computer, the preexisting account eases this process. When an account with the name **NewPC1$** exists in AD, an [Ldap_modify()](/windows/win32/api/winldap/nf-winldap-ldap_modify) operation is executed using the credentials of the user handling the join, like \<<Admin02@contoso.com>>.

When you perform the [offline domain join](/windows-server/remote/remote-access/directaccess/directaccess-offline-domain-join) process (`djoin /requestODJ`), the join doesn't require any permissions on the computer account in AD. This method is recommended because it minimizes required AD privileges and reduces potential issues.

When you reuse an existing computer account for domain join, the following attributes might be updated on the computer object as needed:

- `SamAccountName` - If the name is being changed
- `DnsHostName` - If not already set
- `ServicePrincipalName` - If not already set
- `UserAccountControl` - Enable if account is disabled
- `UnicodePwd`

To successfully reuse an existing computer account during domain join, ensure the following permissions are assigned:

- **Trusted Ownership:** The computer account owner (Admin01) must be a member of the Administrators group, either directly or through nested group membership. Alternatively, the user performing the domain join (Admin01) must be the account owner. If [KB5020276 - Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8) is installed, the owner (Admin01) or a group that includes *Admin01* must be listed as a trusted owner in the `ComputerAccountReuseAllowlist` Group Policy Object (GPO) as described in the KB.

  For example, the *Security Descriptor* of the precreated computer account would be something like this:

  ```
  Security Descriptor:SD Revision: 1
  SD Control:  0x8c04
    SE_DACL_PRESENT
    SE_DACL_AUTO_INHERITED
    SE_SACL_AUTO_INHERITED
    SE_SELF_RELATIVE
  Owner: MyDomain\Admin1 [S-1-5-21-832151497-3956308952-1069003339-1103]
  Group: MyDomain\Domain Users [S-1-5-21-832151497-3956308952-1069003339-513]
  ```

- **Modify permissions:** To successfully join a computer to the domain using an existing account, *Admin02* must have at least the following permissions on the computer object:

  - Read

    - Read all properties

    - List contents

  - Allowed to authenticate

  - Change password

  - Reset password

  - Validated write to DNS host name

  - Validated write to service principal name

  - Write account restrictions (for updating `UserAccountControl`)

In addition, if it's required to rename the machine, Admin02 also needs the following permissions:

- Write computername (pre-Windows 2000)

- Write displayname

- Write description

## Permission configuration

The recommended approach for granting **Admin02** the necessary permissions to reuse a computer account is to assign them during the initial creation of the account in **Active Directory Users and Computers**. This ensures that all required permissions are set correctly from the start, streamlining future domain join operations. This approach however isn't practical in most enterprise scenarios. To learn more, see [Directory Services Access Rights](/windows/win32/SecAuthZ/directory-services-access-rights).

If you need to assign permissions manually or through automation, ensure the following are the minimum permissions granted:

1. **Read**

   ```
   Ace[1]
     Ace Type:  0x0 - ACCESS_ALLOWED_ACE_TYPE
     Ace Size:  36 bytes
     Ace Flags: 0x0
     Ace Mask:  0x00020014
                READ_CONTROL
                ACTRL_DS_LIST
                ACTRL_DS_READ_PROP
     Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Allowed to authenticate**

   ```
   Ace[2]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000100
                       ACTRL_DS_CONTROL_ACCESS
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  Allowed to Authenticate - 68b1d179-0d15-4d4f-ab71-46152e79a7bc
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Validated write to DNS host name**

   ```
   Ace[3]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000008
                       ACTRL_DS_SELF
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  Validated write to DNS host name - 72e39547-7b18-11d1-adef-00c04fd8d5cd
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Validated write to service principal name**

   ```
   Ace[4]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000008
                       ACTRL_DS_SELF
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  servicePrincipalName - f3a64788-5306-11d1-a9c5-0000f80367c1
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Write account restrictions**

   ```
   Ace[5]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000020
                       ACTRL_DS_WRITE_PROP
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  Account Restrictions - 4c164200-20c0-11d0-a768-00aa006e0529
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Reset password**

   ```
   Ace[6]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000100
                       ACTRL_DS_CONTROL_ACCESS
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  Reset Password - 00299570-246d-11d0-a768-00aa006e0529
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Change password**

   ```
   Ace[7]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  56 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000100
                       ACTRL_DS_CONTROL_ACCESS
     Object Ace Flags: 0x1
                       ACE_OBJECT_TYPE_PRESENT
     Object Ace Type:  Change Password - ab721a53-1e2f-11d0-9819-00aa0040529b
     Object Ace Sid:   MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

For the **Rename computer account** permission, ensure the following are granted:

1. **Write description**

   ```
   Ace[1]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  72 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000020
                       ACTRL_DS_WRITE_PROP
     Object Ace Flags: 0x3
                       ACE_OBJECT_TYPE_PRESENT
                       ACE_INHERITED_OBJECT_TYPE_PRESENT
     Object Ace Type:       description - bf967950-0de6-11d0-a285-00aa003049e2
     Inherited object type: computer - bf967a86-0de6-11d0-a285-00aa003049e2
     Object Ace Sid:        MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Write display name**

   ```
   Ace[2]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  72 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000020
                       ACTRL_DS_WRITE_PROP
     Object Ace Flags: 0x3
                       ACE_OBJECT_TYPE_PRESENT
                       ACE_INHERITED_OBJECT_TYPE_PRESENT
     Object Ace Type:       displayName - bf967953-0de6-11d0-a285-00aa003049e2
     Inherited object type: computer - bf967a86-0de6-11d0-a285-00aa003049e2
     Object Ace Sid:        MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

1. **Write samAccountName**

   ```
   Ace[3]
     Ace Type:  0x5 - ACCESS_ALLOWED_OBJECT_ACE_TYPE
     Ace Size:  72 bytes
     Ace Flags: 0x0
     Object Ace Mask:  0x00000020
                       ACTRL_DS_WRITE_PROP
     Object Ace Flags: 0x3
                       ACE_OBJECT_TYPE_PRESENT
                       ACE_INHERITED_OBJECT_TYPE_PRESENT
     Object Ace Type:       sAMAccountName - 3e0abfd0-126a-11d0-a060-00aa006c33ed
     Inherited object type: computer - bf967a86-0de6-11d0-a285-00aa003049e2
     Object Ace Sid:        MyDomain\Admin02 [S-1-5-21-832151497-3956308952-1069003339-1104]
   ```

## Troubleshooting permissions

If the required permissions aren't configured, domain join operations that reuse computer accounts might fail after installing the October 11, 2022 or later Windows cumulative updates. The following error message typically indicates the failure:

```error
Error 0xaac (2732): NERR_AccountReuseBlockedByPolicy: "An account with the same name exists in Active Directory. Re-using the account was blocked by security policy."
```

Navigate to **C:\Windows\debug\netsetup.log** and check if the following error is present:

```error
unicodePwd = Account exists, resetting password: <ThePassword>
NetpModifyComputerObjectInDs: Attribute values to set:
userAccountControl = 0x1000
DnsHostName = NewPC1.MyDomain.com
ServicePrincipalName = HOST/NewPC1.MyDomain.com  RestrictedKrbHost/NewPC1.MyDomain.com  HOST/NEWPC1  RestrictedKrbHost/NEWPC1
03/10/2023 14:20:29:369
unicodePwd = <ThePassword>
NetpMapGetLdapExtendedError: Parsed [0x2098] from server extended error string: 00002098: SecErr: DSID-031514A0, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0
NetpModifyComputerObjectInDs: ldap_modify_s failed: 0x32 0x5
```

If present, this error indicates that:

- The required permissions are missing or are incorrectly configured
- The user has insufficient access rights

Review this document to ensure all mentioned necessary permissions are assigned to the user or group performing the domain join to prevent this issue.


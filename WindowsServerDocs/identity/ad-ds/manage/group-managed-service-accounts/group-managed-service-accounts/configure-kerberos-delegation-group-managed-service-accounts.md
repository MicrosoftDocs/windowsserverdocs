---
title: Configuring Kerberos Delegation for Group Managed Service Accounts
description: Explains how to configure Kerberos delegation for group Managed Service Accounts.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 07/09/2025
ms.custom: sfi-image-nochange
---

# Configuring Kerberos delegation for group Managed Service Accounts

Normally, when you work with Kerberos delegation, you set the service principal name (SPN) either with a setspn.exe command or manually by using the attribute editor in Active Directory Users and Computers. Additionally, enabling **View** > **Advanced features** in Active Directory Users and Computers adds another way to configure Kerberos delegation from the **Delegation** tab of a user or a computer account.

But for standalone and group Managed Service Accounts, the **Delegation** tab doesn't appear, even after you add SPNs to these accounts or enable **View** > **Advanced features**.

To configure delegation for these special accounts, you need to set the correct attributes manually.
There are two attributes that you need to modify for these accounts:

- userAccountControl defines the type of delegation.
- msDS-AllowedToDelegateTo defines where the SPNs for delegation will be added.

You can set these attributes in two ways:

- Use PowerShell.
- Manually update the userAccountControl value.

## Use PowerShell commands

The more secure and convenient way is to use PowerShell commands to update those attributes. You don't need to calculate final userAccountControl values when using PowerShell. Here are the commands to enable different types of delegation:

- **Don't trust this computer for delegation**

  ```powershell
  Set-ADAccountControl -Identity TestgMSA$ -TrustedForDelegation $false -TrustedToAuthForDelegation $false
  Set-ADServiceAccount -Identity TestgMSA$ -Clear 'msDS-AllowedToDelegateTo'
  ```

- **Unconstrained delegation / Trust this computer for delegation to any service**

  ```powershell
  Set-ADAccountControl -Identity TestgMSA$ -TrustedForDelegation $true -TrustedToAuthForDelegation $false
  Set-ADServiceAccount -Identity TestgMSA$ -Clear 'msDS-AllowedToDelegateTo'
  ```

- **Kerberos-constrained delegation / Trust this computer for delegation to specified services only (Use Kerberos only)**

  ```powershell
  Set-ADAccountControl -Identity TestgMSA$ -TrustedForDelegation $false -TrustedToAuthForDelegation $false
  ```

  Update the Backend Service SPNs in msDS-AllowedToDelegateTo attribute.

- **Kerberos-constrained delegation with protocol transition / Trust this computer for delegation to specified services only (Use any authentication protocol)**

  ```powershell
  Set-ADAccountControl -Identity TestgMSA$ -TrustedForDelegation $false -TrustedToAuthForDelegation $true
  ```

  Update the Backend Service SPNs in msDS-AllowedToDelegateTo attribute.

## Manually update the userAccountControl value

Some of the easiest ways to modify attributes are by enabling **View** > **Advanced features** in Active Directory Users and Computers or by using ADSIEdit.msc.

Here are the userAccountControl values that can be added for different types of delegation. Be careful when you edit this attribute value. Ensure that only the TRUSTED_FOR_DELEGATION or TRUSTED_TO_AUTH_FOR_DELEGATION flag is added, and that other properties aren't changed. Also, ensure that both the flags aren't added together in the userAccountControl value on a Managed Service Account.

| Delegation type | Property flag | Value in hexadecimal | Value in decimal |
|------------------|---------------|----------------------|------------------|
| Unconstrained delegation / Trust this computer for delegation to any service | TRUSTED_FOR_DELEGATION | 0x80000 | 524288 |
| Kerberos-constrained delegation / Trust this computer for delegation to specified services only (Use Kerberos only) | No change | No change | No change |
 Kerberos-constrained delegation with protocol transition / Trust this computer for delegation to specified services only (Use any authentication protocol) | TRUSTED_TO_AUTH_FOR_DELEGATION | 0x1000000 | 16777216 |

When you manually update the userAccountControl value, make sure the new value is added with the existing value and doesn't replace the existing value.
For example, say the current value of UAC is 4096 (hexadecimal 0x1000), which is WORKSTATION_TRUST_ACCOUNT:

![Screenshot that shows a userAccountControl value of 4096.](media/user-account-control-4096.png)

To enable **Unconstrained delegation (Not secure)**, you must add the userAccountControl value for TRUSTED_FOR_DELEGATION together with the existing value.
The UAC value should become 0x81000 (0x1000 + 0x80000), which means WORKSTATION_TRUST_ACCOUNT and TRUSTED_FOR_DELEGATION.

![Screenshot that shows a userAccountControl value of 81000.](media/user-account-control-81000.png)

If you add SPNs by mistake or want to remove SPNs from the delegation list of the account, you can manually edit the **msDS-AllowedToDelegateTo** attribute of the account. This method is applicable for any user or computer account.

![Screenshot that shows the msDS-AllowedToDelegateTo attribute in the Multi-valued String Editor.](media/allowed-to-delegate.png)

## Related content

- [Group Managed Service Accounts Overview](group-managed-service-accounts-overview.md)
- [Manage Group Managed Service Accounts](manage-group-managed-service-accounts.md)



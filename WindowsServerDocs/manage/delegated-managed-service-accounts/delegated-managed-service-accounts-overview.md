---
title: Delegated Managed Service Accounts overview in Windows Server Insider Preview
description: Learn about Delegated Managed Service Accounts (DMSA) that authenticate specific machine identities mapped in Active Directory (AD) along with Credential Guard (CG) to ensure device credentials isolation in Windows Server Insiders Preview.
ms.topic: conceptual
ms.author: alalve
author: mariamgewida
ms.date: 11/28/2023
---

# Delegated Managed Service Accounts overview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

A new account type known as delegated Managed Service Account (dMSA) is introduced in Windows Server Insiders Preview that is used to harden overall usage of Service Accounts (SA) within Active Directory (AD). Authentication for dMSA is linked to the device, which means that only specified machine identities mapped in AD can access the account. In addition to dMSA, Credential Guard (CG) can be used for machine accounts, which isn't supported with standard SAs or group Managed Service Accounts (gMSA). By enabling CG, dMSAs can be retrieved by requesting a ticket that is key-bound to Virtualization-based Security (VBS) ensuring that device credentials are always isolated and unknown by the user. Using dMSA also prevents:

- Harvesting credentials using a compromised account that utilizes common techniques (kerberoasting)
- Escalating privileges to other compromised accounts
- Gaining access to other service-related resources through lateral movement

dMSA utilizes gMSA concepts to limit scope of usage using CG to bind machine authentication. dMSA uses automatic rotating passwords that bind all SA tickets to CG and disables legacy accounts to provide more security.

## Functionality of dMSA

dMSA allows users to create them as a standalone account, or to replace an existing standard SA. When a dMSA supersedes an existing account, authentication to that existing account and its credentials fails. The request is redirected to the [Local Security Authority](/windows/win32/secauthn/lsa-authentication) (LSA) to authenticate using dMSA, which has access to everything the previous account could access in AD.

dMSA supports a list of machine identities that are allowed to request tickets for the dMSA. The machine’s secret is used to authenticate to get tickets to the dMSA and the list is known as **msDS-groupMSAMembership** in the dMSA.

dMSA uses a symmetric secret (derived from the machine account credential) that is held by the Domain Controller (DC) to encrypt tickets. The secret can be further protected by enabling CG. While the secrets used by dMSA are updated periodically on an epoch like a gMSA, the key difference is that dMSA's secret can't be retrieved or found anywhere other than on the DC.

## Account attributes for dMSA

This section describes how the attributes for dMSA changes in the AD schema. These attributes can be viewed using the **Active Directory Users and Computers** snap-in or running **ADSI Edit** on the DC. The following changes occur for security descriptors and SAs:

**Starting a dMSA migration** (attribute is set to **1**)

- The SA is granted _Generic Read_ to all properties on the dMSA
- The SA is granted _Write_ property to **msDS-groupMSAMembership**
- **msDS-DelegatedMSAState** is changed to 1
- **msDS-ManagedAccountPrecededByLink** is set to the SA
- **msDS-SupersededAccountState** is changed to 1
- **msDS-SupersededManagedServiceAccountLink** is set to the dMSA

**Completing a dMSA migration** (attribute is set to **2**)

- The SA is removed from _Generic Read_ to all properties on the dMSA
- The SA is removed from _Write_ property on the **msDS-GroupMSAMembership** attribute
- **msDS-DelegatedMSAState** is set to 2
- The Service Principal Names (SPN) are copied over from the SA to the dMSA account
- **msDS-AllowedToDelegateTo** is copied over if applicable
- **msDS-AllowedToActOnBehalfOfOtherIdentity** the security descriptor is copied over if applicable
- The assigned AuthN policy, **msDS-AssignedAuthnPolicy**, of the SA are copied over
- dMSA is added to any AuthN policy silos that the SA was a member of
- The trusted "Auth for Delegation" User Account Control (UAC) bit is copied over if it was set on the SA
- **msDS-SupersededServiceAccountState** is set to 2
- The SA is disabled via the UAC disable bit
- The SPN are removed from the account

## Migration considerations for dMSA

Take note of the following when migrating dMSAs:

- Wait at least two ticket lifetimes (equivalent to 14 days) after modifying the Security Descriptor (SD) before completing the dMSA migration. Keeping a service in the **start** state for four ticket lifetimes (28 days) is recommended. Delay the migration if your DCs are partitioned or replication is broken during onboarding.
- Pay attention to sites where replication delays are longer than the default ticket renewal time of **10 hours**. The **groupMSAMembership** attribute is checked and updated at every ticket renewal, and every time the original SA logs on during the “start migration” state, which adds the machine account to the **groupMSAMembership** of the dMSA.
  - Example, two sites utilize the same SA and each replication cycle takes more than 10 hours per ticket lifetime. In this scenario, a group membership is lost during the initial replication cycles.
- Migration requires access to a Read-Write Domain Controller (RWDC) to query and modify the SD.
- Unconstrained delegation stops working once the migration is complete if the old SA was using it. If you're using a dMSA protected by CG, unconstrained delegation stops working. To learn more, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

## See also

[Setting up Delegated Managed Service Accounts](delegated-managed-service-accounts-setting-up-dmsa.md)

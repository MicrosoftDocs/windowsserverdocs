---
title: Delegated Managed Service Accounts overview in Windows Server Insider Preview
description: Learn about Delegated Managed Service Accounts (DMSA) that authenticate specific machine identities mapped in Active Directory (AD) along with Credential Guard (CG) to ensure device credentials isolation in Windows Server Insiders Preview.
ms.topic: conceptual
ms.author: alalve
author: mariamgewida
ms.date: 01/09/2024
---

# Delegated Managed Service Accounts overview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

A new account type known as delegated Managed Service Account (dMSA) is introduced in Windows Server Insiders Preview that is used to harden overall usage of service accounts within Active Directory (AD). Authentication for dMSA is linked to the device identity, which means that only specified machine identities mapped in AD can access the account. In addition, dMSA can work with Credential Guard (CG), which ensures that device credentials are always isolated and unknown by the user. Using dMSA also prevents harvesting credentials using a compromised account (kerberoasting), which is a common issue with traditional service accounts.

## dMSA and gMSA comparison

dMSAs and gMSAs are two types of managed service accounts that are used to run services and applications in Windows Server. A dMSA is managed by an administrator and is used to run a service or application on a specific server. A gMSA is managed by AD and is used to run a service or application on multiple servers. Both offer improved security and simplified password management. dMSA differs by:

- Utilizing gMSA concepts to limit scope of usage using CG to bind machine authentication.
- dMSA uses automatic rotating passwords that bind all service account tickets to CG and disables legacy accounts to provide more security.
- Although gMSAs are secured with machine generate and auto-rotated passwords, the passwords are still not machine bound and can be stolen.

## Functionality of dMSA

dMSA allows users to create them as a standalone account, or to replace an existing standard service accounts. When a dMSA supersedes an existing account, authentication to that existing account using its password will be blocked. The request is redirected to the [Local Security Authority](/windows/win32/secauthn/lsa-authentication) (LSA) to authenticate using dMSA, which has access to everything the previous account could access in AD.

During migration, dMSA can automatically learn the devices on which the service account will be used. This is then used to move from all existing service accounts.

dMSA uses a randomized secret (derived from the machine account credential) that is held by the Domain Controller (DC) to encrypt tickets. The secret can be further protected by enabling CG. While the secrets used by dMSA are updated periodically on an epoch like a gMSA, the key difference is that dMSA's secret can't be retrieved or found anywhere other than on the DC.

## Account attributes for dMSA

This section describes how the attributes for dMSA changes in the AD schema. These attributes can be viewed using the **Active Directory Users and Computers** snap-in or running **ADSI Edit** on the DC. The following changes occur for security descriptors and service accounts:

**Starting a dMSA migration** (attribute is set to **1**)

- The service account is granted _Generic Read_ to all properties on the dMSA
- The service account is granted _Write_ property to **msDS-groupMSAMembership**
- **msDS-DelegatedMSAState** is changed to 1
- **msDS-ManagedAccountPrecededByLink** is set to the service account
- **msDS-SupersededAccountState** is changed to 1
- **msDS-SupersededManagedServiceAccountLink** is set to the dMSA

**Completing a dMSA migration** (attribute is set to **2**)

- The service account is removed from _Generic Read_ to all properties on the dMSA
- The service account is removed from _Write_ property on the **msDS-GroupMSAMembership** attribute
- **msDS-DelegatedMSAState** is set to 2
- The Service Principal Names (SPN) are copied over from the service account to the dMSA account
- **msDS-AllowedToDelegateTo** is copied over if applicable
- **msDS-AllowedToActOnBehalfOfOtherIdentity** the security descriptor is copied over if applicable
- The assigned AuthN policy, **msDS-AssignedAuthnPolicy**, of the service account are copied over
- dMSA is added to any AuthN policy silos that the service account was a member of
- The trusted "Auth for Delegation" User Account Control (UAC) bit is copied over if it was set on the service account
- **msDS-SupersededServiceAccountState** is set to 2
- The service account is disabled via the UAC disable bit
- The SPN are removed from the account

## Migration considerations for dMSA

Take note of the following when migrating dMSAs:

- Wait at least two ticket lifetimes (equivalent to 14 days) after modifying the Security Descriptor (SD) before completing the dMSA migration. Keeping a service in the **start** state for four ticket lifetimes (28 days) is recommended. Delay the migration if your DCs are partitioned or replication is broken during onboarding.
- Pay attention to sites where replication delays are longer than the default ticket renewal time of **10 hours**. The **groupMSAMembership** attribute is checked and updated at every ticket renewal, and every time the original service account logs on during the “start migration” state, which adds the machine account to the **groupMSAMembership** of the dMSA.
  - Example, two sites utilize the same service account and each replication cycle takes more than 10 hours per ticket lifetime. In this scenario, a group membership is lost during the initial replication cycles.
- Migration requires access to a Read-Write Domain Controller (RWDC) to query and modify the SD.
- Unconstrained delegation stops working once the migration is complete if the old service account was using it. If you're using a dMSA protected by CG, unconstrained delegation stops working. To learn more, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

## See also

[Setting up Delegated Managed Service Accounts](delegated-managed-service-accounts-setting-up-dmsa.md)

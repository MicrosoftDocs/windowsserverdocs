---
title: Audit Authentication Policy Change
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a1940c4-ed19-4bb1-bbde-3174fc052be5
---
# Audit Authentication Policy Change
This topic for the IT professional describes this Advanced Security Audit policy setting, **Audit Authentication Policy Change**, which determines whether the operating system generates audit events when changes are made to authentication policy.

Changes made to authentication policy include:

-   Creation, modification, and removal of forest and domain trusts.

-   Changes to Kerberos policy under **Computer Configuration\Windows Settings\Security Settings\Account Policies\Kerberos Policy**.

    > [!NOTE]
    > The audit event is logged when the policy is applied, not when settings are modified by the administrator.

-   When any of the following user rights is granted to a user or group:

    -   **Access this computer from the network**

    -   **Allow logon locally**

    -   **Allow logon through Remote Desktop**

    -   **Logon as a batch job**

    -   **Logon as a service**

-   Namespace collision, such as when an added trust collides with an existing namespace name.

This setting is useful for tracking changes in domain-level and forest-level trust and privileges that are granted to user accounts or groups.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4713|Kerberos policy was changed.|
|4716|Trusted domain information was modified.|
|4717|System security access was granted to an account.|
|4718|System security access was removed from an account.|
|4739|Domain Policy was changed.|
|4864|A namespace collision was detected.|
|4865|A trusted forest information entry was added.|
|4866|A trusted forest information entry was removed.|
|4867|A trusted forest information entry was modified.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)



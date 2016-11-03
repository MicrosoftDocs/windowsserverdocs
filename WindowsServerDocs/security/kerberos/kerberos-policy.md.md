---
title: Kerberos Policy
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-kerberos
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce233e70-3146-4b4c-a58a-4d90e740d755
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Kerberos Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Kerberos Policy settings and provides links to policy setting descriptions.

The Kerberos version??5 authentication protocol provides the default mechanism for authentication services and the authorization data necessary for a user to access a resource and perform a task on that resource. By reducing the lifetime of Kerberos tickets, you reduce the risk of a legitimate user's credentials being stolen and successfully used by an attacker. However, this also increases the authorization overhead. In most environments, these settings should not need to be changed.

These policy settings are located in *GPO\_name***\\Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Kerberos Policy** and can be set on a domain controller.

For information about setting security policies, see [How to Configure Security Policy Settings](../group-managed-service-accounts/how-to-configure-security-policy-settings.md).

The following topics provide a discussion of implementation and best practices considerations, policy location, default values for the server type or GPO, relevant differences in operating system versions, security considerations \(including the possible settings vulnerabilities of each setting\), countermeasures you can take, and the potential impact for each setting.

-   [Enforce user logon restrictions](../group-managed-service-accounts/kerberos-policy/enforce-user-logon-restrictions.md)

    This policy setting determines whether the Kerberos??V5 Key Distribution Center \(KDC\) validates every request for a session ticket against the user rights policy of the user account.

-   [Maximum lifetime for service ticket](../group-managed-service-accounts/kerberos-policy/maximum-lifetime-for-service-ticket.md)

    This policy setting determines the maximum number of minutes that a granted session ticket can be used to access a particular service.

-   [Maximum lifetime for user ticket](../group-managed-service-accounts/kerberos-policy/maximum-lifetime-for-user-ticket.md)

    This policy setting determines the maximum amount of time \(in hours\) that a user???s ticket\-granting ticket can be used.

-   [Maximum lifetime for user ticket renewal](../group-managed-service-accounts/kerberos-policy/maximum-lifetime-for-user-ticket-renewal.md)

    This policy setting determines the period of time \(in days\) during which a user???s ticket\-granting ticket can be renewed.

-   [Maximum tolerance for computer clock synchronization](../group-managed-service-accounts/kerberos-policy/maximum-tolerance-for-computer-clock-synchronization.md)

    This policy setting determines the maximum time difference \(in minutes\) that the Kerberos??V5 protocol tolerates between the time on the client clock and the time on the domain controller that provides Kerberos authentication.



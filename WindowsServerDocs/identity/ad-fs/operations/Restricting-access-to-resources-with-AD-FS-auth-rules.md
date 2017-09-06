---
title: Restricting access to resources with AD FS 2012 R2 authorization rules
description: The following document describes how to restrict access to auth rules.
author: anandy
ms.author: billmath
manager: femila
ms.date: 09/06/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Restricting access to resources with AD FS 2012 R2 authorization rules

>Applies To: Windows Server 2012 R2

To ensure the right people are accessing your resources under the right conditions, it is preferred to use [Azure AD Conditional Access](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access). If you cannot use Azure AD Conditional Access to protect your resources, AD FS Authorization and Authentication rules can be used to achieve required restriction on access to the resources. This article provides common rules for common authorization scenarios and explains how the rules in each of the scenarios are evaluated.

## Blocking access to users from extranet
One of the common asks is to block access from extranet for a particular relying party. We can utilize the **x-ms-proxy** and **x-ms-forwarded-client-ip** claims to achieve the required result.


    exists([Type == "http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"]) &&
    NOT exists([Type == "http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"<customer-provided public ip address regex>"])
    => issue(Type = "http://schemas.microsoft.com/authorization/claims/deny", Value = "true"); 

You can break-up the rule into following parts:

    exists([Type == "http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"])

This ensures that the request is coming via WAP

    NOT exists([Type == "http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"customer-provided public ip address regex"])

This ensures that even if the request is coming from WAP, the client IP does not belong to the set of IP address represented by regex which indicates the corpnet IPs. This part is essential for proxy forwarding scenarios (non-modern auth).

If both the above condition holds true, we issue a deny.

## Require MFA for all authentications from extranet
Often blocking complete extranet access is not practical and you may require higher authentication level for accessing a particular relying party. We can use **insidecorporatenetwork** and **authnmethodsreferences** claims to enforce MFA for access to the particular relying party from extranet.

    not exists([Type == 
    "http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork",
    Value=="true"]) && exists([Type ==
    "http://schemas.microsoft.com/claims/authnmethodsreferences", Value ==
    "http://schemas.microsoft.com/claims/multipleauthn"])=>issue(Type =
    "http://schemas.microsoft.com/authorization/claims/permit", Value = "true");

In this rule, we are checking if the claim **insidecorporatenetwork** is absent – indicating the authentication is coming from the extranet and combine it with check for **authnmethodsreferences** to see if MFA has been performed to finally issue a permit for the access.

To enforce the MFA for authentication from the extranet you will need to modify the additional authentication rules as below:

    not exists([Type ==
    "http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork",
    Value=="true"])=>issue(Type =
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod",
    Value = "http://schemas.microsoft.com/claims/multipleauthn");

> [!NOTE]
> Use the PowerShell cmdlet **Set-AdfsRelyingPartyTrust -AdditionalAuthenticationRules** to set the additional authentication rules.

## Allow access from certain IP ranges only
In certain high security scenarios it may be required that an access to a particular resource is provided from only a certain range of IP addresses that you trust. In the below authorization rule, we restrict access to the resource to users who are accessing it from IP range '192.168.2.0 - 192.168.2.50' or '192.168.1.1/24'

    exists([Type ==
    "http://schemas.microsoft.com/2014/09/requestcontext/claims/userip",
    Value=" (^192\.168\.2\.([0-9]|[1-4][0-9]|50)$)|(^192\.168\.1\.([1-9]|[1-9][0-9]|1([0-9][0-9])|2([0-4][0-9]|5[0-5]))$)"])=>issue(Type =
    "http://schemas.microsoft.com/authorization/claims/permit", Value = "true");

This is a very simple rule where the regex lists out the range of IP addresses from where access is allowed and then issue a permit if the user’s IP address in the **userip** claim falls in the ranges mentioned.

## Block access to non-compliant devices except for certain group of users
You may want to restrict access to users only from compliant devices. At the same time, you may have to exempt certain users from the restriction. 

    exists([Type ==
    "http://schemas.microsoft.com/2014/09/devicecontext/claims/iscompliant", Value
    == "true"]) && not exists([Type ==
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "^(
    ?i)(S-1-5-21-793117618-3574985686-2748956956-512|S-1-5-21-793117618-3574985686-2
    748956956-519)$"])=>issue(Type =
    "http://schemas.microsoft.com/authorization/claims/permit", Value = "true");

The rule can be broken down into 2 parts:
    
    exists([Type ==
    "http://schemas.microsoft.com/2014/09/devicecontext/claims/iscompliant", Value
    == "true"])

This ensures that the device from where the user is trying to access the resource is compliant.

    not exists([Type ==
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "^(
    ?i)(S-1-5-21-793117618-3574985686-2748956956-512|S-1-5-21-793117618-3574985686-2
    748956956-519)$"])
This part implements the exemption for the group(s) that are exempt from the restriction to access the resource from a compliant device.

## Next Steps
- Learn more about [The Role of Claims](../technical-reference/The-Role-of-Claims.md)
- Learn more about the [Claim Rule language](../technical-reference/The-Role-of-the-Claim-Rule-Language.md)

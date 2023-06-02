---
description: "FAQ for migrating from AD FS to Azure AD"
title: AD FS to Azure AD FAQ
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 02/28/2023
ms.topic: article
---



# Active Directory Federation Server to Azure AD FAQ

Azure AD provides a simple cloud-based sign-in experience to all your resources and apps with strong authentication and real-time, risk-based adaptive access policies to grant access to resources reducing operational costs of managing and maintaining an AD FS environment and increasing IT efficiency.

For more info on **why** you should upgrade from AD FS to Azure AD, visit [moving from AD FS to Azure AD](https://aka.ms/adfs2aad). See [migrate from federation to cloud authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) to understand **how** to upgrade from AD FS.

## General questions

This document will provide you with answers to frequently asked questions with migrating from AD FS to Azure Active Directory.  

**Can I run AD FS side by side with Password Hash Sync or Pass Through Authentication?**

Yes you can. This is quite common. Using staged rollout can help you validate a subset of your users are able to authenticate to Azure AD directly while the domain remains federated. This document [Migrate from federation to cloud authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) will walk you through the process.

**When accessing sites through AD FS internally users get a single-sign on experience. How do we keep the same experience when moving to Azure AD?**

There are a few ways. The first and recommend way is to [hybrid Azure AD join](/azure/active-directory/devices/concept-azure-ad-join-hybrid) your existing Windows 10/11 domain joined machines or use Azure AD join. This will provide you with the same seamless signle-sign on experience. The second way would be to leverage [seamless single-sign on](/azure/active-directory/hybrid/how-to-connect-sso-how-it-works) for non hybrid Azure AD joined machines or downlevel Windows clients can still get that same experience.

**I’m registering Hybrid Azure AD Joined (AADJ) devices using AD FS device claims. How do I allow devices to continue to complete their Hybrid AADJ process with AD FS?**

You can follow the [configure hybrid Azure AD join](/azure/active-directory/devices/howto-hybrid-azure-ad-join#managed-domains) process for devices to complete the registration process without AD FS.  

**I have authorization rules in AD FS. What are the equivalent way to do this in Azure AD?**

These would translate into [Azure AD Conditional Access policies](/azure/active-directory/conditional-access/overview). There are several pre-built [template](/azure/active-directory/conditional-access/concept-conditional-access-policy-common) policies to start with.

**When putting users into a staged rollout group are their current sessions impacted and forced to re-authenticate?**

No, their current session will remain valid and the next time they would need to authenticate they would authenticate using managed authentication instead of federation.

**I have a claims provider trust with another company to access resources? How should I move this trust relationship?**

You should look to take advantage of [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) to accomplish the same authentication access which has more capabilities.

**We have custom claim rules can Azure AD support these?**

Yes depending on the rules needed. The best place to investigate is to use [AD FS application activity report](/azure/active-directory/manage-apps/migrate-adfs-application-activity) and then see how to [customize SAML claims](/azure/active-directory/develop/active-directory-saml-claims-customization)

**When switching a domain from federated to managed how long does it take for the change to take place?**

It can take up to 4 hours to fully cutover so [plan your maintenance window accordingly](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication#plan-the-maintenance-window)

**Is AD FS required for using O365?** 

No, O365 uses Azure Active Directory as it's Identity Provider.   While customers may have chosen to federate their Azure Active Directory tenant to federated providers such as AD FS, as an option for hybrid scenarios, it is not required to use O365 or Azure services.   The majority of customers choose to use managed authentication for hybrid scenarios which does not use identity federation.

**Once I move the application configuration to Azure AD, is there anything else I have to do to complete the migration?**

Yes, the migration of an application to Azure AD isn’t complete until you have reconfigured the app itself (cutover) to use Azure AD as it's authentication provider.

**Is ADFS required so users can login with their Email Address or User Principal Name (UPN)?** 

No, Azure AD supports sign-in with an [Email Address](/azure/active-directory/authentication/howto-authentication-use-email-signin) or User Principal Name.



## Next Steps
- [AD FS decommission guide](adfs-decommission-guide.md)


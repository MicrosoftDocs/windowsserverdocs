---
description: "FAQ for migrationg from AD FS to Azure AD"
title: AD FS to Azure AD FAQ
author: billmath
ms.author: billmath
manager: 
ms.date: 02/03/2023
ms.topic: article
---



# Active Directory Federation Server to Azure AD FAQ

Azure AD provides a simple cloud-based sign-in experience to all your resources and apps with strong authentication and real-time, risk-based adaptive access policies to grant access to resources reducing operational costs of managing and maintaining an AD FS environment and increasing IT efficiency.

For more info on **why** you should upgrade from AD FS to Azure AD, visit [moving from AD FS to Azure AD](https://aka.ms/adfs2aad). See [migrate from federation to cloud authentication](https://learn.microsoft.com/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) to understand **how** to upgrade from AD FS.

This document will provide you with answers to frequently asked questions with migrating from ADFS to Azure Active Directory.  

1.) Can I run ADFS side by side with Password Hash Sync or Pass Through Authentication?

Yes you can. This is quite common. Using staged rollout can help you validate a subset of your users are able to authenticate to Azure AD directly while the domain remains federated. This document [Migrate from federation to cloud authentication](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) will walk you through the process.

2.) When accessing sites through ADFS interanlly users get a single-sign on expereince. How do we keep the same experience when moving to Azure AD?

There are a few ways. The first and recommend way is to [hybrid Azure AD join](https://learn.microsoft.com/en-us/azure/active-directory/devices/concept-azure-ad-join-hybrid) your existing Windows 10/11 domain joined machines or use Azure AD join. This will provide you with the same seamless signle-sign on experience. The second way would be to leverage [seamless sso](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-sso-how-it-works) for non hybrid azure ad joined machines or downlevel Windows clients can still get that same experience.

3.) I’m registering Hybrid AADJ devices using ADFS device claims. How do I allow devices to continue to complete their hybrid aadj process with ADFS?

You can follow the [configure hybrid azure ad join](https://learn.microsoft.com/en-us/azure/active-directory/devices/howto-hybrid-azure-ad-join#managed-domains) process for devices to complete the registration process without ADFS.  

4.) I have authorization rules in ADFS. What are the equivalent way to do this in Azure AD?

These would translate into [Azure AD Conditional Access policies](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview). There are several pre-built [template](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/concept-conditional-access-policy-common) policies to start with.

5.) When putting users into a staged rollout group are their current sessions impacted and forced to re-authenticate?

No, their current session will remain valid and the next time they would need to authenticate they would authenticate using mananged authentication instead of federation.

6.) I have a claims provider trust with another company to access resources? How should I move this trust relationship?

You should look to take advantage of [Azure AD B2B](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/what-is-b2b) to accomplish the same authentication access.

7.) We have custom claim rules can Azure AD support these?

Yes depending on the rules needed. The best place to investigate is to use [AD FS application activity report](https://learn.microsoft.com/en-us/azure/active-directory/manage-apps/migrate-adfs-application-activity) and then see how to [customize SAML claims](https://learn.microsoft.com/en-us/azure/active-directory/develop/active-directory-saml-claims-customization)

8.) When switching a domain from federated to managed how long does it take for the change to take place?

It can take up to 4 hours to fully cutover so [plan your maintneance window accordingly](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication#plan-the-maintenance-window)


## Next Steps
- [AD FS decommission guide](adfs-decommission-guide.md)


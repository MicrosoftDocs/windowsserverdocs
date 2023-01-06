---
title: Active Directory Federation Services (AD FS) decommission guide 
description: Describes the recommended way to decommission Active Directory Federation Services (AD FS) servers.
author: billmath
ms.author: billmath
ms.date: 01/06/2023
ms.topic: article
---

# Active Directory Federation Services (AD FS) decommission guide 

 

Azure AD provides a simple cloud-based sign-in experience to all your resources and apps with strong authentication and real-time, risk-based adaptive access policies to grant access to resources reducing operational costs of managing and maintaining an AD FS environment and increasing IT efficiency.  

For more info on why you should upgrade from AD FS to Azure AD, see [Moving from AD FS to Azure AD](aka.ms/adfs2aad). 

This document will provide you with the recommended steps for decommissioning your AD FS servers.

## Pre-requisites for decommissioning AD FS servers 

Before you begin decommissioning your AD FS Servers, ensure the following is completed: 

Install Azure AD Connect Health to provide robust monitoring of your on-premises identity infrastructure. 

 

Migrate your user authentication to Azure AD. With cloud authentication enabled, Azure AD is capable of handling the users' sign-in process securely. Azure AD provides you with three options for secure cloud authentication of users: 

 

Azure AD Password Hash Synchronization (PHS) – Allows your users to sign-in to both on-premises and cloud-based applications using the same passwords. Azure AD Connect synchronizes a hash of a hash of a user's password from an on-premises Active Directory instance to a cloud-based Azure AD instance. The two layers of hashing ensure your passwords are never exposed or transmitted to cloud systems. 

 

Azure AD Certificate Based Authentication (CBA) – Enables you to adopt a phishing resistant authentication method and authenticate users with an X.509 certificate against your Public Key Infrastructure (PKI). 

 

Azure AD Pass-through Authentication (PTA) – Allows your users to sign-in to both on-premises and cloud-based applications using the same passwords. It installs an agent on your on-premises Active Directory and validates the users’ passwords directly against your on-premises Active Directory.  

 

You can try cloud authentication for your users using Staged Rollout. It allows you to selectively test groups of users with the cloud authentication capabilities mentioned above. 

Note:  

PHS & CBA are the preferred options for cloud managed authentication. PTA must be used only in cases where there are regulatory requirements to not synchronize any password information to the cloud. 

User authentication and App Migration can be done in any order, however, it is recommended to complete user authentication migration first and then undertake app migration for a smoother migration experience. 

Make sure to evaluate the supported and not-supported scenarios for Staged Rollout. 

 

Migrate all your applications that are currently using AD FS for authentication to Azure AD, as it gives you a single control plane for identity and access management to Azure AD. Ensure you also migrate your Office 365 applications and joined devices to Azure AD. 

 

Migration assistant can be used for migrating applications from AD FS to Azure AD. 

If you do not find the right SaaS application in the app gallery, they can be requested from https://aka.ms/AzureADAppRequest.  

 

Ensure to run Azure AD Connect Health for at least 1 week to observe the usage of apps in Azure AD. You should also be able to view user sign in logs in Azure AD. 


## See Also

[Active Directory Federation Services Overview](./ad-fs-overview.md)
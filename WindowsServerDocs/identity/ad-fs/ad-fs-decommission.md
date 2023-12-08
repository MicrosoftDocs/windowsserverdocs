---
description: "Learn more about: AD FS Decommission"
title: AD FS Decommission Reference
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---
# AD FS Decommission

A detailed guide on information you need to know to decommission your AD FS servers.

| Resource  | Description  |
|:-----------|:-------------|
|[AD FS decommission guide](../ad-fs/decommission/adfs-decommission-guide.md)|Detailed guide to decommissioning your AD FS servers.|
|[AD FS migration workshop](https://aka.ms/adfs2azureadworkshop)|Attend a workshop on how to successfully migrate off of AD FS.|
|[AD FS migration wizard](https://aka.ms/ADFS2AAD/Guide)|Provides custom guidance on migrating to Microsoft Entra ID.|
|[AD FS to Microsoft Entra FAQ](../ad-fs/decommission/ad-fs-to-azure-ad-faq.md)|FAQ for moving from AD FS to Microsoft Entra ID.|

<a name='resources-for-migrating-authentication-from-ad-fs-to-azure-active-directory'></a>

## Resources for migrating authentication from AD FS to Microsoft Entra ID

Additional resources to help you migrate authentication to Microsoft Entra ID.

| Resource  | Description  |
|:-----------|:-------------|
| [Migrate from federation to cloud authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication)|Detailed information on how to move from using federated authentication with AD FS to cloud authentication with Microsoft Entra ID.|
| [Deployment plan: Migrating from AD FS to password hash sync](https://aka.ms/ADFSTOPHSDPDownload) | With password hash synchronization, hashes of user passwords are synchronized from on-premises Active Directory to Microsoft Entra ID. This allows Microsoft Entra ID to authenticate users without interacting with the on-premises Active Directory.|
| [Deployment plan: Migrating from AD FS to pass-through authentication](https://aka.ms/ADFSTOPTADPDownload)|Microsoft Entra pass-through authentication helps users sign in to both on-premises and cloud-based applications by using the same password. This feature provides your users with a better experience since they have one less password to remember. It also reduces IT helpdesk costs because users are less likely to forget how to sign in when they only need to remember one password. When people sign in using Microsoft Entra ID, this feature validates users' passwords directly against your on-premises Active Directory.|
| [Deployment plans](/azure/active-directory/fundamentals/active-directory-deployment-plans) | Find more deployment plans for deploying features such as Microsoft Entra multifactor authentication, Conditional Access, user provisioning, seamless SSO, self-service password reset, and more! |
| [Tool: Active Directory Federation Services Migration Readiness Script](https://aka.ms/migrateapps/adfstools) | This is a script you can run on your on-premises Active Directory Federation Services (AD FS) server to determine the readiness of apps for migration to Microsoft Entra ID.|

## Resources for migrating applications from AD FS to Microsoft Entra ID
<a name='resources-for-migrating-applications-from-ad-fs-to-azure-active-directory'></a>

Additional resources to help you migrate application access to Microsoft Entra ID.

| Resource  | Description  |
|:-----------|:-------------|
|[Migrating your apps to Microsoft Entra ID](https://aka.ms/migrateapps/whitepaper) | This article presents the benefits of migration, and describes how to plan for migration in four clearly-outlined phases: discovery, classification, migration, and ongoing management. You’ll be guided through how to think about the process and break down your project into easy-to-consume pieces. Throughout the article there are links to important resources that will help you along the way. |
|[Developer tutorial: AD FS to Microsoft Entra application migration playbook for developers](https://aka.ms/adfsplaybook) | This set of ASP.NET code samples and accompanying tutorials will help you learn how to safely and securely migrate your applications integrated with Active Directory Federation Services (AD FS) to Microsoft Entra ID. This tutorial is focused towards developers who not only need to learn how to configure apps on both AD FS and Microsoft Entra ID, but also become aware and confident of changes their code base will require in this process.|
| [Deployment plan: Enabling single sign-on to a SaaS app with Microsoft Entra ID](https://aka.ms/SSODPDownload) | Single sign-on (SSO) helps you access all the apps and resources you need to do business, while signing in only once, using a single user account. For example, after a user has signed in, the user can move from Microsoft Office, to SalesForce, to Box without authenticating (for example, typing a password) a second time.
| [Deployment plan: Extending apps to Microsoft Entra ID with Application Proxy](https://aka.ms/AppProxyDPDownload)| Providing access from employee laptops and other devices to on-premises applications has traditionally involved virtual private networks (VPNs) or demilitarized zones (DMZs). Not only are these solutions complex and hard to make secure, but they are costly to set up and manage. Microsoft Entra application proxy makes it easier to access on-premises applications. |
| [Identity governance for applications](/azure/active-directory/governance/identity-governance-applications-prepare)| This guide outlines what you need to do if you're migrating identity governance for an application from a previous identity governance technology, to connect Microsoft Entra ID to that application.|


















## See Also

[Active Directory Federation Services Overview](./ad-fs-overview.md)

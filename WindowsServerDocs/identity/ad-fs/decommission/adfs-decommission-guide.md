---
manager: amycolannino
title: Active Directory Federation Services (AD FS) decommission guide 
description: Describes the recommended way to decommission Active Directory Federation Services (AD FS) servers.
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# Active Directory Federation Services (AD FS) decommission guide 

 

Microsoft Entra ID provides a simple cloud-based sign-in experience to all your resources and apps with strong authentication and real-time, risk-based adaptive access policies to grant access to resources reducing operational costs of managing and maintaining an AD FS environment and increasing IT efficiency.  

For more info on **why** you should upgrade from AD FS to Microsoft Entra ID, visit [moving from AD FS to Microsoft Entra ID](https://aka.ms/adfs2aad). See [migrate from federation to cloud authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) to understand **how** to upgrade from AD FS. 


> [!VIDEO https://www.youtube.com/embed/D0M-N-RQw0I]

This document will provide you with the recommended steps for decommissioning your AD FS servers.

## Pre-requisites for decommissioning AD FS servers 

Before you begin decommissioning your AD FS Servers, ensure the following items are complete.  For more information, see [migrating from federation to cloud authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication). 

 1. [Install Microsoft Entra Connect Health](/azure/active-directory/hybrid/how-to-connect-health-agent-install#install-the-agent-for-ad-fs) to provide robust monitoring of your on-premises identity infrastructure. 
 2. Complete the [pre-work for single sign-On (SSO)](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication#pre-work-for-sso).
 3. [Migrate your user authentication to Microsoft Entra ID](/azure/active-directory/hybrid/how-to-connect-staged-rollout). With cloud authentication enabled, Microsoft Entra ID is capable of handling the users' sign-in process securely. Microsoft Entra ID provides you with three options for secure cloud authentication of users:
     - [Microsoft Entra Password Hash Synchronization (PHS)](/azure/active-directory/hybrid/whatis-phs) – Allows your users to sign-in to both on-premises and cloud-based applications using the same passwords. Microsoft Entra Connect synchronizes a [hash of a hash of a user's password](/azure/active-directory/hybrid/how-to-connect-password-hash-synchronization#detailed-description-of-how-password-hash-synchronization-works) from an on-premises Active Directory instance to a cloud-based Microsoft Entra instance. The two layers of hashing ensure your passwords are never exposed or transmitted to cloud systems. 
     - [Microsoft Entra Certificate Based Authentication (CBA)](/azure/active-directory/authentication/concept-certificate-based-authentication) – Enables you to adopt a phishing resistant authentication method and authenticate users with an X.509 certificate against your Public Key Infrastructure (PKI). 
     - [Microsoft Entra pass-through authentication (PTA)](/azure/active-directory/hybrid/how-to-connect-pta) – Allows your users to sign-in to both on-premises and cloud-based applications using the same passwords. It installs an agent on your on-premises Active Directory and validates the users’ passwords directly against your on-premises Active Directory.  

     You can try cloud authentication for your users using [Staged Rollout](/azure/active-directory/hybrid/how-to-connect-staged-rollout). It allows you to selectively test groups of users with the cloud authentication capabilities mentioned above. 

     >[!NOTE]  
     > - PHS & CBA are the preferred options for cloud managed authentication. PTA must be used only in cases where there are regulatory requirements to not synchronize any password information to the cloud. 
     >- User authentication and App Migration can be done in any order, however, it is recommended to complete user authentication migration first. 
     >- Make sure to evaluate the [supported](/azure/active-directory/hybrid/how-to-connect-staged-rollout#supported-scenarios) and [not-supported](/azure/active-directory/hybrid/how-to-connect-staged-rollout#unsupported-scenarios) scenarios for Staged Rollout. 

 

 3. [Migrate all your applications](/azure/active-directory/manage-apps/migrate-adfs-apps-to-azure) that are currently using AD FS for authentication to Microsoft Entra ID, as it gives you a single control plane for identity and access management to Microsoft Entra ID. Ensure you also migrate your Office 365 applications and joined devices to Microsoft Entra ID. 
     - Migration assistant can be used for migrating applications from AD FS to Microsoft Entra ID. 
     - If you don't find the right SaaS application in the app gallery, they can be requested from https://aka.ms/AzureADAppRequest.  

 4. Ensure to run [Microsoft Entra Connect Health](/azure/active-directory/hybrid/how-to-connect-health-agent-install#install-the-agent-for-ad-fs) for at least one week to observe the usage of apps in Microsoft Entra ID. You should also be able to view user sign-in logs in Microsoft Entra ID. 

## Steps to decommission your AD FS Servers 

This section provides you with the step-by-step process to decommission your AD FS servers.  

Before reaching this point, you must verify that there's no relying party (Replying Part Trusts) with traffic which are still present in the AD FS servers.  

Before you begin, check the [AD FS event logs and/or Microsoft Entra Connect Health](/azure/active-directory/hybrid/how-to-connect-health-adfs) for any sign-in failures or success as that would mean these servers are still being used for something. In case you see sign-in successes or failures, check how to [migrate your apps](/azure/active-directory/manage-apps/migrate-adfs-apps-to-azure) from AD FS or [move your authentication](/azure/active-directory/hybrid/migrate-from-federation-to-cloud-authentication) to Microsoft Entra ID. 

Once the above is verified, you can take the following steps (assuming the AD FS servers aren't used for anything else now): 

> [!NOTE]
> After you moved your authentication to Microsoft Entra ID, test your environment for at least one week to verify cloud authentication is running smoothly without any issues. 

 1. Consider taking an optional [final backup](../operations/ad-fs-rapid-restore-tool.md#create-a-backup) before decommissioning AD FS servers.  
 2. Remove any AD FS entries from any of the load balancers (internal as well as external) you might have configured in your environment. 
 3. Delete any corresponding DNS entries of the respective farm names for AD FS servers in your environment. 
 4. On the primary AD FS server run [`Get-ADFSProperties`](/powershell/module/adfs/get-adfsproperties?view=windowsserver2022-ps&preserve-view=true ) and look for **CertificateSharingContainer**. Keep a note of this DN, as you'll need to delete it near the end of the installation (after a few reboots and when it isn't available anymore) 
 5. If your AD FS configuration database is using a SQL Server database instance as the store, ensure to delete the database before uninstalling AD FS servers.
 6. Uninstall the WAP (Proxy) servers. 
     - Sign in to each WAP server, open the Remote Access Management Console and look for published web applications. 
     - Remove any related to AD FS servers that aren't being used anymore. 
     - When all the published web applications are removed, uninstall WAP with the following command [Uninstall-WindowsFeature Web-Application-Proxy,CMAK,RSAT-RemoteAccess](/powershell/module/servermanager/uninstall-windowsfeature?view=windowsserver2022-ps&preserve-view=true ).
 7. Uninstall the AD FS servers.
     - Starting with the secondary nodes, uninstall AD FS with [Uninstall-WindowsFeature ADFS-Federation,Windows-Internal-Database](/powershell/module/servermanager/uninstall-windowsfeature?view=windowsserver2022-ps&preserve-view=true ) command. After this run del C:\Windows\WID\data\adfs* command to delete any database files
 8. Delete AD FS Secure Socket Layer (SSL) certificates from each server storage.
 9. Re-image AD FS servers with full disk formatting.
 10. You can now safely delete your AD FS account.
 11. Remove the content of the **CertificateSharingContainer** DN using ADSI Edit after uninstallation.

## Next Steps
- [AD FS to Microsoft Entra FAQ](ad-fs-to-azure-ad-faq.md)

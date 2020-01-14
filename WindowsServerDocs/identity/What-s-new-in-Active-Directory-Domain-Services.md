---
ms.assetid: 9a06cd41-426f-4cb9-89cf-f5be730e0b79
title: What&#39;s new in Active Directory Domain Services 
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
author: Femila
ms.author: billmath
ms.date: 05/31/2017
---
# What&#39;s new in Active Directory Domain Services 

>Applies To: Windows Server 2016

The following new features in Active Directory Domain Services (AD DS) improve the ability for organizations to secure Active Directory environments and help them migrate to cloud-only deployments and hybrid deployments, where some applications and services are hosted in the cloud and others are hosted on premises. The improvements include:  
  
-   [Privileged access management](https://technet.microsoft.com/library/mt150258.aspx   
)  
  
- [Extending cloud capabilities to Windows 10 devices through Azure Active Directory Join](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-overview/)   
  
- [Connecting domain-joined devices to Azure AD for Windows 10 experiences](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-devices-group-policy/)   
  
- [Enable Microsoft Passport for Work in your organization](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-passport-deployment/)    
  
-  [Deprecation of File Replication Service (FRS) and Windows Server 2003 functional levels](ad-ds/active-directory-functional-levels.md)  
  
  
## <a name="BKMK_PAM"></a>Privileged access management  
Privileged access management (PAM) helps mitigate security concerns for Active Directory environments that are caused by credential theft techniques such pass-the-hash, spear phishing, and similar types of attacks. It provides a new administrative access solution that is configured by using Microsoft Identity Manager (MIM). PAM introduces:  
  
-   A new bastion Active Directory forest, which is provisioned by MIM. The bastion forest has a special PAM trust with an existing forest. It provides a new Active Directory environment that is known to be free of any malicious activity, and isolation from an existing forest for the use of privileged accounts.  
  
-   New processes in MIM to request administrative privileges, along with new workflows based on the approval of requests.  
  
-   New shadow security principals (groups) that are provisioned in the bastion forest by MIM in response to administrative privilege requests. The shadow security principals have an attribute that references the SID of an administrative group in an existing forest. This allows the shadow group to access resources in an existing forest without changing any access control lists (ACLs).  
  
-   An expiring links feature, which enables time-bound membership in a shadow group. A user can be added to the group for just enough time required to perform an administrative task. The time-bound membership is expressed by a time-to-live (TTL) value that is propagated to a Kerberos ticket lifetime.  
  
    > [!NOTE]  
    > Expiring links are available on all linked attributes. But the member/memberOf linked attribute relationship between a group and a user is the only example where a complete solution such as PAM is preconfigured to use the expiring links feature.  
  
-   KDC enhancements are built in to Active Directory domain controllers to restrict Kerberos ticket lifetime to the lowest possible time-to-live (TTL) value in cases where a user has multiple time-bound memberships in administrative groups. For example, if you are added to a time-bound group A, then when you log on, the Kerberos ticket-granting ticket (TGT) lifetime is equal to the time you have remaining in group A. If you are also a member of another time-bound group B, which has a lower TTL than group A, then the TGT lifetime is equal to the time you have remaining in group B.  
  
-   New monitoring capabilities to help you easily identify who requested access, what access was granted, and what activities were performed.  
  
**Requirements**  
  
-   Microsoft Identity Manager  
  
-   Active Directory forest functional level of Windows Server 2012 R2 or higher.  
  
## <a name="BKMK_AzureADJoin"></a>Azure AD Join  
Azure Active Directory Join enhances identity experiences for enterprise, business and EDU customers- with improved capabilities for corporate and personal devices.  
  
Benefits:  
  
-   **Availability of Modern Settings** on corp-owned Windows devices. Oxygen Services no longer require a personal Microsoft account: they now run off users' existing work accounts to ensure compliance. Oxygen Services will work on PCs that are joined to an on-premises Windows domain, and PCs and devices that are “joined” to your Azure AD tenant (“cloud domain”). These settings include:  
  
    -   Roaming or personalization, accessibility settings and credentials  
  
    -   Backup and Restore  
  
    -   Access to Microsoft Store with work account  
  
    -   Live tiles and notifications  
  
-   **Access organizational resources** on mobile devices (phones, phablets) that can't be joined to a Windows Domain, whether they are corp-owned or BYOD  
  
-   **Single-Sign On** to Office 365 and other organizational apps, websites and resources.  
  
-   **On BYOD devices**, add a work account (from an on-premises domain or Azure AD) to a personally-owned device and enjoy SSO to work resources, via apps and on the web, in a way that helps ensure compliance with new capabilities such as Conditional Account Control and Device Health attestation.  
  
-   **MDM integration** lets you auto-enroll devices to your MDM (Intune or third-party)  
  
-   **Set up "kiosk" mode and shared devices** for multiple users in your organization  
  
-   **Developer experience** lets you build apps that cater to both enterprise and personal contexts with a shared programing stack.  
  
-   **Imaging** option lets you choose between imaging and allowing your users to configure corp-owned devices directly during the first-run experience.  
  
For more information see, [Windows 10 for the enterprise: Ways to use devices for work](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-windows10-devices-overview/?rnd=1).  
  
## <a name="BKMK_IDLocker"></a>Microsoft Passport  
Microsoft Passport is a new key-based authentication approach organizations and consumers, that goes beyond passwords. This form of authentication relies on breach, theft, and phish-resistant credentials.  
  
The user logs on to the device with a biometric or PIN log on information that is linked to a certificate or an asymmetrical key pair. The Identity Providers (IDPs) validate the user by mapping the public key of the user to IDLocker and provides log on information through One Time Password (OTP), Phonefactor or a different notification mechanism.  
  
For more information see, [Authenticating identities without passwords through Microsoft Passport](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-passport/)  
  
## <a name="BKMK_FRSDeprecation"></a>Deprecation of File Replication Service (FRS) and Windows Server 2003 functional levels  
Although File Replication Service (FRS) and the Windows Server 2003 functional levels were deprecated in previous versions of Windows Server, it bears repeating that the Windows Server 2003 operating system is no longer supported. As a result, any domain controller that runs Windows Server 2003 should be removed from the domain. The domain and forest functional level should be raised to at least Windows Server 2008 to prevent a domain controller that runs an earlier version of Windows Server from being added to the environment.  
  
At the Windows Server 2008 and higher domain functional levels, Distributed File Service (DFS) Replication is used to replicate SYSVOL folder contents between domain controllers. If you create a new domain at the Windows Server 2008 domain functional level or higher, DFS Replication is automatically used to replicate SYSVOL. If you created the domain at a lower functional level, you will need to migrate from using FRS to DFS replication for SYSVOL. For migration steps, you can either follow the [procedures on TechNet](https://technet.microsoft.com/library/dd640019(v=WS.10).aspx) or you can refer to the [streamlined set of steps on the Storage Team File Cabinet blog](https://blogs.technet.com/b/filecab/archive/2014/06/25/streamlined-migration-of-frs-to-dfsr-sysvol.aspx).  
  
The Windows Server 2003 domain and forest functional levels continue to be supported, but organizations should raise the functional level to Windows Server 2008 (or higher if possible) to ensure SYSVOL replication compatibility and support in the future. In addition, there are many other benefits and features available at the higher functional levels higher. See the following resources for more information:  
  
-   [Understanding Active Directory Domain Services (AD DS) Functional Levels](ad-ds/active-directory-functional-levels.md)  
  
-   [Raise the Domain Functional Level](https://technet.microsoft.com/library/cc753104.aspx)  
  
-   [Raise the Forest Functional Level](https://technet.microsoft.com/library/cc730985.aspx)  
  

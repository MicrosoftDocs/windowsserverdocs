---
ms.assetid: 24c4b9bb-928a-4118-acf1-5eb06c6b08e5
title: Configure AD FS 2016 and Azure MFA
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 11/01/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Configure AD FS 2016 and Azure MFA

>Applies To: Windows Server 2016

If your organization is federated with Azure AD, you can use Azure Multi-Factor Authentication to secure AD FS resources, both on-premises and in the cloud. Azure MFA enables you to eliminate passwords and provide a more secure way to authenticate.  Starting with Windows Server 2016, you can now configure Azure MFA for primary authentication. 
  
Unlike with AD FS in Windows Server 2012 R2, the AD FS 2016 Azure MFA adapter integrates directly with Azure AD and does not require an on premises Azure MFA server.   The Azure MFA adapter is built in to Windows Server 2016, and there is no need for additional installation.

## Note on Registering users for Azure MFA with AD FS 2016
AD FS does not currently support inline proof up (registration) of Azure MFA security verification information.  As a result, when a user who has not yet registered (configured verification information) in Azure AD tries to authenticate with Azure MFA at AD FS, they will get an error.  While we are working to add inline proofing functionality, the following are the recommended configurations for enabling Azure MFA with AD FS.
>[!NOTE]   
> As a workaround to enable users to register for MFA you can:
 - If you have an additional MFA method configured such as smart cards, you can customize the AD FS error page to direct users to https://aka.ms/mfasetup, where they can sign on with their smart card and then register for Azure MFA
 - If you do not have another MFA method configured, you can configure AD FS to issue the MFA claim (claim type http://schemas.microsoft.com/claims/authnmethodsreferences, value http://schemas.microsoft.com/claims/multipleauthn ) under limited conditions such as when the user is on a domain joined computer on the corporate intranet, then customize the AD FS error page as mentioned above.


### Recommended deployment topologies

#### Azure MFA as Primary Authentication
If you wish to use Azure MFA as a primary authentication method in AD FS, for example to avoid passwords for Office 365 signin, you can do this *without* configuring Azure AD to do MFA on premises.  This means your domain's federation setting SupportsMfa (Get-MsolDomainFederationSettings -DomainName [your domain name]) remains set to $false.  

Azure AD as primary authentication does not depend on the SupportsMfa domain setting.  In addition, with this configuration you'll be able to use Azure AD's inline registration capability to enable your users to proof up.  Each user will have to do this once by using username and password to access the "Additional Security Verification" page in the Azure portal and register.

#### Azure MFA as Additional authentication to Office 365
Today, if you wish to have Azure MFA as an additional authentication method in AD FS for Office 365, you can achieve this with compound MFA, in which primary authentication is performed on premises in AD FS and MFA is triggered by Azure AD.  This will be the default behavior when Azure AD requires MFA, but the domain SupportsMFA setting is set to $False.  This means Azure AD MFA will be done by Azure AD and not AD FS, but it avoids the hard AD FS error for non provisioned users.

As an alternative to the above, you can use an Active Directory group containing only proofed up Azure AD users to control who is prompted for Azure MFA at the AD FS level.  This requires you to maintain group membership, and it will break Azure AD Conditional Access scenarios that require MFA for users outside the group.

#### Azure MFA as Additional authentication for other (non Azure AD) AD FS relying parties
Today if you wish to have Azure MFA as an additional authentication method in AD FS for other relying parties, this can be achieved with the Azure AD domain SupportsMFA setting set to $False.  
In this configuration you'll be able to use Azure AD's inline registration capability to enable your users to proof up.  Each user will have to do this once by using username and password to access the "Additional Security Verification" page in the Azure portal and register. Once users are registered, they will be able sign on via AD FS to non AAD applications that require MFA.


## Pre-Requisites  
The following pre-requisites are required when using Azure MFA for authentication with AD FS:  
  
- An [Azure subscription with Azure Active Directory](https://azure.microsoft.com/pricing/free-trial/).  
- [Azure Multi-Factor Authentication](https://azure.microsoft.com/documentation/articles/multi-factor-authentication/)  

>[!NOTE]   
> Azure AD and Azure MFA are included in Azure AD Premium and the Enterprise Mobility Suite (EMS).  If you have either of these you do not need individual subscriptions.   
- A Windows Server 2016 AD FS on-premises environment.  
- Your on-premises environment is [federated with Azure AD.](https://azure.microsoft.com/documentation/articles/active-directory-aadconnect-get-started-custom/#configuring-federation-with-ad-fs)  
- [Windows Azure Active Directory Module for Windows PowerShell](https://go.microsoft.com/fwlink/p/?linkid=236297).  
- Global administrator permissions on your instance of Azure AD to configure it using Azure AD PowerShell.  
- Enterprise administrator credentials to configure the AD FS farm for Azure MFA.  
  
  
## Configure the AD FS Servers  
In order to complete configuration for Azure MFA for AD FS, you need to configure each AD FS server using the steps described. Ensure that these steps are performed on **all** AD FS servers in the farm. If you have have multiple AD FS servers in your farm, you can perform the necessary configuration remotely using Azure AD Powershell.  
  
  
  
### Step 1: Generate a certificate for Azure MFA on each AD FS server using the `New-AdfsAzureMfaTenantCertificate` cmdlet.   
The first thing you need to do is generate a certificate for Azure MFA to use.  This can be done using PowerShell.  The certificate generated can be found in the local machines certificate store, and it is marked with a subject name containing the TenantID for your Azure AD directory.    
  
![AD FS and MFA](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA3.png)  
  
Note that TenantID is the name of your directory in Azure AD.  Use the following PowerShell cmdlet to generate the new certificate.  
    `$certbase64 = New-AdfsAzureMfaTenantCertificate -TenantID <tenantID>`  
      
![AD FS and MFA](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA1.PNG)  
  
### Step 2: Add the new credentials to Azure Multi-Factor Auth Client SPN   
In order to enable the AD FS servers to communicate with the Azure Multi-Factor Auth Client, you need to add the credentials to the SPN for the Azure Multi-Factor Auth Client. The certificates generated using the `New-AdfsAzureMFaTenantCertificate` cmdlet will serve as these credentials. Do the following using PowerShell to add the new credentials to the Azure Multi-Factor Auth Client SPN.  

>[!NOTE]   
>In order to complete this step you need to connect to your instance of Azure AD with PowerShell using Connect-MsolService.  These steps assume you have already connected via PowerShell.  For information see [Connect-MsolService.](https://msdn.microsoft.com/library/dn194123.aspx)  
     
  
2. **Set the certificate as the new credential against the Azure Multi-Factor Auth Client**  
	
	`New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type asymmetric -Usage verify -Value $certBase64 `

>[!IMPORTANT]
>  This command needs to be run on all of the AD FS servers in your farm.  Azure AD MFA will fail on servers that have not have the certificate set as the new credential against the Azure Multi-Factor Auth Client. 

>[!NOTE]  
> 981f26a1-7f43-403b-a875-f8b09b8cd720 is the guid for Azure Multi-Factor Auth Client.  
  
## Configure the AD FS Farm  
  
Once you have completed the previous section on each AD FS server, you will need to run  the `Set-AdfsAzureMfaTenant` cmdlet.  
  
This cmdlet needs to be executed only once for an AD FS farm.  Use PowerShell to complete this step.    
  
>[!NOTE]  
>You will need to restart the AD FS service on each server in the farm before these changes take affect.  
  
    Set-AdfsAzureMfaTenant -TenantId <tenant ID> -ClientId 981f26a1-7f43-403b-a875-f8b09b8cd720  
      
![AD FS and MFA](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA5.png)  
  
After this, you will see that Azure MFA is available as a primary authentication method for intranet and extranet use.    
  
![AD FS and MFA](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA6.png)  


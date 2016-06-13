---
title: Configure AD FS 2016 and Azure MFA
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b7d2ea8-9a9d-4e0a-9203-c5059e3034d7
author: Femila
---
# Configure AD FS 2016 and Azure MFA
  
The following topic describes how to get started and configure AD FS for enabling multi-factor authentication with Azure.  
  
If your organization is federated with Azure AD you can use Azure Multi-Factor Authentication to secure on-premises and cloud resources.  This can be done by configuring AD FS to trigger Azure MFA for high value end points.  By leveraging Azure MFA you can eliminate the need for passwords and provide a more secure way to authenticate.  Starting with Windows Server 2016, you can now configure Azure MFA for primary authentication.  The Azure MFA adapter comes with Windows Server 2016 so there is no need for additional installation.    
  
In Windows Server 2016, the Azure MFA adapter integrates with Azure Active Directory for all the MFA configuration. This is a change from Windows Server 2012 R2, which required installing an on-premises component, the MFA Server. In Windows Server 2016, the MFA Server is not required because all of the configuration information is stored in Azure Active Directory.   
  
## Pre-Requisites  
The following pre-requisites are required when using Azure MFA for authentication with AD FS:  
  
- An [Azure subscription with Azure Active Directory](https://azure.microsoft.com/pricing/free-trial/).  
- [Azure Multi-Factor Authentication](https://azure.microsoft.com/documentation/articles/multi-factor-authentication/)  
>[!NOTE]   
> Azure AD and Azure MFA are included in Azure AD Premium and the Enterprise Mobility Suite (EMS).  If you have either of these you do not need individual subscriptions.   
- A Windows Server 2016 AD FS on-premises environment.  
- Your on-premises environment is [federated with Azure AD.](https://azure.microsoft.com/documentation/articles/active-directory-aadconnect-get-started-custom/#configuring-federation-with-ad-fs)  
- [Windows Azure Active Directory Module for Windows PowerShell](http://go.microsoft.com/fwlink/p/?linkid=236297).  
- Global administrator permissions on your instance of Azure AD to configure it using Azure AD PowerShell.  
- Enterprise administrator credentials to configure the AD FS farm for Azure MFA.  
  
  
## Configure the AD FS Servers  
In order to complete configuration for Azure MFA for AD FS, you need to configure each AD FS server using the steps described. Ensure that these steps are performed on **all** AD FS servers in the farm. If you have have multiple AD FS servers in your farm, you can perform the necessary configuration remotely using Azure AD Powershell.  
  
  
  
### Step 1: Generate a certificate for Azure MFA on each AD FS server using the `New-AdfsAzureMfaTenantCertificate` cmdlet.   
The first thing you need to do is generate a certificate for Azure MFA to use.  This can be done using PowerShell.  The certificate generated can be found in the local machines certificate store, and it is marked with a subject name containing the TenantID for your Azure AD directory.    
  
![ADFS_AzureMFA3media/ADFS_AzureMFA3.png)  
  
Note that TenantID is the name of your directory in Azure AD.  Use the following PowerShell cmdlet to generate the new certificate.  
    `$certbase64 = New-AdfsAzureMfaTenantCertificate -TenantID <tenantID>`  
	  
![ADFS_AzureMFA1media/ADFS_AzureMFA1.PNG)  
  
### Step 2: Add the new credentials to Azure Multi-Factor Auth Client SPN   
In order to enable the AD FS servers to communicate with the Azure Multi-Factor Auth Client, you need to add the credentials to the SPN for the Azure Multi-Factor Auth Client. The certificates generated using the `New-AdfsAzureMFaTenantCertificate` cmdlet will serve as these credentials. Do the following using PowerShell to add the new credentials to the Azure Multi-Factor Auth Client SPN.  
>[!NOTE]   
>In order to complete this step you need to connect to your instance of Azure AD with PowerShell using Connect-MsolService.  These steps assume you have already connected via PowerShell.  For information see [Connect-MsolService.](https://msdn.microsoft.com/library/dn194123.aspx)  
	  
1. **Get the X.509 interpretation of the certificate and convert it to X509**   
		  
	`$certX509 = New-Object.System.Security.Cryptography.X509Certificates.X509Certificate`  
	`$certX509.Import([System.Convert]::FromBase64String($certBase64))`  
	  
![ADFS_AzureMFA2media/ADFS_AzureMFA2.PNG)  
  
2. **Set the certificate as the new credential against the Azure Multi-Factor Auth Client**  
	`New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type asymmetric -Usage verify -Value $certBase64 -StartDate $certX509.GetEffectiveDateString() -EndDate $certX509.GetExpirationDateString()`  
  
>[!NOTE]  
> 981f26a1-7f43-403b-a875-f8b09b8cd720 is the guid for Azure Multi-Factor Auth Client.  
  
## Configure the AD FS Farm  
  
Once you have completed the previous section on each AD FS server, you will need to run  the `Set-AdfsAzureMfaTenant` cmdlet.  
  
This cmdlet needs to be executed only once for an AD FS farm.  Use PowerShell to complete this step.    
  
>[!NOTE]  
>You will need to restart the AD FS service on each server in the farm before these changes take affect.  
  
    Set-AdfsAzureMfaTenant -TenantId <tenant ID> -ClientId 981f26a1-7f43-403b-a875-f8b09b8cd720  
	  
![ADFS_AzureMFA5media/ADFS_AzureMFA5.png)  
  
After this, you will see that Azure MFA is available as a primary authentication method for intranet and extranet use.    
  
![ADFS_AzureMFA6media/ADFS_AzureMFA6.png)  


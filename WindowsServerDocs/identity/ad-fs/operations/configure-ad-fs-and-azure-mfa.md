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

## Registering users for Azure MFA with AD FS 2016
AD FS does not support inline “proof up”, or registration of Azure MFA security verification information such as phone number or mobile app. This means users must get proofed up by visiting https://account.activedirectory.windowsazure.com/Proofup.aspx prior to using Azure MFA to authenticate to AD FS applications. 
When a user who has not yet proofed up in Azure AD tries to authenticate with Azure MFA at AD FS, they will get an AD FS error.  As an AD FS administrator, you can customize this error experience to guide the user to the proofup page instead.  You can do this using onload.js customization to detect the error message string within the AD FS page and show a new message to guide the users to visit https://aka.ms/mfasetup, then re-attempt authentication. For detailed guidance see the "Customize the AD FS web page to guide users to register MFA verification methods" below in this article.

>[!NOTE]
> Previously, users were required to authenticate with MFA for registration (visiting https://account.activedirectory.windowsazure.com/Proofup.aspx, for example via the shortcut aka.ms/mfasetup).  Now, an AD FS user who has not yet registered MFA verification information can access Azure AD’s proofup page via the shortcut aka.ms/mfasetup using only primary authentication (such as Windows Integrated Authentication or username and password via the AD FS web pages).  If the user has no verification methods configured, Azure AD will perform inline registration in which the user sees the message “Your admin has required that you set up this account for additional security verification”, and the user can then select to “Set it up now”.
> Users who already have at least one MFA verification method configured will still be prompted to provide MFA when visiting the proofup page.

### Recommended deployment topologies

#### Azure MFA as Primary Authentication
There are a couple of great reasons to use Azure MFA as Primary Authentication with AD FS:
 - To avoid passwords for sign-in to Azure AD, Office 365 and other AD FS apps
 - To protect password based sign-in by requiring an additional factor such as verification code prior to the password

If you wish to use Azure MFA as a primary authentication method in AD FS to achieve these benefits, you probably also want to keep the ability to use Azure AD conditional access including “true MFA” by prompting for additional factors in AD FS.

You can now do this by configuring the Azure AD domain setting to do MFA on premises (setting “SupportsMfa” to $True).  In this configuration, AD FS can be prompted by Azure AD to perform additional authentication or “true MFA” for conditional access scenarios that require it.  

As described above, any AD FS user who has not yet registered (configured MFA verification information) should be prompted via a customized AD FS error page to visit aka.ms/mfasetup to configure verification information, then re-attempt AD FS login.  
Because Azure MFA as primary is considered a single factor, after initial configuration users will need to provide an additional factor to manage or update their verification information in Azure AD, or to access other resources that require MFA.


#### Azure MFA as Additional authentication to Office 365
Previously, if you wished to have Azure MFA as an additional authentication method in AD FS for Office 365 or other relying parties, the best option was to configure Azure AD to do compound MFA, in which primary authentication is performed on premises in AD FS and MFA is triggered by Azure AD. 
Now, you can use Azure MFA as additional authentication in AD FS when the domain SupportsMfa setting is set to $True.  

As described above, any AD FS user who has not yet registered (configured MFA verification information) should be prompted via a customized AD FS error page to visit aka.ms/mfasetup to configure verification information, then re-attempt AD FS login.  


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
In order to complete configuration for Azure MFA for AD FS, you need to configure each AD FS server using the steps described. 

>[!NOTE]
>Ensure that these steps are performed on **all** AD FS servers in the farm. If you have have multiple AD FS servers in your farm, you can perform the necessary configuration remotely using Azure AD Powershell.  
  
  
  
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

## Renew and Manage AD FS Azure MFA Certificates
The following guidance takes you through how to manage the Azure MFA certificates on your AD FS servers.
By default, when you configure AD FS with Azure MFA, the certificates generated via the New-AdfsAzureMfaTenantCertificate PowerShell cmdlet are valid for 2 years.  To determine how close to expiration your certificates are, and then to renew and install new certificates, use the following procedure.

### Assess AD FS Azure MFA certificate expiration date
On each AD FS server, in the local computer My store, there will be a self signed certificate with “OU=Microsoft AD FS Azure MFA” in the Issuer and Subject.  This is the Azure MFA certificate.  Check the validity period of this certificate on each AD FS server to determine the expiration date.  

### Create new AD FS Azure MFA Certificate on each AD FS server
If the validity period of your certificates is nearing its end, start the renewal process by generating a new Azure MFA certificate on each AD FS server. In a powershell command window, generate a new certificate on each AD FS server using the following cmdlet:

```
PS C:\> $newcert = New-AdfsAzureMfaTenantCertificate -TenantId <tenant id such as contoso.onmicrosoft.com> -Renew $true
```

As a result of this cmdlet, a new certificate that is valid from 2 days in the future to 2 days + 2 years will be generated.  AD FS and Azure MFA operations will not be affected by this cmdlet or the new certificate. (Note: the 2 day delay is intentional and provides time to execute the steps below to configure the new certificate in the tenant before AD FS starts using it for Azure MFA.)


### Configure each new AD FS Azure MFA certificate in the Azure AD tenant
Using the Azure AD PowerShell module, for each new certificate (on each AD FS server), update your Azure AD tenant settings as follows (Note: you must first connect to the tenant using Connect-MsolService to run the following commands).

```
PS C:/> New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type Asymmetric -Usage Verify -Value $certbase64
```
    Where $certbase64 is the new certificate.  The base64 encoded certificate can be obtained by exporting the certificate (without the private key) as a DER encoded file and opening in Notepad.exe, then copy/pasting to the PSH session and assigning to the variable $certbase64

### Verify that the new certificate(s) will be used for Azure MFA
Once the new certificate(s) become valid, AD FS will pick them up and start using each respective certificate for Azure MFA within a few hours to a day.  Once this occurs, on each server you will see an event logged in the AD FS Admin event log with the following information:
Log Name:      AD FS/Admin
Source:        AD FS
Date:          2/27/2018 7:33:31 PM
Event ID:      547
Task Category: None
Level:         Information
Keywords:      AD FS
User:          DOMAIN\adfssvc
Computer:      ADFS.domain.contoso.com
Description:
The tenant certificate for Azure MFA has been renewed.  

TenantId: contoso.onmicrosoft.com. 
Old thumbprint: 7CC103D60967318A11D8C51C289EF85214D9FC63. 
Old expiration date: 9/15/2019 9:43:17 PM. 
New thumbprint: 8110D7415744C9D4D5A4A6309499F7B48B5F3CCF. 
New expiration date: 2/27/2020 2:16:07 AM.

## Customize the AD FS web page to guide users to register MFA verification methods

Use the following examples to customize your AD FS web pages for users who have not yet proofed up (configured MFA verification information).

### Find the error
First, there are a couple of different error messages AD FS will return in the case in which the user lacks verification information.
If you are using Azure MFA as primary authentication, the un-proofed user will see an AD FS error page containing the following messages:
```
    <div id="errorArea"> 
        <div id="openingMessage" class="groupMargin bigText">
            An error occurred 
        </div> 
        <div id="errorMessage" class="groupMargin">
            Authentication attempt failed. Select a different sign in option or close the web browser and sign in again. Contact your administrator for more information. 
        </div>
```
When Azure AD as additional authentication is being attempted, the un-proofed user will see an AD FS error page containing the following messages:
```
<div id='mfaGreetingDescription' class='groupMargin'>For security reasons, we require additional information to verify your account (mahesh@jenfield.net)</div>
    <div id="errorArea"> 
        <div id="openingMessage" class="groupMargin bigText">
            An error occurred 
        </div> 
        <div id="errorMessage" class="groupMargin">
            The selected authentication method is not available for &#39;username@contoso.com&#39;. Choose another authentication method or contact your system administrator for details. 
        </div>
```

### Catch the error and update the page text
Catching the error and showing the user custom guidance is a matter of appending javascript to the end of the onload.js file that is part of the AD FS web theme to (1) search for the identifying error string(s) and (2) provide custom web content.  (For guidance in general on how to customize the onload.js file, see the article [here](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/advanced-customization-of-ad-fs-sign-in-pages).)


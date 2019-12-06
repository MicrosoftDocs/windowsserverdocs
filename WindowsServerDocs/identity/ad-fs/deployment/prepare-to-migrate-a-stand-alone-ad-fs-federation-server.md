---
title: Prepare to migrate a stand-alone AD FS federation server
description: Provides information on getting ready to migrate a stand-alone AD FS server to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

#  Prepare to migrate a stand-alone AD FS federation server or a single-node AD FS farm  
 
To prepare to migrate (same server migration) a stand-alone AD FS 2.0 federation server or a single-node AD FS farm to Windows Server 2012, you must export and back up the AD FS configuration data from this server.  
  
To export the AD FS configuration data, perform the following tasks:  
  
-   [Step 1:  Export service settings](#step-1-export-service-settings)  
  
-   [Step 2:  Export claims provider trusts](#step-2-export-claims-provider-trusts)  
  
-   [Step 3:  Export relying party trusts](#step-3-export-relying-party-trusts)  
  
-   [Step 4:  Back up custom attribute stores](#step-4-back-up-custom-attribute-stores)  
  
-   [Step 5:  Back up webpage customizations](#step-5-back-up-webpage-customizations)  
  
## Step 1: Export service settings  
 To export service settings, perform the following procedure:  
  
### To export service settings  
  
1.  Record the certificate subject name and thumbprint value of the SSL certificate used by the federation service. To find the SSL certificate, open the Internet Information Services (IIS) management console, Select **Default Web Site** in the left pane, click **Bindings…** in the **Action** pane, find and select the https binding, click **Edit**, and then click **View**.  
  
> [!NOTE]
>  Optionally, you can also export the SSL certificate used by the federation service and its private key to a .pfx file. For more information, see [Export the Private Key Portion of a Server Authentication Certificate](Export-the-Private-Key-Portion-of-a-Server-Authentication-Certificate.md).  
>   
>  Exporting the SSL certificate is optional because this certificate is stored in the local computer Personal certificates store and is preserved in the operating system upgrade.  
  
2. Record the configuration of the AD FS Service communications, token-decrypting and token-signing certificates.  To view all the certificates that are used, open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to create a list of all certificates in use in a file `PSH:>Get-ADFSCertificate | Out-File “.\certificates.txt”`  
  
> [!NOTE]
>  Optionally, you can also export any token-signing, token-encryption, or service-communications certificates and keys that are not internally generated, in addition to all self-signed certificates. You can view all the certificates that are in use on your server by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell`. Then run the following command to view all certificates that are in use on your server `PSH:>Get-ADFSCertificate`. The output of this command includes StoreLocation and StoreName values that specify the store location of each certificate. You can then use the guidance in [Export the Private Key Portion of a Server Authentication Certificate](Export-the-Private-Key-Portion-of-a-Server-Authentication-Certificate.md) to export each certificate and its private key to a .pfx file.  
>   
>  Exporting these certificates is optional because all external certificates are preserved during the operating system upgrade.  
  
3. Export AD FS 2.0 federation service properties, such as the federation service name, federation service display name, and federation server identifier to a file.  
  
To export federation service properties, open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export federation service properties: `PSH:> Get-ADFSProperties | Out-File “.\properties.txt”`.  
  
The output file will contain the following important configuration values:  
  
    
|**Federation Service Property name as reported by Get-ADFSProperties**|**Federation Service Property name in AD FS management console**|
|------|------|
|HostName|Federation Service name|  
|Identifier|Federation Service identifier|  
|DisplayName|Federation Service display name|  
  
4. Back up the application configuration file. Among other settings, this file contains the policy database connection string.  
  
To back up the application configuration file, you must manually copy the `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config` file to a secure location on a backup server.  
  
> [!NOTE]
>  Make note of the database connection string in this file, located immediately after “policystore connectionstring=”). If the connection string specifies a SQL Server database, the value is needed when restoring the original AD FS configuration on the federation server.  
>   
>  The following is an example of a WID connection string: `“Data Source=\\.\pipe\mssql$microsoft##ssee\sql\query;Initial Catalog=AdfsConfiguration;Integrated Security=True"`. The following is an example of a SQL Server connection string: `"Data Source=databasehostname;Integrated Security=True"`.  
  
5. Record the identity of the AD FS 2.0 federation service account and the password of this account.  
  
To find the identity value, examine the **Log On As** column of **AD FS 2.0 Windows Service** in the **Services** console and manually record this value.  
  
> [!NOTE]
>  For a stand-alone federation service, the built-in NETWORK SERVICE account is used.  In this case, you do not need to have a password.  
  
6. Export the list of enabled AD FS endpoints to a file.  
  
To do this, open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export the list of enabled AD FS endpoints to a file: `PSH:> Get-ADFSEndpoint | Out-File “.\endpoints.txt”`.  
  
7. Export any custom claim descriptions to a file.  
  
To do this, open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export any custom claim descriptions to a file: `Get-ADFSClaimDescription | Out-File “.\claimtypes.txt”`.  
  
##  Step 2: Export claims provider trusts  
 To export the claims provider trusts, perform the following procedure:  
  
### To export claims provider trusts  
  
1.  You can use Windows PowerShell to export all claims provider trusts. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export all claims provider trusts: `PSH:>Get-ADFSClaimsProviderTrust | Out-File “.\cptrusts.txt”`.  
  
## Step 3: Export relying party trusts  
 To export relying party trusts, perform the following procedure:  
  
### To export relying party trusts  
  
1.  To export all relying party trusts, open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export all relying party trusts:`PSH:>Get-ADFSRelyingPartyTrust | Out-File “.\rptrusts.txt”`.  
  
## Step 4: Back up custom attribute stores  
 You can find information about custom attribute stores in use by AD FS by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to find information about the custom attribute stores: `PSH:>Get-ADFSAttributeStore`. The steps to upgrade or migrate custom attribute stores vary.  
  
## Step 5: Back up webpage customizations  
 To back up any webpage customizations, copy the AD FS webpages and the **web.config** file from the directory that is mapped to the virtual path **“/adfs/ls”** in IIS. By default, it is in the **%systemdrive%\inetpub\adfs\ls** directory.  

## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)
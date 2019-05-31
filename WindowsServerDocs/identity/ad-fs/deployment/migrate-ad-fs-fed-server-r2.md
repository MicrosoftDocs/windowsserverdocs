---
title: Migrate the AD FS 2.0 federation server
description: Provides information on migrating an AD FS server to Windows Server 2012 R2.
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/10/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Migrate the AD FS 2.0 federation server to AD FS on Windows Server 2012 R2

To migrate an AD FS federation server that belongs to a single-node AD FS farm, a WIF farm, or a SQL Server farm to Windows Server 2012 R2, you must perform the following tasks:  
  
1.  [Export and backup the AD FS configuration data](migrate-ad-fs-fed-server-r2.md#export-and-backup-the-ad-fs-configuration-data)  
  
2.  [Create a Windows Server 2012 R2 federation server farm](migrate-ad-fs-fed-server-r2.md#create-a-windows-server-2012-r2-federation-server-farm)  
  
3.  [Import the original configuration data into the Windows Server 2012 R2 AD FS farm](migrate-ad-fs-fed-server-r2.md#import-the-original-configuration-data-into-the-windows-server-2012-r2-ad-fs-farm)  
  
##  Export and backup the AD FS configuration data  
 To export the AD FS configuration settings, perform the following procedures:  
  
###  To export service settings  
  
1.  Make sure that you have access to the following certificates and their private keys in a .pfx file:  
  
    -   The SSL certificate that is used by the federation server farm that you want to migrate  
  
    -   The service communication certificate (if it is different from the SSL certificate) that is used by the federation server farm that you want to migrate  
  
    -   All third-party party token-signing or token-encryption/decryption certificates that are used by the federation server farm that you want to migrate  
  
To find the SSL certificate, open the Internet Information Services (IIS) management console, Select **Default Web Site** in the left pane, click **Bindings…** in the **Action** pane, find and select the https binding, click **Edit**, and then click **View**.  
  
You must export the SSL certificate used by the federation service and its private key to a .pfx file. For more information, see [Export the Private Key Portion of a Server Authentication Certificate](export-the-private-key-portion-of-a-server-authentication-certificate.md).  
  
> [!NOTE]
>  If you plan to deploy the Device Registration Service as part of running your AD FS in Windows Server 2012 R2, you must obtain a new SSL cert. For more information, see [Enroll an SSL Certificate for AD FS](enroll-an-ssl-certificate-for-ad-fs.md) and [Configure a federation server with Device Registration Service](configure-a-federation-server-with-device-registration-service.md).  
  
To view the token signing, token decryption and service communication certificates that are used, run the following Windows PowerShell command to create a list of all certificates in use in a file:  
  
``` powershell
Get-ADFSCertificate | Out-File “.\certificates.txt”  
 ```  
  
2. Export AD FS federation service properties, such as the federation service name, federation service display name, and federation server identifier to a file.  
  
To export federation service properties, open Windows PowerShell and run the following command: 

``` powershell
Get-ADFSProperties | Out-File “.\properties.txt”`.  
``` 

The output file will contain the following important configuration values:  
 
|**Federation Service Property name as reported by Get-ADFSProperties**|**Federation Service Property name in AD FS management console**|
|-----|-----|  
|HostName|Federation Service name|  
|Identifier|Federation Service identifier|  
|DisplayName|Federation Service display name|  
  
3. Back up the application configuration file. Among other settings, this file contains the policy database connection string.  
  
To back up the application configuration file, you must manually copy the `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config` file to a secure location on a backup server.  
  
> [!NOTE]
>  Make note of the database connection string in this file, located immediately after “policystore connectionstring=”. If the connection string specifies a SQL Server database, the value is needed when restoring the original AD FS configuration on the federation server.  
>   
>  The following is an example of a WID connection string: `“Data Source=\\.\pipe\mssql$microsoft##ssee\sql\query;Initial Catalog=AdfsConfiguration;Integrated Security=True"`. The following is an example of a SQL Server connection string: `"Data Source=databasehostname;Integrated Security=True"`.  
  
4. Record the identity of the AD FS federation service account and the password of this account.  
  
To find the identity value, examine the **Log On As** column of **AD FS 2.0 Windows Service** in the **Services** console and manually record this value.  
  
> [!NOTE]
>  For a stand-alone federation service, the built-in NETWORK SERVICE account is used.  In this case, you do not need to have a password.  
  
5. Export the list of enabled AD FS endpoints to a file.  
  
To do this, open Windows PowerShell and run the following command: 

``` powershell
Get-ADFSEndpoint | Out-File “.\endpoints.txt”`.  
``` 

6. Export any custom claim descriptions to a file.  
  
To do this, open Windows PowerShell and run the following command: 

``` powershell
Get-ADFSClaimDescription | Out-File “.\claimtypes.txt”`.  
 ```

7. If you have custom settings such as useRelayStateForIdpInitiatedSignOn configured in the web.config file, ensure you back up the web.config file for reference. You can copy the file from the directory that is mapped to the virtual path **“/adfs/ls”** in IIS. By default, it is in the **%systemdrive%\inetpub\adfs\ls** directory.  
  
###  To export claims provider trusts and relying party trusts  
  
1.  To export AD FS claims provider trusts and relying party trusts, you must log in as Administrator (however, not as the Domain Administrator) onto your federation server and run the following Windows PowerShell script that is located in the **media/server_support/adfs** folder of the Windows Server 2012 R2 installation CD: `export-federationconfiguration.ps1`.  
  
> [!IMPORTANT]
>  The export script takes the following parameters:  
> 
> - Export-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-CertificatePassword <securestring\>]  
>   -   Export-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-CertificatePassword <securestring\>] [-RelyingPartyTrustIdentifier <string[]>] [-ClaimsProviderTrustIdentifier <string[]>]  
>   -   Export-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-CertificatePassword <securestring\>] [-RelyingPartyTrustName <string[]>] [-ClaimsProviderTrustName <string[]>]  
> 
>   **-RelyingPartyTrustIdentifier <string[]>** - the cmdlet only exports relying party trusts whose identifiers are specified in the string array. The default is to export NONE of the relying party trusts. If none of RelyingPartyTrustIdentifier, ClaimsProviderTrustIdentifier, RelyingPartyTrustName, and ClaimsProviderTrustName is specified, the script will export all relying party trusts and claims provider trusts.  
> 
>   **-ClaimsProviderTrustIdentifier <string[]>** - the cmdlet only exports claims provider trusts whose identifiers are specified in the string array. The default is to export NONE of the claims provider trusts.  
> 
>   **-RelyingPartyTrustName <string[]>** - the cmdlet only exports relying party trusts whose names are specified in the string array. The default is to export NONE of the relying party trusts.  
> 
>   **-ClaimsProviderTrustName <string[]>** - the cmdlet only exports claims provider trusts whose names are specified in the string array. The default is to export NONE of the claims provider trusts.  
> 
>   **-Path <string\>** - the path to a folder that will contain the exported files.  
> 
>   **-ComputerName <string\>** - specifies the STS server host name. The default is the local computer. If you are migrating AD FS 2.0 or AD FS in Windows Server 2012 to AD FS in Windows Server 2012 R2, this is the host name of the legacy AD FS server.  
> 
>   **-Credential <PSCredential\>** - specifies a user account that has permission to perform this action. The default is the current user.  
> 
>   **-Force** – specifies to not prompt for user confirmation.  
> 
>   **-CertificatePassword <SecureString\>** - specifies a password for exporting AD FS certificates’ private keys. If not specified, the script will prompt for a password if an AD FS certificate with private key needs to be exported.  
> 
>   **Inputs**: None  
> 
>   **Outputs**: string - this cmdlet returns the export folder path. You can pipe the returned object to Import-FederationConfiguration.  
  
###  To back up custom attribute stores  
  
1.  You must manually export all custom attribute stores that you want to keep in your new AD FS farm in Windows Server 2012 R2.  
  
> [!NOTE]
>  In Windows Server 2012 R2, AD FS requires custom attribute stores that are based on .NET Framework 4.0 or above. Follow the instructions in [Microsoft .NET Framework 4.5](https://www.microsoft.com/download/details.aspx?id=30653) to install and setup .Net Framework 4.5.  
  
You can find information about custom attribute stores in use by AD FS by running the following Windows PowerShell command: 

``` powershell
Get-ADFSAttributeStore
```  

The steps to upgrade or migrate custom attribute stores vary.  
  
2. You must also manually export all .dll files of the custom attribute stores that you want to keep in your new AD FS farm in Windows Server 2012 R2. The steps to upgrade or migrate .dll files of custom attribute stores vary.  
  
##  Create a Windows Server 2012 R2 federation server farm  
  
1.  Install the Windows Server 2012 R2 operating system on a computer that you want to function as a federation server and then add the AD FS server role. For more information, see [Install the AD FS Role Service](install-the-ad-fs-role-service.md). Then configure your new federation service either through the Active Directory Federation Service Configuration Wizard or via Windows PowerShell. For more information, see “Configure the first federation server in a new federation server farm” in [Configure a Federation Server](configure-a-federation-server.md).  

While completing this step, you must follow these instructions:  
  
-   You must have Domain Administrator privileges in order to configure your federation service.  
  
-   You must use the same federation service name (farm name) as was used in the AD FS 2.0 or AD FS in Windows Server 2012. If you do not use the same federation service name, the certificates that you backed up will not function in the Windows Server 2012 R2 federation service that you are trying to configure.  
  
-   Specify whether this is a WID or SQL Server federation server farm. If it is a SQL farm, specify the SQL Server database location and instance name.  
  
-   You must provide a pfx file containing the SSL server authentication certificate that you backed up as part of preparing for the AD FS migration process.  
  
-   You must specify the same service account identity that was used in the AD FS 2.0 or AD FS in Windows Server 2012 farm.  
  
2. Once the initial node is configured, you can add additional nodes to your new farm. For more information, see “Add a federation server to an existing federation server farm” in [Configure a Federation Server](configure-a-federation-server.md).  
  
##  Import the original configuration data into the Windows Server 2012 R2 AD FS farm  
 Now that you have an AD FS federation server farm running in Windows Server 2012 R2, you can import the original AD FS configuration data into it.  
  
1.  Import and configure other custom AD FS certificates, including externally enrolled token-signing and token- decryption/encryption certificates, and the service communication certificate if it is different from the SSL certificate.  
  
In the AD FS management console, select **Certificates**. Verify the service communications, token-encryption/decryption, and token-signing certificates by checking each against the values you exported into the certificates.txt file while preparing for the migration.  
  
To change the token-decrypting or token-signing certificates from the default self-signed certificates to external certificates, you must first disable the automatic certificate rollover feature that is enabled by default. To do this, you can use the following Windows PowerShell command:  
  
``` powershell 
Set-ADFSProperties –AutoCertificateRollover $false  
```  
  
2. Configure any custom AD FS service settings such as AutoCertificateRollover or SSO lifetime using the Set-AdfsProperties cmdlet.  
  
3. To import AD FS relying party trusts and claims provider trusts, you must be logged in as Administrator (however, not as the Domain Administrator) onto your federation server and run the following Windows PowerShell script that is located in the \support\adfs folder of the Windows Server 2012 R2 installation CD:  
  
``` powershell 
import-federationconfiguration.ps1  
```  
  
> [!IMPORTANT]
>  The import script takes the following parameters:  
> 
> - Import-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-LogPath <string\>] [-CertificatePassword <securestring\>]  
>   -   Import-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-LogPath <string\>] [-CertificatePassword <securestring\>] [-RelyingPartyTrustIdentifier <string[]>] [-ClaimsProviderTrustIdentifier <string[]>  
>   -   Import-FederationConfiguration.ps1 -Path <string\> [-ComputerName <string\>] [-Credential <pscredential\>] [-Force] [-LogPath <string\>] [-CertificatePassword <securestring\>] [-RelyingPartyTrustName <string[]>] [-ClaimsProviderTrustName <string[]>]  
> 
>   **-RelyingPartyTrustIdentifier <string[]>** - the cmdlet only imports relying party trusts whose identifiers are specified in the string array. The default is to import NONE of the relying party trusts. If none of RelyingPartyTrustIdentifier, ClaimsProviderTrustIdentifier, RelyingPartyTrustName, and ClaimsProviderTrustName is specified, the script will import all relying party trusts and claims provider trusts.  
> 
>   **-ClaimsProviderTrustIdentifier <string[]>** - the cmdlet only imports claims provider trusts whose identifiers are specified in the string array. The default is to import NONE of the claims provider trusts.  
> 
>   **-RelyingPartyTrustName <string[]>** - the cmdlet only imports relying party trusts whose names are specified in the string array. The default is to import NONE of the relying party trusts.  
> 
>   **-ClaimsProviderTrustName <string[]>** - the cmdlet only imports claims provider trusts whose names are specified in the string array. The default is to import NONE of the claims provider trusts.  
> 
>   **-Path <string\>** - the path to a folder that contains the configuration files to be imported.  
> 
>   **-LogPath <string\>** - the path to a folder that will contain the import log file. A log file named “import.log” will be created in this folder.  
> 
>   **-ComputerName <string\>** - specifies host name of the STS server. The default is the local computer. If you are migrating AD FS 2.0 or AD FS in Windows Server 2012 to AD FS in Windows Server 2012 R2, this parameter should be set to the hostname of the legacy AD FS server.  
> 
>   **-Credential <PSCredential\>**- specifies a user account that has permission to perform this action. The default is the current user.  
> 
>   **-Force** – specifies to not prompt for user confirmation.  
> 
>   **-CertificatePassword <SecureString\>** - specifies a password for importing AD FS certificates’ private keys. If not specified, the script will prompt for a password if an AD FS certificate with private key needs to be imported.  
> 
>   **Inputs:** string - this command takes the import folder path as input. You can pipe Export-FederationConfiguration to this command.  
> 
>   **Outputs:** None.  
  
Any trailing spaces in the WSFedEndpoint property of a relying party trust may cause the import script to error. In this case, manually remove the spaces from the file prior to import. For example, these entries cause errors:  
  
    ```  
    <URI N="WSFedEndpoint">https://127.0.0.1:444 /</URI>  
    ```  
  
    ```  
    <URI N="WSFedEndpoint">https://myapp.cloudapp.net:83 /</URI>  
    ```  
  
     They must be edited to:  
  
    ```  
    <URI N="WSFedEndpoint">https://127.0.0.1:444/</URI>  
    ```  
  
    ```  
    <URI N="WSFedEndpoint">https://myapp.cloudapp.net:83/</URI>  
    ```  
> [!IMPORTANT]
>  If you have any custom claim rules (rules other than the AD FS default rules) on the Active Directory claims provider trust in the source system, these will not be migrated by the scripts. This is because Windows Server 2012 R2 has new defaults. Any custom rules must be merged by adding them manually to the Active Directory claims provider trust in the new Windows Server 2012 R2 farm.  
  
4. Configure all custom AD FS endpoint settings. In the AD FS Management console, select **Endpoints**. Check the enabled AD FS endpoints against the list of enabled AD FS endpoints that you exported to a file while preparing for the AD FS migration.  
  
    \- And -  
  
    Configure any custom claim descriptions. In the AD FS Management console, select **Claim Descriptions**. Check the list of AD FS claim descriptions against the list of claim descriptions that you exported to a file while preparing for the AD FS migration. Add any custom claim descriptions included in your file but not included in the default list in AD FS. Note that Claim identifier in the management console maps to the ClaimType in the file.  
  
5. Install and configure all backed up custom attribute stores. As an administrator, ensure any custom attribute store binaries are upgrade to .NET Framework 4.0 or higher before updating the AD FS configuration to point to them.  
  
6. Configure service properties that map to the legacy web.config file parameters.  
  
   -   If **useRelayStateForIdpInitiatedSignOn** was added to the **web.config** file in your AD FS 2.0 or AD FS in Windows Server 2012 farm, then you must configure the following service properties in your AD FS in Windows Server 2012 R2 farm:  
  
       -   AD FS in Windows Server 2012 R2 includes a **%systemroot%\ADFS\Microsoft.IdentityServer.Servicehost.exe.config** file. Create an element with the same syntax as the **web.config** file element: `<useRelayStateForIdpInitiatedSignOn enabled="true" />`. Include this element as part of **<microsoft.identityserver.web>** section of the **Microsoft.IdentityServer.Servicehost.exe.config** file.  
  
   -   If **<persistIdentityProviderInformation enabled="true&#124;false" lifetimeInDays="90" enablewhrPersistence=”true&#124;false”  /\>** was added to the **web.config** file in your AD FS 2.0 or AD FS in Windows Server 2012 farm, then you must configure the following service properties in your AD FS in Windows Server 2012 R2 farm:  
  
       1.  In AD FS in Windows Server 2012 R2, run the following Windows PowerShell command: `Set-AdfsWebConfig –HRDCookieEnabled –HRDCookieLifetime`.  
  
   -   If **<singleSignOn enabled="true&#124;false" /\>** was added to the **web.config** file in your AD FS 2.0 or AD FS in Windows Server 2012 farm, you do not need to set any additional service properties in your AD FS in Windows Server 2012 R2 farm. Single sign-on is enabled by default in AD FS in Windows Server 2012 R2 farm.  
  
   -   If localAuthenticationTypes settings were added to the **web.config** file in your AD FS 2.0 or AD FS in Windows Server 2012 farm, then you must configure the following service properties in your AD FS in Windows Server 2012 R2 farm:  
  
       -   Integrated, Forms, TlsClient, Basic Transform list into equivalent AD FS in Windows Server 2012 R2 has global authentication policy settings to support both federation service and proxy authentication types. These settings can be configured in the AD FS in Management snap-in under the **Authentication Policies**.  
  
   After you import the original configuration data, you can customize the AD FS sign in pages as needed. For more information, see [Customizing the AD FS Sign-in Pages](../operations/AD-FS-Customization-in-Windows-Server-2016.md).  
  
## Next Steps
 [Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2](migrate-ad-fs-service-role-to-windows-server-r2.md)   
 [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)   
 [Migrating the AD FS Federation Server Proxy](migrate-fed-server-proxy-r2.md)   
 [Verifying the AD FS Migration to Windows Server 2012 R2](verify-ad-fs-migration.md)
---
title: Migrate a stand-alone AD FS federation server or a single-node AD FS farm
description: Provides information on migrating a stand alone or single-node AD FS 2.0 server to Windows Server 2012
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---



# Migrate a stand-alone AD FS federation server or a single-node AD FS farm  
This document provides detailed information on migrating an AD FS 2.0 stand alone server to Windows Server 2012.

## Migrate a stand-alone AD FS 2.0 server

Use the following procedure to migrate the AD FS 2.0 server to Windows Server 2012.
  
1.  Review and perform the procedures in [Prepare to migrate a stand-alone AD FS federation server or a single-node AD FS farm](prepare-to-migrate-a-stand-alone-ad-fs-federation-server.md).  
  
2.  Perform an in-place upgrade of the operating system on your server from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](https://technet.microsoft.com/library/jj134246.aspx).  
  
> [!IMPORTANT]
>  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
3. Create the original AD FS configuration. You can create the original AD FS configuration by using either of the following methods:  
  
-   Use the **AD FS Federation Server Configuration Wizard** to create a new federation server. For more information, see [Create the First Federation Server in a Federation Server Farm](Create-the-First-Federation-Server-in-a-Federation-Server-Farm.md).  
  
As you go through the wizard, use the information you gathered while preparing to migrate your AD FS federation server as follows:  
  
 |**Federation Server Configuration Wizard input option**|**Use the following value**| 
|-----|-----| 
|**SSL Certificate** on the **Specify the Federation Service Name** page|Select the SSL certificate whose subject name and thumbprint you recorded while preparing for the AD FS federation server migration.|  
|**Service account** and **Password** on the **Specify a Service Account** page|Enter the service account information that you recorded while preparing for the AD FS federation server migration. **Note:**  If you select stand-alone federation server on the second page of the wizard, NETWORK SERVICE is used automatically as the service account.|  
  
> [!IMPORTANT] 
> You can employ this method only if you are using Windows Internal Database (WID) to store the AD FS configuration database for your stand-alone federation server or a single-node AD FS farm.  
>
>  If you are using SQL Server to store the AD FS configuration database for your single-node AD FS farm, you must use Windows PowerShell to create the original AD FS configuration on your federation server.  
  
-   Use Windows PowerShell  
  
> [!IMPORTANT]
>  You must use Windows PowerShell if you are using SQL Server to store the AD FS configuration database for your stand-alone federation server or a single-node AD FS farm.  
  
The following is an example of how to use Windows PowerShell to create the original AD FS configuration on a federation server in a single-node SQL Server farm.  Open the Windows PowerShell module and run the following command: `$fscredential = Get-Credential`. Enter the name and the password of the service account that you recorded while preparing your SQL server farm for migration. Then run the following command: `C:\PS> Add-AdfsFarmNode -ServiceAccountCredential $fscredential -SQLConnectionString "Data Source=<Data Source>;Integrated Security=True"` where `Data Source` is the data source value in the policy store connection string value in the following file: `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config`.  
  
4. Restore the remaining AD FS service settings and trust relationships. This is a manual step during which you can use the files that you exported and the values that you collected while preparing for the AD FS migration. For detailed instructions, see Restoring the Remaining AD FS Farm Configuration.  
  
> [!NOTE]
>  This step is only required if you are migrating a stand-alone federation server or a single node WID farm.  If the federation server uses a SQL Server database as the configuration store, the service settings and trust relationships are preserved in the database.  
  
5. Update your AD FS webpages. This is a manual step. If you backed up your customized AD FS webpages while preparing for the migration, use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
6. Restore any remaining AD FS customizations, such as custom attribute stores.  
  
## Restoring the Remaining AD FS Farm Configuration  
  
-   Restore the following AD FS service settings to a single node WID farm or stand-alone federation service as follows:  
  
    -   In the AD FS management console, select **Service** and click **Edit Federation Service…**. Verify the federation service settings by checking each of the values against the values you exported into the properties.txt file while preparing for the migration:  
  
    
|**Federation Service Property name as reported by Get-ADFSProperties**|**Federation Service Property name in AD FS Management console**|  
|-----|-----|
|DisplayName|Federation Service display name|  
|HostName|Federation Service name|  
|Identifier|Federation Service identifier|  
  
-   In the AD FS management console, select **Certificates**. Verify the service communications, token-decrypting, and token-signing certificates by checking each against the values you exported into the certificates.txt file while preparing for the migration.  
  
To change the token-decrypting or token-signing certificates from the default self-signed certificates to external certificates, you must first disable the automatic certificate rollover feature that is enabled by default.  To do this, you can use the following Windows PowerShell command: `PSH: Set-ADFSProperties –AutoCertificateRollover $false`.  
  
-   In the AD FS Management console, select **Endpoints**. Check the enabled AD FS endpoints against the list of enabled AD FS endpoints that you exported to a file while preparing for the AD FS migration.  
  
-   In the AD FS Management console, select **Claim Descriptions**. Check the list of AD FS claim descriptions against the list of  claim descriptions that you exported to a file while preparing for the AD FS migration. Add any custom claim descriptions included in your file but not included in the default list in AD FS.  Note that Claim identifier in the management console maps to the ClaimType in the file.  For more information on adding claim descriptions, see [Add a Claim Description](../operations/add-a-claim-description.md). For more information, see the “Step 1 - Export Service Settings” section in Prepare to Migrate the AD FS 2.0 Federation Server.  
  
-   In the AD FS Management console, select **Claims Provider Trusts**. You must recreate each Claims Provider trust manually using the **Add Claims Provider Trust Wizard**.  Use the list of claims provider trusts that you exported and recorded while preparing for the AD FS migration. You can disregard the claims provider trust with Identifier “AD AUTHORITY” in the file because this is the “Active Directory” claims provider trust that is part of the default AD FS configuration.  However, check for any custom claim rules you may have added to the Active Directory trust prior to the migration. For more information on creating claims provider trusts, see [Create a Claims Provider Trust Using Federation Metadata](../operations/create-a-claims-provider-trust.md#to-create-a-claims-provider-trust-using-federation-metadata) or [Create a Claims Provider Trust Manually](../operations/create-a-claims-provider-trust.md#to-create-a-claims-provider-trust-manually).  
  
-   In the AD FS Management console, **select Relying Party Trusts**. You must recreate each Relying Party trust manually using the **Add Relying Party Trust Wizard**. Use the list of relying party trusts that you exported and recorded while preparing for the AD FS migration. For more information on creating relying party trusts, see [Create a Relying Party Trust Using Federation Metadata](../operations/create-a-relying-party-trust.md#to-create-a-claims-aware-relying-party-trust-using-federation-metadata) or [Create a Relying Party Trust Manually](../operations/create-a-relying-party-trust.md#to-create-a-claims-aware-relying-party-trust-manually). 

## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)




-   
-    
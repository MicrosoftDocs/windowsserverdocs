---
title: Prepare to Migrate the AD FS 2.0 Federation Server to AD FS on Windows Server 2012 R2
description: Provides information on getting ready to migrate the AD FS server to Windows Server 2012 R2.
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/10/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Prepare to Migrate the AD FS 2.0 Federation Server to AD FS on Windows Server 2012 R2

This document describes how to migrate an AD FS 2.0 or Windows Server 2012 federation server farm to a Windows Server 2012 R2 AD FS farm.  The steps can be used with AD FS farms that use either WID or SQL Server as the underlying database.  
  
-   [Migration Process Outline](prepare-migrate-ad-fs-server-r2.md#migration-process-outline)  
  
-   [New AD FS functionality in Windows Server 2012 R2](prepare-migrate-ad-fs-server-r2.md#new-ad-fs-functionality-in-windows-server-2012-r2)  
  
-   [AD FS Requirements in Windows Server 2012 R2](prepare-migrate-ad-fs-server-r2.md#ad-fs-requirements-in-windows-server-2012-r2)  
  
-   [Increasing your Windows PowerShell limits](prepare-migrate-ad-fs-server-r2.md#increasing-your-windows-powershell-limits)  
  
-   [Other migration tasks and considerations](prepare-migrate-ad-fs-server-r2.md#other-migration-tasks-and-considerations)  
  
##  Migration Process Outline

 To complete the migration of your AD FS federation server farm to Windows Server 2012 R2, you must complete the following tasks:  
  
1.  Export, record, and backup the following configuration data in your existing AD FS farm. For detailed instructions on how to complete these tasks, see [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md).  
  
The following settings are migrated with the scripts located in the \support\adfs folder on the Windows Server 2012 R2 installation CD:  
  
-   Claims provider trusts, with the exception of custom claim rules on the Active Directory Claims provider trust. For more information, see [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md).  
  
-   Relying party trusts.  
  
-   AD FS internally generated, self-signed token signing and token decryption certificates.  
  
Any of the following custom settings must be migrated manually:  
  
- Service settings:  
  
  - Non-default token signing and token decryption certificates that were issued by an enterprise or public certification authority.  
  
  - The SSL server authentication certificate used by AD FS.  
  
  - The service communications certificate used by AD FS (by default, this is the same certificate as the SSL certificate.  
  
    -   Non-default values for any federation service properties, such as AutoCertificateRollover or SSO lifetime.  
  
    -   Non-default AD FS endpoint settings and claim descriptions.  
  
-   Custom claim rules on the Active Directory claims provider trust.  
  
    -   AD FS sign-in page customizations  
  
For more information, see [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md).  
  
2. Create a Windows Server 2012 R2 federation server farm.  
  
3. Import the original configuration data into this new Windows Server 2012 R2 AD FS farm.  
  
4. Configure and customize the AD FS sign-in pages.  
  
##  New AD FS functionality in Windows Server 2012 R2  
 The following AD FS functionality changes in Windows Server 2012 R2 impact a migration from AD FS 2.0 or AD FS in Windows Server 2012:  
  
**IIS dependency**  
   - AD FS in Windows Server 2012 R2 is self-hosted and does not require IIS installation. Make sure you note the following as a result of this change:  
   -   SSL certificate management for both federation servers and proxy computers in your AD FS farm must now be performed via Windows PowerShell.  
  
**Changes to AD FS sign-in pages’ settings and customizations**  
-   In AD FS in Windows Server 2012 R2, there are several changes intended to improve the sign-in experience for both administrators and users. The IIS-hosted web pages that existed in the previous version of AD FS are now removed. The look and feel of the AD FS sign-in web pages are self-hosted in AD FS and can now be customized to tailor the user experience. The changes include:  
	-   Customizing the AD FS sign-in experience, including the customization of the company name, logo, illustration, and sign-in description.  
    -   Customizing the error messages.  
    -   Customizing the ADFS Home Realm Discovery experience, which includes the following:  
        -   Configuring your identity provider to use certain email suffixes.  
        -   Configuring an identity provider list per relying party.  
        -   Bypassing Home Realm Discovery for intranet.  
        -   Creating custom web themes.  
  
For detailed instructions on configuring the look and feel of the AD FS sign-in pages, see [Customizing the AD FS Sign-in Pages](../operations/AD-FS-Customization-in-Windows-Server-2016.md).  
  
If you have web page customization in your existing AD FS farm that you want to migrate to Windows Server 2012 R2, you can recreate them as part of the migration process using the new customization features in Windows Server 2012 R2.  
  
-   **Other changes**  
  
    -   AD FS in Windows Server 2012 R2 is based on Windows Identity Foundation (WIF) 3.5, not WIF 4.5. Therefore, some specific features of WIF 4.5 (for example, Kerberos claims and dynamic access control) are not supported in AD FS in Windows Server 2012 R2.  
  
    -   Device Registration Service (DRS) in Windows Server 2012 R2 operates on port 443; ClientTLS for user certificate authentication operates on port 49443  
  
        -   For active, non-browser clients using certificate transport mode authentication that are specifically hard-coded to point to port 443, a code change is required to continue to use user certificate authentication on port 49443.  
  
        -   For passive applications no change is required because AD FS redirects to the correct port for user certificate authentication.  
  
        -   Firewall ports between the client and the proxy must enable port 49443 traffic to pass through for user certificate authentication.  
  
##  AD FS Requirements in Windows Server 2012 R2  
 In order to successfully migrate your AD FS farm to Windows Server 2012 R2, you must meet the following requirements:  
  
 For AD FS to function, each computer that you want to be a federation must be joined to a domain.  
  
 For AD FS running on Windows Server 2012 R2 to function, your Active Directory domain must run either of the following:  
  
- Windows Server 2012 R2  
  
- Windows Server 2012  
  
- Windows Server 2008 R2  
  
- Windows Server 2008  
  
  If you plan to use a group Managed Service Account (gMSA) as the service account for AD FS, you must have at least one domain controller in your environment that is running on Windows Server 2012 or Windows Server 2012 R2 operating system.  
  
  If you plan to deploy Device Registration Service (DRS) for AD Workplace Join as a part of your AD FS deployment, the AD DS schema needs to be updated to the Windows Server 2012 R2 level. There are three ways to update the schema:  
  
1.  In an existing Active Directory forest, run adprep /forestprep from the \support\adprep folder of the Windows Server 2012 R2 operating system DVD on any 64-bit server that runs Windows Server 2008 or later. In this case, no additional domain controller needs to be installed, and no existing domain controllers need to be upgraded.  
  
To run adprep/forestprep, you must be a member of the Schema Admins group, the Enterprise Admins group, and the Domain Admins group of the domain that hosts the schema master.  
  
2. In an existing Active Directory forest, install a domain controller that runs Windows Server 2012 R2. In this case, adprep /forestprep runs automatically as part of the domain controller installation.  
  
During the domain controller installation, you may need to specify additional credentials in order to run adprep /forestprep.  
  
3. Create a new Active Directory forest by installing AD DS on a server that runs Windows Server 2012 R2. In this case, adprep /forestprep does not need to be run because the schema will be initially created with all the necessary containers and objects to support DRS.  
  
### SQL Server support for AD FS in Windows Server 2012 R2  
 If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.  
  
##  Increasing your Windows PowerShell limits  
 If you have more than 1000 claims provider trusts and relying party trusts in your AD FS farm, or if you see the following error while trying to run the AD FS migration export/import tool, you must increase your Windows PowerShell limits:  
  
```  
'Exception of type 'System.OutOfMemoryException' was thrown. At E:\dev\ds\security\ADFSv2\Product\Migration\Export-FederationConfiguration.ps1:176 char:21 + $configData = Invoke-Command -ScriptBlock $GetConfig -Argume ...  
```  
  
 This error is thrown because the Windows PowerShell session default memory limit is too low. In Windows PowerShell 2.0, the session default memory is 150MB. In Windows PowerShell 3.0, the session default memory is 1024MB. You can verify Windows PowerShell remote session memory limit using the following command: `Get-Item wsman:localhost\Shell\MaxMemoryPerShellMB`. You can increase the limit by running the following command: `Set-Item wsman:localhost\Shell\MaxMemoryPerShellMB 512`.  
  
## Other migration tasks and considerations  
 In order to successfully migrate your AD FS farm to Windows Server 2012 R2, make sure you are aware of the following:  
  
-   The migration scripts located in the \support\adfs folder on the Windows Server 2012 R2 installation CD require that you retain the same federation server farm name and service account identity name that you used in your legacy AD FS farm when you migrate it to Windows Server 2012 R2.  
  
-   If you want to migrate a SQL Server AD FS farm, note that the migration process involves creating a new SQL database instance into which you must import the original configuration data.  
  
## Next Steps
 [Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2](migrate-ad-fs-service-role-to-windows-server-r2.md)   
 [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)   
 [Migrating the AD FS Federation Server Proxy](migrate-fed-server-proxy-r2.md)   
 [Verifying the AD FS Migration to Windows Server 2012 R2](verify-ad-fs-migration.md)
---
title: Migrate the AD FS 2.0 federation server
description:Provides information on getting ready to migrate a stand-alone AD FS server to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Migrate the AD FS 2.0 federation server

This topic provides instructions for the following migration scenarios:  
  
-   [Migrate a stand-alone AD FS federation server or a single-node AD FS farm](../Topic/Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#BKMK_1)  
  
-   [Migrate a WID farm](../Topic/Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#BKMK_2)  
  
-   [Migrate a SQL Server farm](../Topic/Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#BKMK_3)  
  
##  <a name="BKMK_1"></a> Migrate a stand-alone AD FS federation server or a single-node AD FS farm  
 To migrate a stand-alone AD FS federation server or a single-node AD FS farm to Windows Server 2012, perform the following procedure:  
  
1.  Review and perform the procedures in the “Prepare to migrate a stand-alone AD FS federation server or a single-node AD FS farm” section of [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
  
2.  Perform an in-place upgrade of the operating system on your server from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](../Topic/Installing%20Windows%20Server%202012.md).  
  
    > [!IMPORTANT]
    >  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
3.  Create the original AD FS configuration. You can create the original AD FS configuration by using either of the following methods:  
  
    -   Use the **AD FS Federation Server Configuration Wizard** to create a new federation server. For more information, see [Create the First Federation Server in a Federation Server Farm](../Topic/Create%20the%20First%20Federation%20Server%20in%20a%20Federation%20Server%20Farm.md).  
  
         As you go through the wizard, use the information you gathered while preparing to migrate your AD FS federation server as follows:  
  
        |||  
        |-|-|  
        |**Federation Server Configuration Wizard input option**|**Use the following value**|  
        |**SSL Certificate** on the **Specify the Federation Service Name** page|Select the SSL certificate whose subject name and thumbprint you recorded while preparing for the AD FS federation server migration.|  
        |**Service account** and **Password** on the **Specify a Service Account** page|Enter the service account information that you recorded while preparing for the AD FS federation server migration. **Note:**  If you select stand-alone federation server on the second page of the wizard, NETWORK SERVICE is used automatically as the service account.|  
  
        > [!IMPORTANT]
        >  You can employ this method only if you are using Windows Internal Database (WID) to store the AD FS configuration database for your stand-alone federation server or a single-node AD FS farm.  
        >   
        >  If you are using SQL Server to store the AD FS configuration database for your single-node AD FS farm, you must use Windows PowerShell to create the original AD FS configuration on your federation server.  
  
    -   Use Windows PowerShell  
  
        > [!IMPORTANT]
        >  You must use Windows PowerShell if you are using SQL Server to store the AD FS configuration database for your stand-alone federation server or a single-node AD FS farm.  
  
         The following is an example of how to use Windows PowerShell to create the original AD FS configuration on a federation server in a single-node SQL Server farm.  Open the Windows PowerShell module and run the following command: `$fscredential = Get-Credential`. Enter the name and the password of the service account that you recorded while preparing your SQL server farm for migration. Then run the following command: `C:\PS> Add-AdfsFarmNode -ServiceAccountCredential $fscredential -SQLConnectionString "Data Source=<Data Source>;Integrated Security=True"` where `Data Source` is the data source value in the policy store connection string value in the following file: `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config`.  
  
4.  Restore the remaining AD FS service settings and trust relationships. This is a manual step during which you can use the files that you exported and the values that you collected while preparing for the AD FS migration. For detailed instructions, see Restoring the Remaining AD FS Farm Configuration.  
  
    > [!NOTE]
    >  This step is only required if you are migrating a stand-alone federation server or a single node WID farm.  If the federation server uses a SQL Server database as the configuration store, the service settings and trust relationships are preserved in the database.  
  
5.  Update your AD FS webpages. This is a manual step. If you backed up your customized AD FS webpages while preparing for the migration, use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
6.  Restore any remaining AD FS customizations, such as custom attribute stores.  
  
##  <a name="BKMK_2"></a> Migrate a WID farm  
 To migrate a Windows Internal Database (WID) farm to Windows Server 2012, perform the following procedure:  
  
1.  For every node (server) in the WID farm, review and perform the procedures in the “Prepare to migrate a WID farm” section of [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
  
2.  Remove any non-primary nodes from the load balancer.  
  
3.  Upgrade of the operating system on this server from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](../Topic/Installing%20Windows%20Server%202012.md).  
  
    > [!IMPORTANT]
    >  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
4.  Create the original AD FS configuration on this server.  
  
     You can create the original AD FS configuration by using the **AD FS Federation Server Configuration Wizard** to add a federation server to a WID farm. For more information, see [Add a Federation Server to a Federation Server Farm](../Topic/Add%20a%20Federation%20Server%20to%20a%20Federation%20Server%20Farm.md).  
  
    > [!NOTE]
    >  -   When you reach the **Specify the Primary Federation Server and a Service Account** page in the **AD FS Federation Server Configuration Wizard**, enter the name of the primary federation server of the WID farm and be sure to enter the service account information that you recorded while preparing for the AD FS migration. For more information, see the “Prepare to migrate a WID farm” section in [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
    > -   When you reach the **Specify the Federation Service Name** page, be sure to select the same SSL certificate you recorded in the “Prepare to migrate a WID farm” section in [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
  
5.  Update your AD FS webpages on this server. If you backed up your customized AD FS webpages while preparing for the migration, you need to use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
6.  Add the server that you just upgraded to Windows Server 2012 to the load balancer.  
  
7.  Repeat steps 1 through 6 for the remaining secondary servers in your WID farm.  
  
8.  Promote one of the upgraded secondary servers to be the primary server in your WID farm. To do this, open Windows PowerShell and run the following command: `PSH:> Set-AdfsSyncProperties –Role PrimaryComputer`.  
  
9. Remove the original primary server of your WID farm from the load balancer.  
  
10. Demote the original primary server in your WID farm to be a secondary server by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to demote the original primary server to be a secondary server: `PSH:> Set-AdfsSyncProperties – Role SecondaryComputer –PrimaryComputerName <FQDN of the Primary Federation Server>`.  
  
11. Upgrade of the operating system on this last node (server) in your WID farm from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](../Topic/Installing%20Windows%20Server%202012.md).  
  
    > [!IMPORTANT]
    >  As the result of upgrading the operating system, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
12. Create the original AD FS configuration on this last node (server) in your WID farm.  
  
     You can create the original AD FS configuration by using the **AD FS Federation Server Configuration Wizard** to add a federation server to a WID farm. For more information, see [Add a Federation Server to a Federation Server Farm](../Topic/Add%20a%20Federation%20Server%20to%20a%20Federation%20Server%20Farm.md).  
  
    > [!NOTE]
    >  -   When you reach the **Specify the Primary Federation server and a Service Account** page in the **AD FS Federation Server Configuration Wizard**, enter the service account information that you recorded while preparing for the AD FS migration. For more information, see the “Prepare to migrate a WID farm” section in [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
    > -   When you reach the **Specify the Federation Service Name** page, be sure to select the same SSL certificate you recorded in the “Prepare to migrate a WID farm” section in [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
  
13. Update your AD FS webpages on this last server in your WID farm. If you backed up your customized AD FS webpages while preparing for the migration, use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
14. Add this last server of your WID farm that you just upgraded to Windows Server 2012 to the load balancer.  
  
15. Restore any remaining AD FS customizations, such as custom attribute stores.  
  
##  <a name="BKMK_3"></a> Migrate a SQL Server farm  
 To migrate a SQL Server farm to Windows Server 2012, perform the following procedure:  
  
1.  For each server in your SQL Server farm, review and perform the procedures in the “Prepare to migrate a SQL Server farm” section of [Prepare to Migrate the AD FS 2.0 Federation Server](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md).  
  
2.  Remove any server in your SQL Server farm from the load balancer.  
  
3.  Upgrade the operating system on this server in your SQL Server farm from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](../Topic/Installing%20Windows%20Server%202012.md).  
  
    > [!IMPORTANT]
    >  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
4.  Create the original AD FS configuration on this server in your SQL Server farm by using AD FS Windows PowerShell cmdlets to add a server to an existing farm.  
  
    > [!IMPORTANT]
    >  You must use Windows PowerShell to create the original AD FS configuration if you are using SQL Server to store your AD FS configuration database.  
  
    1.  Open Windows PowerShell and run the following command: `$fscredential = Get-Credential`.  
  
    2.  Enter the name and the password of the service account that you recorded while preparing your SQL Server farm for migration.  
  
    3.  Run the following command: `Add-AdfsFarmNode -ServiceAccountCredential $fscredential -SQLConnectionString "Data Source=<Data Source>;Integrated Security=True"`, where `Data Source` is the data source value in the policy store connection string value in the following file: `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config`.  
  
5.  Add the server that you just upgraded to Windows Server 2012 to the load balancer.  
  
6.  Repeat steps 2 through 6 for the remaining nodes in your SQL Server farm.  
  
7.  When all of the servers in your SQL Server farm are upgraded to Windows Server 2012, restore any remaining AD FS customizations, such as custom attribute stores.  
  
##  <a name="BKMK_5"></a> Restoring the Remaining AD FS Farm Configuration  
  
-   Restore the following AD FS service settings to a single node WID farm or stand-alone federation service as follows:  
  
    -   In the AD FS management console, select **Service** and click **Edit Federation Service…**. Verify the federation service settings by checking each of the values against the values you exported into the properties.txt file while preparing for the migration:  
  
        |||  
        |-|-|  
        |**Federation Service Property name as reported by Get-ADFSProperties**|**Federation Service Property name in AD FS Management console**|  
        |DisplayName|Federation Service display name|  
        |HostName|Federation Service name|  
        |Identifier|Federation Service identifier|  
  
    -   In the AD FS management console, select **Certificates**. Verify the service communications, token-decrypting, and token-signing certificates by checking each against the values you exported into the certificates.txt file while preparing for the migration.  
  
         To change the token-decrypting or token-signing certificates from the default self-signed certificates to external certificates, you must first disable the automatic certificate rollover feature that is enabled by default.  To do this, you can use the following Windows PowerShell command: `PSH: Set-ADFSProperties –AutoCertificateRollover $false`.  
  
    -   In the AD FS Management console, select **Endpoints**. Check the enabled AD FS endpoints against the list of enabled AD FS endpoints that you exported to a file while preparing for the AD FS migration.  
  
    -   In the AD FS Management console, select **Claim Descriptions**. Check the list of AD FS claim descriptions against the list of  claim descriptions that you exported to a file while preparing for the AD FS migration. Add any custom claim descriptions included in your file but not included in the default list in AD FS.  Note that Claim identifier in the management console maps to the ClaimType in the file.  For more information on adding claim descriptions, see [Add a Claim Description](../Topic/Add%20a%20Claim%20Description.md). For more information, see the “Step 1 - Export Service Settings” section in Prepare to Migrate the AD FS 2.0 Federation Server.  
  
-   In the AD FS Management console, select **Claims Provider Trusts**. You must recreate each Claims Provider trust manually using the **Add Claims Provider Trust Wizard**.  Use the list of claims provider trusts that you exported and recorded while preparing for the AD FS migration. You can disregard the claims provider trust with Identifier “AD AUTHORITY” in the file because this is the “Active Directory” claims provider trust that is part of the default AD FS configuration.  However, check for any custom claim rules you may have added to the Active Directory trust prior to the migration. For more information on creating claims provider trusts, see [Create a Claims Provider Trust Using Federation Metadata](../Topic/Create%20a%20Claims%20Provider%20Trust%20Using%20Federation%20Metadata.md) or [Create a Claims Provider Trust Manually](../Topic/Create%20a%20Claims%20Provider%20Trust%20Manually.md).  
  
-   In the AD FS Management console, **select Relying Party Trusts**. You must recreate each Relying Party trust manually using the **Add Relying Party Trust Wizard**. Use the list of relying party trusts that you exported and recorded while preparing for the AD FS migration. For more information on creating relying party trusts, see [Create a Relying Party Trust Using Federation Metadata](../Topic/Create%20a%20Relying%20Party%20Trust%20Using%20Federation%20Metadata.md) or [Create a Relying Party Trust Manually](../Topic/Create%20a%20Relying%20Party%20Trust%20Manually.md).  
  
## See Also  
 [Migrate AD FS Role Services to Windows Server 2012](../Topic/Migrate%20Active%20Directory%20Federation%20Services%20Role%20Services%20to%20Windows%20Server%202012.md)
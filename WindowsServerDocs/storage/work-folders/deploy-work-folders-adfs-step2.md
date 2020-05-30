---
title: Deploy Work Folders with AD FS and Web Application Proxy - Step 2, AD FS Post-Configuration Work
ms.prod: windows-server
ms.technology: storage-work-folders
ms.topic: article
manager: klaasl
ms.author: jeffpatt
author: JeffPatt24
ms.date: 06/06/2019
ms.assetid: 0a48852e-48cc-4047-ae58-99f11c273942
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the second step in deploying Work Folders with Active Directory Federation Services (AD FS) and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](deploy-work-folders-adfs-step1.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](deploy-work-folders-adfs-step3.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](deploy-work-folders-adfs-step4.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](deploy-work-folders-adfs-step5.md)  
  
> [!NOTE]
> The instructions covered in this section are for a Windows Server 2019 or Windows Server 2016 environment. If you're using Windows Server 2012 R2, follow the [Windows Server 2012 R2 instructions](https://technet.microsoft.com/library/dn747208(v=ws.11).aspx).

In step 1, you installed and configured AD FS. Now, you need to perform the following post-configuration steps for AD FS.  
  
## Configure DNS entries

You must create two DNS entries for AD FS. These are the same two entries that were used in the pre-installation steps when you created the subject alternative name (SAN) certificate.  
  
The DNS entries are in the form:  
  
-   AD FS service name.domain  
  
-   enterpriseregistration.domain  
  
-   AD FS server name.domain   (DNS entry should already exist. e.g., 2016-ADFS.contoso.com)
  
In the test example, the values are:  
  
-   **blueadfs.contoso.com**  
  
-   **enterpriseregistration.contoso.com**  
  
## Create the A and CNAME records for AD FS

To create A and CNAME records for AD FS, follow these steps:  
  
1.  On your domain controller, open DNS Manager.  
  
2.  Expand the Forward Lookup Zones folder, right-click on your domain, and select **New Host (A)**.  
  
3.  The **New Host** window opens. In the **Name** field, enter the alias for the AD FS service name. In the test example, this is **blueadfs**.  
  
    The alias must be the same as the subject in the certificate that was used for AD FS. For example, if the subject was adfs.contoso.com, then the alias entered here would be **adfs**.  
  
    > [!IMPORTANT]  
    > When you set up AD FS by using the Windows Server user interface (UI) instead of Windows PowerShell, you must create an A record instead of a CNAME record for AD FS. The reason is that the service principal name (SPN) that is created via the UI contains only the alias that is used to set up the AD FS service as the host.  

4.  In **IP address**, enter the IP address for the AD FS server. In the test example, this is **192.168.0.160**. Click **Add Host**.  
  
5.  In the Forward Lookup Zones folder, right-click on your domain again, and select **New Alias (CNAME)**.  
  
6.  In the **New Resource Record** window, add the alias name **enterpriseregistration** and enter the FQDN for the AD FS server. This alias is used for Device Join and must be called **enterpriseregistration**.
  
7.  Click **OK**.  
  
To accomplish the equivalent steps via Windows PowerShell, use the following command. The command must be executed on the domain controller.  
  
```Powershell  
Add-DnsServerResourceRecord  -ZoneName "contoso.com" -Name blueadfs -A -IPv4Address 192.168.0.160   
Add-DnsServerResourceRecord  -ZoneName "contoso.com" -Name enterpriseregistration -CName  -HostNameAlias 2016-ADFS.contoso.com
```  
  
## Set up the AD FS relying party trust for Work Folders

You can set up and configure the relying party trust for Work Folders, even though Work Folders hasn't been set up yet. The relying party trust must be set up to enable Work Folders to use AD FS. Because you're in the process of setting up AD FS, now is a good time to do this step.  
  
To set up the relying party trust:  
  
1.  Open **Server Manager**, on the **Tools** menu, select **AD FS Management**.  
  
2.  In the right-hand pane, under **Actions**, click **Add Relying Party Trust**.  
  
3.  On the **Welcome** page, select **Claims aware** and click **Start**.  
  
4.  On the **Select Data Source** page, select **Enter data about the relying party manually**, and then click **Next**.  
  
5.  In the **Display name** field, enter **WorkFolders**, and then click **Next**.  
  
6.  On the **Configure Certificate** page, click **Next**. The token encryption certificates are optional, and are not needed for the test configuration.  
  
7.  On the **Configure URL** page, click **Next**.  
  
8. On the **Configure Identifiers** page, add the following identifier: `https://windows-server-work-folders/V1`. This identifier is a hard-coded value used by Work Folders, and is sent by the Work Folders service when it is communicating with AD FS. Click **Next**.  
  
9. On the Choose Access Control Policy page, select **Permit Everyone**, and then click **Next**.  
  
10. On the **Ready to Add Trust** page, click **Next**.  
  
11. After the configuration is finished, the last page of the wizard indicates that the configuration was successful. Select the checkbox for editing the claims rules, and click **Close**.  
  
12. In the AD FS snap-in, select the **WorkFolders** relying party trust and click **Edit Claim Issuance Policy** under Actions.

13. The **Edit Claim Issuance Policy for WorkFolders** window opens. Click **Add rule**.  
  
14. In the **Claim rule template** drop-down list, select **Send LDAP Attributes as Claims**, and click **Next**.  
  
15. On the **Configure Claim Rule** page, in the **Claim rule name** field, enter **WorkFolders**.  
  
16. In the **Attribute store** drop-down list, select **Active Directory**.  
  
17. In the mapping table, enter these values:  
  
    -   User-Principal-Name: UPN  
  
    -   Display Name: Name  
  
    -   Surname: Surname  
  
    -   Given-Name: Given Name  
  
18. Click **Finish**. You'll see the WorkFolders rule listed on the Issuance Transform Rules tab and click **OK**.  
  
### Set relying part trust options

After the relying party trust has been set up for AD FS, you must finish the configuration by running five commands in Windows PowerShell. These commands set options that are needed for Work Folders to communicate successfully with AD FS, and can't be set through the UI. These options are:  
  
-   Enable the use of JSON web tokens (JWTs)  
  
-   Disable encrypted claims  
  
-   Enable auto\-update  
  
-   Set the issuing of Oauth refresh tokens to All Devices.  

-   Grant clients access to the relying party trust

To set these options, use the following commands:  
  
```powershell  
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1" -EnableJWT $true   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1" -Encryptclaims $false   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1" -AutoupdateEnabled $true   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1" -IssueOAuthRefreshTokensTo AllDevices
Grant-AdfsApplicationPermission -ServerRoleIdentifier "https://windows-server-work-folders/V1" -AllowAllRegisteredClients -ScopeNames openid,profile  
```  
  
## Enable Workplace Join

Enabling Workplace Join is optional, but can be useful when you want users to be able to use their personal devices to access workplace resources.  
  
To enable device registration for Workplace Join, you must run the following Windows PowerShell commands, which will configure device registration and set the global authentication policy:  
  
```powershell  
Initialize-ADDeviceRegistration -ServiceAccountName <your AD FS service account>
    Example: Initialize-ADDeviceRegistration -ServiceAccountName contoso\adfsservice$
Set-ADFSGlobalAuthenticationPolicy -DeviceAuthenticationEnabled $true   
```  
  
## Export the AD FS certificate

Next, export the self\-signed AD FS certificate so that it can be installed on the following machines in the test environment:  
  
-   The server that is used for Work Folders  
  
-   The server that is used for Web Application Proxy  
  
-   The domain-joined Windows client  
  
-   The non-domain-joined Windows client  
  
To export the certificate, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add/Remove Snap-in**.  
  
4.  In the **Available snap-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: (the computer this console is running on)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder **Console Root\Certificates\(Local Computer)\Personal\Certificates**.  
  
9.  Right-click the **AD FS certificate**, click **All Tasks**, and then click **Export...**.  
  
10. The Certificate Export Wizard opens. Select **Yes, export the private key**.  
  
11. On the **Export File Format** page, leave the default options selected, and click **Next**.  
  
12. Create a password for the certificate. This is the password that you'll use later when you import the certificate to other devices. Click **Next**.  
  
13. Enter a location and name for the certificate, and then click **Finish**.  
  
Installation of the certificate is covered later in the deployment procedure.  
  
## Manage the private key setting

You must give the AD FS service account permission to access the private key of the new certificate. You will need to grant this permission again when you replace the communication certificate after it expires. To grant permission, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add/Remove Snap-in**.  
  
4.  In the **Available snap-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: (the computer this console is running on)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder **Console Root\Certificates\(Local Computer)\Personal\Certificates**.  
  
9.  Right-click the **AD FS certificate**, click **All Tasks**, and then click **Manage Private Keys**.  
  
10. In the **Permissions** window, click **Add**.  
  
11. In the **Object Types** window, select **Service Accounts**, and then click **OK**.  
  
12. Type the name of the account that is running AD FS. In the test example, this is ADFSService. Click **OK**.  
  
13. In the **Permissions** window, give the account at least read permissions, and click **OK**.  
  
If you don't have the option to manage private keys, you might need to run the following command: `certutil -repairstore my *`  
  
## Verify that AD FS is operational

To verify that AD FS is operational, open a browser window and go to `https://blueadfs.contoso.com/federationmetadata/2007-06/federationmetadata.xml`, changing the URL to match your environment.
  
The browser window will display the federation server metadata without any formatting. If you can see the data without any SSL errors or warnings, your federation server is operational.  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](deploy-work-folders-adfs-step3.md)  
  
## See Also  
[Work Folders Overview](Work-Folders-Overview.md)
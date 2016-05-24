---
title: Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a48852e-48cc-4047-ae58-99f11c273942
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work
This topic describes the second step in deploying Work Folders with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-1,-Set-Up-AD-FS.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-3,-Set-Up-Work-Folders.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-4,-Set-Up-Web-Application-Proxy.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-5,-Set-Up-Clients.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy-using-Windows-PowerShell.md)  
  
In step 1, you installed and configured [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. Now, you need to perform the following post\-configuration steps for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
## Configure DNS entries  
You must create two DNS entries for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. These are the same two entries that were used in the pre\-installation steps when you created the subject alternative name \(SAN\) certificate.  
  
The DNS entries are in the form:  
  
*<AD FS service name>.<domain>*  
  
**enterpriseregistration.***<domain>*  
  
*<machine name>.<domain>*  
  
In the test example, the values are:  
  
**blueadfs.contoso.com**  
  
**enterpriseregistration.contoso.com**  
  
## Create the A and CNAME records for AD FS  
To create A and CNAME records for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], follow these steps:  
  
1.  On your domain controller, open DNS Manager.  
  
2.  Expand the Forward Lookup Zones folder, right\-click on your domain, and select **New Host \(A\)**.  
  
3.  The **New Host** window opens. In the **Name** field, enter the alias for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. In the test example, this is **blueadfs**.  
  
    The alias must be the same as the subject in the certificate that was used for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. For example, if the subject was adfs.contso.com, then the alias entered here would be **adfs**.  
  
    > [!IMPORTANT]  
    > When you set up [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] by using the Windows Server UI instead [!INCLUDE[wps_2](../Token/wps_2_md.md)], you must create an A record instead of a CNAME record for AD FS. The reason is that the service principal name \(SPN\) that is created via the UI contains only the alias that is used to set up the AD FS service as the host.  
    >   
    > When you use the configureEnvironment.ps1 [!INCLUDE[wps_2](../Token/wps_2_md.md)] script as described in [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy-using-Windows-PowerShell.md), the **setupadfs** function creates the SPN by including the alias as the host, but also includes two HTTP entries. These entries allow the SPN to redirect from the alias to the host machine.  
  
4.  In **IP address**, enter the IP address for the AD FS server. In the test example, this is **192.168.0.160**. Click **Add Host**.  
  
5.  In the Forward Lookup Zones folder, right\-click on your domain again, and select **New Alias \(CNAME\)**.  
  
6.  In the **New Resource Record** window, add the alias name **enterpriseregistration**. This alias is used for Device Join and must be called **enterpriseregistration**.  
  
7.  Click **OK**.  
  
To accomplish the equivalent steps via [!INCLUDE[wps_2](../Token/wps_2_md.md)], use the following command. The command must be executed on the domain controller.  
  
```powershell  
Add-DnsServerResourceRecord  -ZoneName "contoso.com" -Name blueadfs -A -IPv4Address 192.168.0.160   
Add-DnsServerResourceRecord  -ZoneName "contoso.com" -Name enterpriseregistration -CName  -HostNameAlias 2012R2-ADFS.contoso.com   
```  
  
## Set up the AD FS relying party trust for Work Folders  
You can set up and configure the relying party trust for Work Folders, even though Work Folders hasn't been set up yet. The relying party trust must be set up to enable Work Folders to use AD FS. Because you’re in the process of setting up AD FS, now is a good time to do this step.  
  
To set up the relying party trust:  
  
1.  In Server Manager, on the **Tools** menu, select **AD FS Management**.  
  
2.  In the right\-hand pane, under **Actions**, click **Add Relying Party Trust Wizard**.  
  
3.  The first page of the wizard is a Welcome page. Click **Start** to start the wizard.  
  
4.  Select **Enter data about the relying party manually**, and then click **Next**.  
  
5.  In the **Display name** field, enter **WorkFolders**, and then click **Next**.  
  
6.  Select the AD FS profile option for creating the relying party trust, and click **Next**.  
  
7.  On the **Configure Certificate** page, click **Next**. The token encryption certificates are optional, and are not needed for the test configuration.  
  
8.  On the **Configure URL** page, click **Next**.  
  
9. On the **Configure Identifiers** page, set the relying party trust identifier to **https:\/\/windows\-server\-work\-folders\/V1**. This identifier is a hard\-coded value used by Work Folders, and is sent by the Work Folders service when it is communicating with AD FS. Click **Next**.  
  
10. On the **Configure Multi\-Factor Authentication** page, click **Next**.  
  
11. On the **Issuance Authorization** page, select **Permit all users to access the relying party**, and click **Next**.  
  
12. On the **Ready to Add Trust** page, click **Next**.  
  
13. After the configuration is finished, the last page of the wizard indicates that the configuration was successful. Select the checkbox for editing the claims rules, and click **Close**.  
  
14. The **Edit Claim Rules** window opens. Click **Add rule**.  
  
15. In the **Claim rule template** drop\-down list, select **Send LDAP Attributes as Claims**, and click **Next**.  
  
16. On the **Configure Claim Rule** page, in the **Claim rule name** field, enter **WorkFolders**.  
  
17. In the **Attribute store** drop\-down list, select **Active Directory**.  
  
18. In the mapping table, enter these values:  
  
    -   User\-Principal\-Name: UPN  
  
    -   Display Name: Name  
  
    -   Surname: Surname  
  
    -   Given\-Name: Given Name  
  
19. Click **Finish**. You'll see your new rule listed on the **Issuance Transform Rules** tab.  
  
20. Click the **Issuance Authorization Rules** tab. You'll see that the rule for access is set to **Permit Access to All Users**.  
  
### Set relying part trust options  
After the relying party trust has been set up for AD FS, you must finish the configuration by running four commands in [!INCLUDE[wps_2](../Token/wps_2_md.md)]. These commands set options that are needed for Work Folders to communicate successfully with AD FS, and can't be set through the UI. These options are:  
  
-   Enable the use of JSON web tokens \(JWTs\)  
  
-   Disable encrypted claims  
  
-   Enable auto\-update  
  
-   Set the issuing of Oauth refresh tokens to All Devices.  
  
To set these options, use the following commands:  
  
```powershell  
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1"   
-EnableJWT  $true   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1"   
-Encryptclaims  $false   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1"   
-AutoupdateEnabled  $true   
Set-ADFSRelyingPartyTrust -TargetIdentifier "https://windows-server-work-folders/V1"   
-IssueOAuthRefreshTokensTo  AllDevices  
```  
  
## Enable Workplace Join  
Enabling Workplace Join is optional, but can be useful when you want users to be able to use their personal devices to access workplace resources.  
  
To enable device registration for Workplace Join, you must run the following three [!INCLUDE[wps_2](../Token/wps_2_md.md)] commands, which will configure device registration and set the global authentication policy:  
  
```powershell  
Initialize-ADDeviceRegistration -ServiceAccountName <your AD FS service name>  
Enable-ADFSDeviceRegistration  
Set-ADFSGlobalAuthenticationPolicy -DeviceAuthenticationEnabled $true   
```  
  
## <a name="step1"></a>Export the AD FS certificate  
Next, export the self\-signed AD FS certificate so that it can be installed on the following machines in the test environment:  
  
-   The server that is used for Work Folders  
  
-   The server that is used for Web Application Proxy  
  
-   The domain\-joined [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] client  
  
-   The non\-domain\-joined [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] client  
  
To export the certificate, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
4.  In the **Available snap\-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap\-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: \(the computer this console is running on\)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder Console Root\\Certificates \(Local Computer\)\\Personal\\Certificates.  
  
9. Right\-click **Certificates**, click **All Tasks**, and then click **Export...**.  
  
10. The Certificate Export Wizard opens. Select **Yes, export the private key**.  
  
11. On the **Export File Format** page, leave the default options selected, and click **Next**.  
  
12. Create a password for the certificate. This is the password that you'll use later when you import the certificate to other devices. Click **Next**.  
  
13. Enter a location and name for the certificate, and then click **Finish**.  
  
Installation of the certificate is covered later in the deployment procedure.  
  
## Manage the private key setting  
You must give the AD FS service account permission to access the private key of the new certificate. You will need to grant this permission again when you replace the communication certificate after it expires. To grant permission, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
4.  In the **Available snap\-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap\-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: \(the computer this console is running on\)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder Console Root\\Certificates \(Local Computer\)\\Personal\\Certificates.  
  
9. Right\-click **Certificates**, click **All Tasks**, and then click **Manage Private Keys**.  
  
10. In the **Permissions** window, click **Add**.  
  
11. In the **Object Types** window, select **Service Accounts**, and then click **OK**.  
  
12. Type the name of the account that is running AD FS. In the test example, this is ADFSService. Click **OK**.  
  
13. In the **Permissions** window, give the account at least read permissions, and click **OK**.  
  
If you don't have the option to manage private keys, you might need to run the following command: `certutil -repairstore my *`  
  
## Verify that AD FS is operational  
To verify that AD FS is operational, open a browser window and go to https:\/\/blueadfs.contoso.com\/federationmetadata\/2007\-06\/federationmetadata.xml.  
  
The browser window will display the federation server metadata without any formatting. If you can see the data without any SSL errors or warnings, your federation server is operational.  
  
You can also browse to the AD FS sign\-in page where your federation service name is appended with **adfs\/ls\/idpinitiatedsignon.htm**, for example, https:\/\/blueadfs.contoso.com\/adfs\/ls\/idpinitiatedsignon.htm. When the page opens, you will be asked to sign in. You should be able to sign in to the contoso domain with administrator credentials.  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-3,-Set-Up-Work-Folders.md)  
  
## See Also  
[Work Folders Overview](../Topic/Work-Folders-Overview.md)  
  

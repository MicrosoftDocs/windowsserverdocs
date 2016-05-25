---
title: Obtain and Configure an SSL Certificate for AD FS
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5809a29-0be5-4369-8882-f7307c6c68a5
author: billmath
---
# Obtain and Configure an SSL Certificate for AD FS
Certificates play the most critical role in securing communications between federation servers, Web Application Proxies, claims\-aware applications, and Web clients. This topic describes the steps required to obtain and configure the Secure Sockets Layer \(SSL\) certificate for your federation service. In other words, the SSL certificate in your existing AD FS farm is nearing expiration and you want to obtain another certificate and configure it as the SSL certificate in your AD FS farm. The SSL certificate is used for securing communications between federation servers and clients. For more information, see the “Certificate requirements” section in [AD FS Requirements](../Topic/AD-FS-Requirements.md).  
  
> [!NOTE]  
> Whether you are obtaining a new SSL certificate from a third party or from an enterprise certification authority \(CA\), ensure the certificate has subject alternative name entries of type DNS for each of the following:  
>   
> -   Your federation service name, such as **fs.contoso.com** \(or an appropriate wildcard entry such as **\*.contoso.com**\)  
> -   If you are using AD FS with Device Registration Service \(DRS\), add an additional SAN of type DNS for each UPN suffix in use in your environment, for example **enterpriseregistration.contoso.com**.  
>   
> It’s recommended that you mark the private key as exportable so that the same certificate can be deployed across each federation server and web application proxy within your AD FS farm. Note that the certificate must be publicly trusted \(chain to a publicly trusted root CA\).  
  
-   [Obtain an SSL certificate from AD CS](../Topic/Obtain-and-Configure-an-SSL-Certificate-for-AD-FS.md#BKMK_1)  
  
-   [Configure the obtained certificate as the SSL certificate for AD FS](../Topic/Obtain-and-Configure-an-SSL-Certificate-for-AD-FS.md#BKMK_2)  
  
## <a name="BKMK_1"></a>Obtain an SSL certificate from AD CS  
Perform the following procedures to obtain a new SSL certificate from AD CS. In order to complete these, you must deploy and configure AD CS in your environment. For more information, see [Active Directory Certificate Services Overview](assetId:///e37b2335-0796-449f-aaf4-0520e508f47d).  
  
#### Configure a template  
  
1.  In the Certificate Templates snap\-in, right\-click the **Web Server** template and select **Duplicate**.  
  
2.  On the **Security** tab, click **Add**.  
  
3.  Click **Object Types**, check **Computers**, and then click **Ok**.  
  
4.  Enter **Domain Computers**.  
  
5.  Click **Check Names** and then lick **OK**.  
  
6.  With **Domain Computers** selected, check read, enroll, and auto\-enroll permissions.  
  
    If you are on a domain controller, repeat the steps above to add read, enroll, and auto\-enroll permissions explicitly to the domain controller by name.  This is because a domain controller is not a member of domain computers.  
  
7.  On the **Request Handling** tab, check the **Allow private key to be exported** box.  
  
8.  On the **General** tab, update the template display name to **SSL Certificate Template** or similar.  
  
9. Click **OK** to save the new template.  
  
#### Assign a template to a CA  
  
1.  Under **Certification Authority \(Local\)**, expand the node with the CA name.  
  
2.  Click to select the **Certificate Templates** container \(under the CA name, not the Certificate Templates snap\-in\).  
  
3.  Right click the container and select **New**, and then **Certificate Template to Issue**.  
  
4.  Select **SSL Certificate Template** and click **OK**.  
  
#### Request and enroll a new SSL certificate for AD FS  
  
1.  Open the MMC window and add the Certificates snap\-in for the local Computer account.  
  
2.  Right\-click the **Personal** node and choose **All Tasks** \-> **Request New Certificate**.  
  
3.  Click **Next** twice to get to the **Request certificates** page.  Your can see the template you created in the previous step.  
  
4.  Click the **More information is required...** link.  
  
5.  Under **Subject name**, under **Type**, select **Common name**.  
  
6.  Enter your federation service name, for example "fs.contoso.com" and then click **Add**.  
  
7.  Under **Alternative name**, under **Type**, select **DNS**.  
  
8.  Using the same process, add a subject alternative name of type DNS for your federation service name, for example, “fs.contoso.com” \(the same name you added above\).  
  
    If you are using AD FS with DRS, add an additional SAN of type DNS for each UPN suffix in use in your environment, for example “enterpriseregistration.contoso.com”.  
  
9. Click the **Private Key** tab.  
  
10. Under **Key options**, ensure the **Make private key exportable** option is checked and click **OK**.  
  
11. Back on the **Request Certificates** wizard page, ensure the checkbox for the template is checked and click **Enroll**.  
  
    You can now see the certificate you requested and enrolled in the Personal store in the Certificates snap\-in.  
  
#### Export the SSL certificate to a .PFX file  
  
1.  In the **Certificates** snap\-in for the Local Machine, click the **Personal** store.  
  
2.  Double\-click the SSL certificate you used for your federation service.  
  
3.  On the **Details** tab, click **Copy to file** and then click **Next** in the wizard.  
  
4.  Ensure .pfx is selected, **Include all certificates in the certification path if possible** and **Export all extended properties** are checked and then click **Next**.  
  
5.  Select **Password**, enter a password, and then click **Next**.  
  
6.  Select a file location and name, click Next, and then click **Finish**.  
  
## <a name="BKMK_2"></a>Configure the obtained certificate as the SSL certificate for AD FS  
Now that you have obtained an SSL certificate and exported it to a .pfx file, you can configure this certificate as the SSL certificate of your AD FS farm.  You do this by installing and configuring this certificate on each node in your AD FS farm.  
  
> [!IMPORTANT]  
> It is recommended to use the same SSL certificate on all federation servers and web application proxy machines in your AD FS farm.  
  
#### Install the new SSL certificate on each federation server in the AD FS farm  
  
1.  Install the new certificate in the local computer personal certificates store on each federation server in your farm by double\-clicking the .PFX file and completing the wizard.  Ensure the certificate is installed in the Local Computer Personal Certificates store on each federation server.  
  
    1.  Open a Windows PowerShell command window and execute the following command to list the contents of the local machine store: `PS:\>dir Cert:\LocalMachine\My`.  
  
    2.  Copy the thumbprint of your new SSL certificate from the output list from the command above, and set the SSL certificate on AD FS using the following command: `PS:\>Set-AdfsSslCertificate –Thumbprint <thumbprint>`.  
  
    3.  Verify the new settings using the following command: `PS:\>Get-AdfsSslCertificate`.  
  
#### Configure the new SSL certificate as the service communication certificate for your AD FS farm  
  
1.  The service communication certificate enables WCF message security for securing communications between federation servers. By default, the SSL certificate in your AD FS farm is also automatically used as the service communications certificate.  \(This is the recommended approach\).  
  
    Now that you have obtained and configured a new certificate as the SSL certificate for your AD FS farm, you need to designate this SSL certificate to also be the service communication certificate in your AD FS farm. **This does not happen automatically**. You can do this via MMC \-> Certificates \-> Set Service Communications Certificate.  
  
2.  The following message will inform you that you need to set the private key permissions correctly on the new certificate: “Ensure that the private key for the chosen certificate is accessible to the service account for this Federation Service on each server in the farm.” Update the permissions on the SSL and the service communication certificates to allow Read access for the AD FS service and DRS services. You have to complete the following procedure on all federation servers in your farm.  
  
    1.  Add the Certificates snap\-in to MMC, select **Computer account** and click **Next**, then select **Local computer** and click **Finish**.  
  
    2.  Expand **Certificates \(Local Computer\)**, expand **Personal**, and select **Certificates**.  
  
    3.  Right\-click your new SSL and Service Communications certificate, select **All Tasks**, and select **Manage Private Keys**.  
  
    4.  Click **Add...**  
  
    5.  Click **Locations...**  
  
    6.  Select the local host name \(not the directory\) and click **OK**.  
  
    7.  In the **Enter the object names** field, type **nt service\\adfssrv** and click **Check names**.  The name should resolve to the service **adfssrv**. Click **OK**.  
  
    8.  If you are using AD FS with DRS, in the **Enter the object names** field, type **nt service\\drs** and click **Check names**.  The name should resolve to the service DRS.  Click **OK**.  
  
    9. Select the service and ensure only Read access is selected. Click OK again.  
  
#### Configure the new SSL certificate for DRS  
  
1.  If you have configured AD FS with DRS, then you must make sure that your new SSL certificate for AD FS is also properly configured for DRS.  
  
    If all of the correct DRS names are in the certificate \(an additional SAN of type DNS for each UPN suffix in use in your environment, for example **enterpriseregistration.contoso.com**\), then there are no additional steps required to configure the SSL certificate for DRS. The `Set-AdfsSslCertificate` will configure the correct bindings for DRS as well.  
  
    Ensure that the correct DRS names are included in the certificate by running the command `Get-AdfsDeviceRegistrationUpnSuffix`, which lists all UPN suffixes in use in the enterprise, and comparing the output to the contents of the SAN of the certificate.  
  
    If any names are missing you will have to obtain a new SSL certificate and re\-execute `Set-AdfsSslCertificate` on each federation server and Web Application Proxy.  
  
    Whenever running, `Set-AdfsSslCertificate`, make sure to update the service communications certificate as well. You can do this via MMC \-> Certificates \-> Set Service Communications Certificate.  
  
#### Install the SSL certificate on each web application proxy  
  
1.  The new SSL certificate must be installed on all nodes of your AD FS farm, including all proxy computers. Therefore, you must install the new SSL certificate in the local machine personal certificates store on each Web Application Proxy in your AD FS farm.  
  
    > [!IMPORTANT]  
    > It is recommended to use the same SSL certificate on all federation servers and web application proxy machines in your AD FS farm.  
  
    Once installed, you can set this SSL certificate as the AD FS proxy certificate by running the following commands: `Set-WebApplicationProxySslCertificate -Thumbprint <thumbprint>` and `Get-WebApplicationProxySslCertificate`.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  

---
title: Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4a11ede0-b000-4188-8190-790971504e17
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy
This topic describes the fourth step in deploying Work Folders with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-1,-Set-Up-AD-FS.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-2,-AD-FS-Post-Configuration-Work.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-3,-Set-Up-Work-Folders.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-5,-Set-Up-Clients.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy-using-Windows-PowerShell.md)  
  
To set up Web Application Proxy for use with Work Folders, use the following procedures.  
  
## Install the AD FS and Work Folder certificates  
You must install the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] and Work Folders certificates that you created earlier \(in step 1, Set up AD FS, and step 3, Set up Work Folders\) into the local computer certificate store on the machine where the Web Application Proxy role will be installed.  
  
Because you’re installing self\-signed certificates that can't be traced back to a publisher in the Trusted Root Certification Authorities certificate store, you must also copy the certificates to that store.  
  
To install the certificates, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
4.  In the **Available snap\-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap\-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: \(the computer this console is running on\)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder Console Root\\Certificates \(Local Computer\)\\Personal\\Certificates.  
  
9. Right\-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
10. Browse to the folder that contains the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] certificate, and follow the instructions in the wizard to import the file and place it in the certificate store.  
  
11. Repeat steps 9 and 10, this time browsing to the Work Folders certificate and importing it.  
  
12. Expand the folder Console Root\\Certificates \(Local Computer\)\\Trusted Root Certification Authorities\\Certificates.  
  
13. Right\-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
14. Browse to the folder that contains the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] certificate, and follow the instructions in the wizard to import the file and place it in the Trusted Root Certification Authorities store.  
  
15. Repeat steps 13 and 14, this time browsing to the Work Folders certificate and importing it.  
  
## Install Web Application Proxy  
To install Web Application Proxy, follow these steps:  
  
1.  On the server where you plan to install the Web Application Proxy, open Server Manager and start the Add Roles and Features Wizard.  
  
2.  Click **Next** on the first and second pages of the wizard.  
  
3.  On the **Select destination server** page, select your server, and then click **Next**.  
  
4.  On the **Select server roles** page, select the Remote Access role, and then click **Next**.  
  
5.  On the **Select role services** page, select **Web Application Proxy**, and then click **Next**.  
  
6.  In the confirmation dialog box, click **Add Features**.  
  
7.  On the **Confirm installation selections** page, click **Install**.  
  
## Configure Web Application Proxy  
To configure Web Application Proxy, follow these steps:  
  
1.  Click the warning flag at the top of Server Manager, and then click the link to open the Web Application Proxy Configuration Wizard.  
  
2.  On the Welcome page, press **Next**.  
  
3.  On the **Federation Server** page, enter the Federation Service name. In the test example, this is **blueadfs.contoso.com**.  
  
4.  Enter the credentials of a local administrator account on the federation servers. Do not enter in domain credentials \(for example, contoso\\administrator\), but local credentials \(for example, administrator\).  
  
5.  On the **AD FS Proxy Certificate** page, select the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] certificate that you imported earlier. In the test case, this is **blueadfs.contoso.com**. Click **Next**.  
  
6.  The confirmation page shows the [!INCLUDE[wps_2](../Token/wps_2_md.md)] command that will execute to configure the service. Click **Configure**.  
  
An option for enabling the Web Application proxy to use OAuth is not available through the wizard and must be done via [!INCLUDE[wps_2](../Token/wps_2_md.md)]. This step is described in the [Web Application Proxy post\-configuration work](assetId:///e0afcc9c-a4aa-40b6-9f57-fdb47dfb933a#PostInstWk) section at the end of this topic.  
  
## Publish the Work Folders web application  
The next step is to publish a web application that will make Work Folders available to web browser clients. To publish the Work Folders web application, follow these steps:  
  
1.  Open Server Manager, and on the **Tools** menu, click **Remote Access** to open the Remote Access Management Console.  
  
2.  Under **Configuration**, click **Web Application Proxy**.  
  
3.  Under **Tasks**, click **Publish**. The Publish New Application Wizard opens.  
  
4.  On the Welcome page, click **Next**.  
  
5.  On the **Preauthentication** page, select **Active Directory Federation Services \(AD FS\)**, and click **Next**.  
  
6.  On the **Relying Party** page, select **Work Folders**, and then click **Next**. This list is published to the Web Application Proxy from AD FS.  
  
7.  On the **Publishing Settings** page, enter the following:  
  
    -   The name you want to use for the web application  
  
    -   The external URL for Work Folders  
  
    -   The name of the Work Folders certificate  
  
    -   The back\-end URL for Work Folders  
  
    By default, the wizard makes the back\-end URL the same as the external URL.  
  
    For the test example, use these values:  
  
    Name: **WorkFolders**  
  
    External URL: **https:\/\/workfolders.contoso.com**  
  
    External certificate: The Work Folders certificate that you installed earlier  
  
    Backend server URL: **https:\/\/workfolders.contoso.com**  
  
8.  The confirmation page shows the [!INCLUDE[wps_2](../Token/wps_2_md.md)] command that will execute to publish the application. Click **Publish**.  
  
    If the publishing is successful, you'll see a confirmation page.  
  
## <a name="PostInstWk"></a>Web Application Proxy post\-configuration work  
If OAuth is not enabled on Web Application Proxy, the clients who connect to Web Application Proxy will receive an error stating that "Data in the stream is not in the proper format."  
  
To enable OAuth, open up an admin [!INCLUDE[wps_2](../Token/wps_2_md.md)] window on the Web Application Proxy machine and execute this command:  
  
```powershell  
Get-WebApplicationProxyApplication -Name <web app name>|Set-WebApplicationProxyApplication  -UseOAuthAuthentication    
```  
  
For the test example, the command looks as follows:  
  
```powershell  
Get-WebApplicationProxyApplication -Name WorkFolders|Set-WebApplicationProxyApplication  -UseOAuthAuthentication    
```  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-5,-Set-Up-Clients.md)  
  
## See Also  
[Work Folders Overview](../Topic/Work-Folders-Overview.md)  
  

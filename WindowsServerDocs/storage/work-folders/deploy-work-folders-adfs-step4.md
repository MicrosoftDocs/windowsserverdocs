---
title: Deploy Work Folders with AD FS and Web Application Proxy - Step 4, Set Up Web Application Proxy
ms.prod: windows-server-threshold
ms.technology: storage-work-folders
ms.topic: article
manager: klaasl
ms.author: jeffpatt
author: JeffPatt24
ms.date: 6/242017
ms.assetid: 4a11ede0-b000-4188-8190-790971504e17
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set-up Web Application Proxy

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the fourth step in deploying Work Folders with Active Directory Federation Services (AD FS) and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](deploy-work-folders-adfs-step1.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](deploy-work-folders-adfs-step2.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](deploy-work-folders-adfs-step3.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](deploy-work-folders-adfs-step5.md)  

> [!NOTE]
>   The instructions covered in this section are for a Windows Server 2019 or Windows Server 2016 environment. If you're using Windows Server 2012 R2, follow the [Windows Server 2012 R2 instructions](https://technet.microsoft.com/library/dn747208(v=ws.11).aspx).

To set up Web Application Proxy for use with Work Folders, use the following procedures.  
  
## Install the AD FS and Work Folder certificates  
You must install the AD FS and Work Folders certificates that you created earlier (in step 1, Set up AD FS, and step 3, Set up Work Folders) into the local computer certificate store on the machine where the Web Application Proxy role will be installed.  
  
Because you're installing self-signed certificates that can't be traced back to a publisher in the Trusted Root Certification Authorities certificate store, you must also copy the certificates to that store.  
  
To install the certificates, follow these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add/Remove Snap-in**.  
  
4.  In the **Available snap-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: (the computer this console is running on)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder **Console Root\Certificates\(Local Computer)\Personal\Certificates**.  
  
9. Right-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
10. Browse to the folder that contains the AD FS certificate, and follow the instructions in the wizard to import the file and place it in the certificate store.  
  
11. Repeat steps 9 and 10, this time browsing to the Work Folders certificate and importing it.  
  
12. Expand the folder **Console Root\Certificates\(Local Computer)\Trusted Root Certification Authorities\Certificates**.  
  
13. Right-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
14. Browse to the folder that contains the AD FS certificate, and follow the instructions in the wizard to import the file and place it in the Trusted Root Certification Authorities store.  
  
15. Repeat steps 13 and 14, this time browsing to the Work Folders certificate and importing it.  
  
## Install Web Application Proxy  
To install Web Application Proxy, follow these steps:  
  
1.  On the server where you plan to install the Web Application Proxy, open **Server Manager** and start the **Add Roles and Features** Wizard.  
  
2.  Click **Next** on the first and second pages of the wizard.  
  
3.  On the **Server Selection** page, select your server, and then click **Next**.  
  
4.  On the **Server Role** page, select the **Remote Access** role, and then click **Next**.  
  
5.  On the Features page and Remote Access page, click **Next**.  
  
6.  On the **Role Services** page, select **Web Application Proxy**, click **Add Features**, and then click **Next**.

7.  On the **Confirm installation selections** page, click **Install**.  
  
## Configure Web Application Proxy  
To configure Web Application Proxy, follow these steps:  
  
1.  Click the warning flag at the top of Server Manager, and then click the link to open the Web Application Proxy Configuration Wizard.  
  
2.  On the Welcome page, press **Next**.  
  
3.  On the **Federation Server** page, enter the Federation Service name. In the test example, this is **blueadfs.contoso.com**.  
  
4.  Enter the credentials of a local administrator account on the federation servers. Do not enter in domain credentials (for example, contoso\administrator), but local credentials (for example, administrator).  
  
5.  On the **AD FS Proxy Certificate** page, select the AD FS certificate that you imported earlier. In the test case, this is **blueadfs.contoso.com**. Click **Next**.  
  
6.  The confirmation page shows the Windows PowerShell command that will execute to configure the service. Click **Configure**.  
  
## Publish the Work Folders web application  
The next step is to publish a web application that will make Work Folders available to clients. To publish the Work Folders web application, follow these steps:  
  
1. Open **Server Manager**, and on the **Tools** menu, click **Remote Access Management** to open the Remote Access Management Console.  
  
2. Under **Configuration**, click **Web Application Proxy**.  
  
3. Under **Tasks**, click **Publish**. The Publish New Application Wizard opens.  
  
4. On the Welcome page, click **Next**.  
  
5. On the **Preauthentication** page, select **Active Directory Federation Services (AD FS)**, and click **Next**.  
  
6. On the **Support Clients** page, select **OAuth2**, and click **Next**.

7. On the **Relying Party** page, select **Work Folders**, and then click **Next**. This list is published to the Web Application Proxy from AD FS.  
  
8. On the **Publishing Settings** page, enter the following and then click **Next**:  
  
   -   The name you want to use for the web application  
  
   -   The external URL for Work Folders  
  
   -   The name of the Work Folders certificate  
  
   -   The back-end URL for Work Folders  
  
   By default, the wizard makes the back-end URL the same as the external URL.  
  
   For the test example, use these values:  
  
   Name: **WorkFolders**  
  
   External URL: **https://workfolders.contoso.com**  
  
   External certificate: **The Work Folders certificate that you installed earlier**  
  
   Backend server URL: **https://workfolders.contoso.com**  
  
9. The confirmation page shows the Windows PowerShell command that will execute to publish the application. Click **Publish**.  
  
10. On the **Results** page, you should see the application was published successfully.
    >[!NOTE]
    > If you have multiple Work Folders servers, you need to publish a Work Folders web application for each Work Folders server (repeat steps 1-10).  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](deploy-work-folders-adfs-step5.md)  
  
## See Also  
[Work Folders Overview](Work-Folders-Overview.md)  
  


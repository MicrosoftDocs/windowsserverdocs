---
title: Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f168292b-0dbc-44b9-965f-d480e5134a0c
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients
This topic describes the fifth step in deploying Work Folders with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-1,-Set-Up-AD-FS.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-2,-AD-FS-Post-Configuration-Work.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-3,-Set-Up-Work-Folders.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy--Step-4,-Set-Up-Web-Application-Proxy.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy-using-Windows-PowerShell.md)  
  
Use the following procedures to set up domain\-joined and non\-domain joined clients that are running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]. You can use these clients to test whether files are syncing correctly between the clients' Work Folders.  
  
## Set up a domain\-joined client  
  
### Install the AD FS and Work Folder certificates  
You must install the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] and Work Folders certificates that you created earlier into the local computer certificate store on the domain\-joined client machine.  
  
Because you are installing self\-signed certificates that can't be traced back to a publisher in the Trusted Root Certification Authorities certificate store, you must also copy the certificates to that store.  
  
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
  
### Configure Work Folders on the client  
To configure Work Folders on the client machine, follow these steps:  
  
1.  On the client machine, open Control Panel and click **Work Folders**.  
  
2.  Click **Set up Work Folders**.  
  
3.  On the **Enter your work email address** page, you can enter either the user's email address \(for example, user@contoso.com\) or the Work Folders URL \(in the test example, https:\/\/workfolders.contoso.com\). Enter the address you want to use, and then click **Next**.  
  
4.  [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] displays a credentials prompt. When the user is on\-premises, the authentication is performed by Windows Integrated Authentication. When the user is off\-premises, the authentication is performed by OAuth, and users will see a different screen. Enter your credentials, and click **OK**.  
  
5.  After you have authenticated, the **Introducing Work Folders** page is displayed, where you can optionally change the Work Folders document location. Click **Next**.  
  
6.  The **Security Policies** page lists the security policies that you set up for Work Folders. Click **Next**.  
  
7.  A message is displayed stating that Work Folders has started syncing with your PC. Click **Close**.  
  
8.  The **Manage Work Folders** page shows the amount of space available on the server, sync status, and so on. If necessary, you can re\-enter your credentials here. Close the window.  
  
9. Your Work Folders folder opens automatically. You can add content to this folder to sync between your devices.  
  
    For the purpose of the test example, add a test file to this Work Folders folder. After you set up Work Folders on the non\-domain\-joined machine, you will be able to sync files between the Work Folders on each machine.  
  
## Set up a non\-domain\-joined client  
  
### Install the AD FS and Work Folder certificates  
Install the AD FS and Work Folders certificates on the non\-domain\-joined machine, using the same procedure that you used for the domain\-joined machine.  
  
### Update the hosts file  
The hosts file on the non\-domain\-joined client must be updated for the test environment, because no public DNS records were created for Work Folders. Add these entries to the hosts file:  
  
**workfolders.***<domain>*  
  
*<AD FS service name>.<domain>*  
  
**enterpriseregistration.***<domain>*  
  
For the test example, use these values:  
  
**10.0.0.10 workfolders.contoso.com**  
  
**10.0.0.10 blueadfs.contoso.com**  
  
**10.0.0.10 enterpriseregistration.contoso.com**  
  
### Configure Work Folders on the client  
Configure Work Folders on the non\-domain\-joined machine by using the same procedure that you used for the domain\-joined machine.  
  
When the new Work Folders folder opens on this client, you can see that the file from the domain\-joined machine has already synced to the non\-domain\-joined machine. You can start adding content to the folder to sync between your devices.  
  
This concludes the procedure for deploying Work Folders, AD FS and Web Application Proxy via the Windows Server UI.  
  
Instructions for using [!INCLUDE[wps_2](../Token/wps_2_md.md)] to automate the deployment can be found in the topic [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy-Work-Folders-with-AD-FS-and-Web-Application-Proxy-using-Windows-PowerShell.md).  
  
## See Also  
[Work Folders Overview](../Topic/Work-Folders-Overview.md)  
  

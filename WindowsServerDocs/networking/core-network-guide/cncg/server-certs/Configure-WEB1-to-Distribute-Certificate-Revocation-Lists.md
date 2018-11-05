---
title: Configure WEB1 to Distribute Certificate Revocation Lists (CRLs)
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: fa4a8c41-8c2a-425c-8511-736fe5d196ac
ms.prod: windows-server-threshold
ms.technology: networking
ms.author: pashort
author: shortpatti
---
# Configure WEB1 to Distribute Certificate Revocation Lists (CRLs)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to configure the web server WEB1 to distribute CRLs.  
  
In the extensions of the root CA, it was stated that the CRL from the root CA would be available via https://pki.corp.contoso.com/pki. Currently, there is not a PKI virtual directory on WEB1, so one must be created.  
  
To perform this procedure, you must be a member of **Domain Admins**.  
  
> [!NOTE]  
> In the procedure below, replace the user account name, the Web server name, folder names and locations, and other values with those that are appropriate for your deployment.  
  
#### To configure WEB1 to distribute certificates and CRLs  
  
1.  On WEB1, run Windows PowerShell as an administrator, type `explorer c:\`, and then press ENTER. Windows Explorer opens to drive C.   
  
2.  Create a new folder named PKI on the C: drive. To do so, click **Home**, and then click **New Folder**. A new folder is created with the temporary name highlighted. Type **pki** and then press ENTER.  
  
3.  In Windows Explorer, right-click the folder you just created, hover the mouse cursor over **Share with**, and then click **Specific people**. The **File Sharing** dialog box opens.  
  
4.  In **File Sharing**, type **Cert Publishers**, and then click **Add**. The Cert Publishers group is added to the list. In the list, in **Permission Level**, click the arrow next to **Cert Publishers**, and then click **Read/Write**. Click **Share**, and then click **Done**.  
  
5.  Close Windows Explorer.  
  
6.  Open the IIS console. In Server Manager, click **Tools**, and then click **Internet Information Services (IIS) Manager**.  
  
7.  In the Internet Information Services (IIS) Manager console tree, expand **WEB1**. If you are invited to get started with Microsoft Web Platform, click **Cancel**.  
  
8.  Expand **Sites** and then right-click the **Default Web Site** and then click **Add Virtual Directory**.  
  
9. In **Alias**, type **pki**. In **Physical path** type **C:\pki**, then click **OK**.  
  
10. Enable Anonymous access to the pki virtual directory, so that any client can check the validity of the CA certificates and CRLs. To do so:  
  
    1.  In the **Connections** pane, ensure that **pki** is selected.  
  
    2.  On **pki Home** click **Authentication**.  
  
    3.  In the **Actions** pane, click **Edit Permissions**.  
  
    4.  On the **Security** tab, click **Edit**  
  
    5.  On the **Permissions for pki** dialog box, click **Add**.  
  
    6.  In the **Select Users, Computers, Service Accounts, or Groups**, type **ANONYMOUS LOGON; Everyone** and then click **Check Names**. Click **OK**.  
  
    7.  Click **OK** on the **Select Users, Computers, Service Accounts or Groups** dialog box.  
  
    8.  Click **OK** on the **Permissions for pki** dialog box.  
  
11. Click **OK** on the **pki Properties** dialog box.  
  
12. In the **pki Home** pane, double-click **Request Filtering**.  
  
13. The **File Name Extensions** tab is selected by default in the **Request Filtering** pane. In the **Actions** pane, click **Edit Feature Settings**.  
  
14. In **Edit Request Filtering Settings**, select **Allow double escaping** and then click **OK**.  
  
15. In the Internet Information Services (IIS) Manager MMC, click your Web server name. For example, if your Web server is named WEB1, click **WEB1**.  
  
16. In **Actions**, click **Restart**. Internet services are stopped and then restarted.  
  


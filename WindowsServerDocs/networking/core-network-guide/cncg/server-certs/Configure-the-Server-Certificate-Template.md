---
title: Configure the Server Certificate Template
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: 8ff610e2-43ca-407f-a828-06d9366e02f0
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Configure the Server Certificate Template

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to configure the certificate template that Active Directory&reg; Certificate Services (AD CS) uses as the basis for server certificates that are enrolled to servers on your network.  
  
While configuring this template, you can specify the servers by Active Directory group that should automatically receive a server certificate from AD CS.   
  
The procedure below includes instructions for configuring the template to issue certificates to all of the following server types:  
  
- Servers that are running the Remote Access service, including RAS Gateway servers, that are members of the **RAS and IAS Servers** group.  
- Servers that are running the Network Policy Server (NPS) service that are members of the **RAS and IAS Servers** group.  
  
Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.  
  
### To configure the certificate template  
  
1.  On CA1, in Server Manager, click **Tools**, and then click **Certification Authority**. The Certification Authority Microsoft Management Console (MMC) opens.  
  
2.  In the MMC, double-click the CA name, right-click **Certificate Templates**, and then click **Manage**.  
  
3.  The Certificate Templates console opens. All of the certificate templates are displayed in the details pane.  
  
4.  In the details pane, click the **RAS and IAS Server** template.  
  
5.  Click the **Action** menu, and then click **Duplicate Template**. The template **Properties** dialog box opens.  
  
6.  Click the **Security** tab.   
  
7.  On the **Security** tab, in **Group or user names**, click **RAS and IAS servers**.  
  
8.  In **Permissions for RAS and IAS servers**, under **Allow**, ensure that **Enroll** is selected, and then select the **Autoenroll** check box. Click **OK**, and close the Certificate Templates MMC.  
  
9.  In the Certification Authority MMC, click **Certificate Templates**. On the **Action** menu, point to **New**, and then click **Certificate Template to Issue**. The **Enable Certificate Templates** dialog box opens.  
  
10. In **Enable Certificate Templates**, click the name of the certificate template that you just configured, and then click **OK**. For example, if you did not change the default certificate template name, click **Copy of RAS and IAS Server**, and then click **OK**.  
  



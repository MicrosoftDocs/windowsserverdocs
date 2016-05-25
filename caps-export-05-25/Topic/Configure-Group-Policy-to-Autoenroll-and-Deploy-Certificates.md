---
title: Configure Group Policy to Autoenroll and Deploy Certificates
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65be4f39-93fe-4ebf-86b4-a6a00b19b601
author: vhorne
---
# Configure Group Policy to Autoenroll and Deploy Certificates
You can use this procedure to configure Group Policy to automatically enroll client computer certificates and deploy them to the workstations on your network. Follow this procedure for each GPO that contains IPsec connection security rules that require this certificate.  
  
**Administrative credentials**  
  
To complete these procedures, you must be a member of both the Domain Admins group in the root domain of your forest and a member of the Enterprise Admins group.  
  
### To configure Group Policy to autoenroll certificates  
  
1.  On a computer that has the Group Policy Management feature installed, click **Start**, click **Administrative Tools**, and then click **Group Policy Management**.  
  
2.  In the navigation pane, expand **Forest:** *YourForestName*, expand **Domains**, expand *YourDomainName*, expand **Group Policy Objects**, right\-click the GPO you want to modify, and then click **Edit**.  
  
3.  In the navigation pane, expand the following path: **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, **Public Key Policies**.  
  
4.  Double\-click **Certificate Services Client \- Auto\-Enrollment**.  
  
5.  In the **Properties** dialog box, change **Configuration Model** to **Enabled**.  
  
6.  Select both **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.  
  
7.  Click **OK** to save your changes. Computers apply the GPO and download the certificate the next time Group Policy is refreshed.  
  
If you arrived at this page by clicking a link in a checklist, use your browser’s **Back** button to return to the checklist.  
  

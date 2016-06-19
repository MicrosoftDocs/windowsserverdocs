---
title: Server Certificate Deployment
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1ae4384b-f4e4-41e8-bc5f-9ac41953bca4
author: vhorne
---
# Server Certificate Deployment
Follow these steps to install an enterprise root certification authority \(CA\) and to deploy server certificates for use with PEAP and EAP.  
  
> [!IMPORTANT]  
> >Before you install Active Directory Certificate Services, you must name the computer, configure the computer with a static IP address, and join the computer to the domain. After you install AD CS, you cannot change the computer name or the domain membership of the computer, however you can change the IP address if needed. For more information on how to accomplish these tasks, see the Windows Server® 2016 Technical Preview [Core Network Guide](https://technet.microsoft.com/library/mt604042.aspx) at http:\/\/technet.microsoft.com\/library\/mt604042.aspx.  
  
-   [Install the Web Server WEB1](../../../core-network-guide/cncg/server-certs/Install-the-Web-Server-WEB1.md)  
  
-   [Create an alias (CNAME) record in DNS for WEB1](assetId:///bfae23f0-ae12-486b-94fe-50a137e141a5)  
  
-   [Configure WEB1 to distribute Certificate Revocation Lists (CRLs)](assetId:///fa4a8c41-8c2a-425c-8511-736fe5d196ac)  
  
-   [Prepare the CAPolicy.inf file (CNG)](assetId:///c36201de-7eb6-4e38-87da-cf7dd981a442)  
  
-   [Install the Certification Authority](assetId:///4acdc3ad-078e-45cc-b54c-e9456e0c90f5)  
  
-   [Configure the CDP and AIA extensions on CA1](assetId:///f77a3989-9f92-41ef-92a8-031651dd73a8)  
  
-   [Copy the CA certificate and CRL to the virtual directory](assetId:///a1b5fa23-9cb1-4c32-916f-2d75f48b42c7)  
  
-   [Configure the server certificate template](assetId:///8ff610e2-43ca-407f-a828-06d9366e02f0)  
  
-   [Configure server certificate autoenrollment](assetId:///c81e85cb-ecb8-442a-ad27-442c2f9e40df)  
  
-   [Refresh Group Policy [Preliminary3]](assetId:///65b36794-bb09-4c1b-a2e7-8fc780893d97)  
  
-   [Verify Server Enrollment of a Server Certificate](assetId:///bd80a018-5a30-47c3-89fc-aacb9f5ad298)  
  
> [!NOTE]  
> The procedures in this guide do not include instructions for cases in which the **User Account Control** dialog box opens to request your permission to continue. If this dialog box opens while you are performing the procedures in this guide, and if the dialog box was opened in response to your actions, click **Continue**.  
  


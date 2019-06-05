---
ms.assetid: 6e711a96-9055-4508-b6d4-318d6aa95fd1
title: When to Use Identity Delegation
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# When to Use Identity Delegation
  
## What is identity delegation?  
Identity delegation is a feature of Active Directory Federation Services \(AD FS\) that allows administrator\-specified accounts to impersonate users. The account that impersonates the user is called the *delegate*. This delegation capability is critical for many distributed applications for which there is a series of access control checks that must be made sequentially for each application, database, or service that is in the authorization chain for the originating request. Many real\-world scenarios exist in which a Web application “front end” must retrieve data from a more secure “back end”, such as a Web service that is connected to a Microsoft SQL Server database.  
  
For example, an existing parts\-ordering Web site can be enhanced programmatically so that it allows partner organizations to view their own purchase history and account status. For security reasons, all partner financial data is stored in a secure database on a dedicated Structured Query Language \(SQL\) server. In this situation, the code in the front\-end application knows nothing about the partner organization’s financial data. Therefore, it must retrieve that data from another computer elsewhere on the network that hosts \(in this case\) the Web service for the parts database \(the back end\).  
  
For this data\-retrieval process to succeed, some succession of authorization “hand\-shaking” must take place between the Web application and the Web service for the parts database, as shown in the following illustration.  
  
![identity delegation](media/adfs2_identitydelegationconcept.gif)  
  
Because the original request was made to the Web server itself, which is likely to be located in a completely different organization from the organization of the user who is attempting to access the Web server, the security token that is sent along with the request does not meet the authorization criteria required to access any other computer besides the Web server. Therefore, the only way that the originating user request can be fulfilled is by placing an intermediate federation server in the resource partner organization to help with reissuing a security token that does have the appropriate access privileges.  
  
## How does identity delegation work?  
Web applications in multitier application architectures often call Web services to access common data or functionality. It is important for these Web services to know the identity of the original user so that the service can make authorization decisions and facilitate auditing. In this case, the front\-end Web application represents the user to the Web service as a delegate. AD FS facilitates this scenario by allowing Active Directory accounts to act as a user to another relying party. An identity delegation scenario is shown in the following illustration.  
  
![identity delegation](media/adfs2_identitydelegationsteps.gif)  
  
1.  Frank attempts to access part\-ordering history from a Web application in another organization. His client computer requests and receives a token from AD FS for the front\-end part\-ordering Web application.  
  
2.  The client computer sends a request to the Web application, including the token obtained in step 1, to prove the client’s identity.  
  
3.  The Web application needs to communicate with the Web service to complete its transaction for the client. The Web application contacts AD FS to obtain a delegation token to interact with the Web service. Delegation tokens are security tokens that are issued to a delegate to act as a user. AD FS returns a delegation token with claims about the client, targeted for the Web service.  
  
4.  The Web application uses the token that was obtained from AD FS in step 3 to access the Web service that is acting as the client. Examining the delegation token, the Web service can determine that the Web application is acting as the client. The Web service executes its authorization policy, logs the request, and provides the needed parts history data that was originally requested by Frank to the Web application and therefore to Frank.  
  
For a particular delegate, AD FS can limit the Web services for which the Web application may request a delegation token. The client computer does not have to have an Active Directory account for this operation to succeed. Finally, as noted previously, the Web service can easily determine the identity of the delegate that is acting as the user. This allows Web services to exhibit different behavior based on whether they are talking directly to the client computer or through a delegate.  
  
## Configuring AD FS for identity delegation  
You can use the AD FS Management snap\-in to configure AD FS for identity delegation whenever you need to facilitate the data retrieval process. After you configure it, AD FS can generate new security tokens that will include the authorization context that the back\-end service may require before it can provide access to the protected data.  
  
AD FS does not restrict which users can be impersonated. After you configure AD FS for identity delegation, it does the following:  
  
-   It determines which servers can be delegated the authority to request tokens to impersonate a user.  
  
-   It establishes and keeps separate both the identity context for the client account that is delegated and the server that acts as a delegate.  
  
You can configure identity delegation by adding delegation authorization rules to a relying party trust in the AD FS Management snap\-in. For more information about how to do this, see [Checklist: Creating Claim Rules for a Relying Party Trust](../../ad-fs/deployment/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md).  
  
## Configuring the front\-end Web application for identity delegation  
Developers have several options that they can use to appropriately program the Web front\-end application or service to redirect delegation requests to an AD FS computer. For more information about how to customize a Web application to work with identity delegation, see the [Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

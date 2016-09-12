---
title: Configure Client Computers to Trust the Account Federation Server
description:
author: billmath
manager: femila
ms.date: 09/12/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
ms.author: billmath
---

# Configure Client Computers to Trust the Account Federation Server

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


In an account partner organization, administrators create claims to represent a user's membership in a group or role or to represent some data about a user, for example, a user’s employee identification number.  
  
In a resource partner organization, administrators create corresponding claims to represent groups and users that can be recognized as resource users. Because outgoing claims in the account partner organization map to incoming claims in the resource partner organization, the resource partner is able to accept the credentials that the account partner provides.  
  
You can use the following procedure to add a claim.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
### To add a claim  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  Click **AD FS\\Service**, right\-click **Claim Descriptions**, and then click **Add Claim Description**.  
  
3.  On the **Add a Claim Description** dialog box, in **Display name**, type a unique name that identifies the group or role for this claim.  
  
4.  In **Claim identifier**, type a URI that is associated with the group or role of the claim that you will be using.  
  
5.  Under **Description**, type text that best describes the purpose of this claim.  
  
6.  Depending on the needs of your organization, select either of the following check boxes, as appropriate, to publish this claim into federation metadata:  
  
    -   To publish this claim to make partners aware that this server can accept this claim, click **Publish this claim in federation metadata as a claim type that this Federation Service can accept**.  
  
    -   To publish this claim to make partners aware that this server can issue this claim, click **Publish this claim in federation metadata as a claim type that this Federation Service can send**.  
  
7.  Click **OK**.  

## Additional references  

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)
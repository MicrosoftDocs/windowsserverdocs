---
title: Add a Claim Description
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 510ea2cc-9170-4d0f-ab79-58ea750d7d25
author: billmath
---
# Add a Claim Description
In an account partner organization, administrators create claims to represent a user's membership in a group or role or to represent some data about a user, for example, a user’s employee identification number.  
  
In a resource partner organization, administrators create corresponding claims to represent groups and users that can be recognized as resource users. Because outgoing claims in the account partner organization map to incoming claims in the resource partner organization, the resource partner is able to accept the credentials that the account partner provides.  
  
You can use the following procedure to add a claim.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To add a claim  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  Click **AD FS\\Service**, right\-click **Claim Descriptions**, and then click **Add Claim Description**.  
  
3.  On the **Add a Claim Description** dialog box, in **Display name**, type a unique name that identifies the group or role for this claim.  
  
4.  In **Claim identifier**, type a URI that is associated with the group or role of the claim that you will be using.  
  
5.  Under **Description**, type text that best describes the purpose of this claim.  
  
6.  Depending on the needs of your organization, select either of the following check boxes, as appropriate, to publish this claim into federation metadata:  
  
    -   To publish this claim to make partners aware that this server can accept this claim, click **Publish this claim in federation metadata as a claim type that this Federation Service can accept**.  
  
    -   To publish this claim to make partners aware that this server can issue this claim, click **Publish this claim in federation metadata as a claim type that this Federation Service can send**.  
  
7.  Click **OK**.  
  
## Additional references  
[Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md)  
  
[Checklist: Configuring the Resource Partner Organization](../Topic/Checklist--Configuring-the-Resource-Partner-Organization.md)  
  
[The Role of Claims](../Topic/The-Role-of-Claims.md)  
  

---
description: "Learn more about: Checklist: Configuring AD FS  to Consume Claims from AD FS 1.x"
ms.assetid: e7f9e518-2d5d-4a0d-9147-34e1304f42ac
title: Checklist - Configuring Legacy AD FS  to Consume Claims from AD FS 1.x
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Checklist: Configuring AD FS  to Consume Claims from AD FS 1.x


## Checklist: Configuring AD FS to consume claims from AD FS 1.x
This checklist includes the tasks that are necessary for configuring your Active Directory Federation Services \(AD FS\) Federation Service in  Windows Server 2012  to consume claims that are sent by an AD FS 1.*x* Federation Service.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.

![Check mark icon, Configure AD FS to consume claims.](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring AD FS to consume claims from AD FS 1.x**

|Task|Reference|
|--------|-------------|
|Plan for interoperability between AD FS in  Windows Server 2012  and previous versions of AD FS, and learn more about the Name ID claim type.|![Icon, Plan for interoperability with AD FS 1.x.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning for Interoperability with AD FS 1.x](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff678040(v=ws.11))|
| Before you can interoperate with a previous version of AD FS, you must first create a claims provider trust in the AD FS Federation Service. **Note:** You cannot create a trust with an AD FS 1.*x* Federation Service by using federation metadata.<p>When you set up the trust using the procedure in the link to the right, you must do the following in the Add Claims Provider Trust Wizard to set up this trust to interoperate with an AD FS 1.*x* Federation Service:<p>1.  On the **Select Data Source** page, select **Enter data about the relying party trust manually**.<br />2.  On the **Choose Profile** page, select **AD FS 1.0 and 1.1 profile**.<br />3.  On the **Configure URL** page, under **WS\-Federation Passive URL**, type the **Federation Service endpoint URL** as defined in the AD FS 1.*x* Federation Service of the partner.<br />4.  On the **Configure Identifiers** page, under **Claims provider trust identifier**, type the **Federation Service URI** as defined in the AD FS 1.*x* Federation Service of the partner.|![Icon, Create a claims provider trust manually,](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Claims Provider Trust Manually](../../ad-fs/operations/Create-a-Claims-Provider-Trust.md)|
| On the claims provider trust that you created earlier, you must create a claim rule that will take claims that are incoming from the AD FS 1.x Federation Service and pass through, filter, or transform them into a Name ID claim type.<p>When the Name ID claim type has been passed through, filtered, or transformed, it can be used as input to another rule or rules so that it can be understood and consumed by the AD FS Federation Service in  Windows Server 2012 .|![consume claims from AD FS](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim](../../ad-fs/operations/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim.md)|
| Contact the administrator of the AD FS 1.*x* Federation Service and have the administrator of the AD FS 1.*x* Federation Service set up a new resource partner trust. Also, provide that administrator with the Federation Service URI \(in the Federation Service properties\), the Federation Service endpoint URL, and an exported token\-signing certificate file \(with public key only\). The administrator will need these items to set up the trust.|N\/A|

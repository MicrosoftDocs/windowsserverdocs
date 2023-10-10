---
description: "Learn more about: Checklist: Implementing a Web SSO Design"
ms.assetid: 30657638-5709-48c5-87aa-98f688e07b4c
title: Checklist - Implementing a Web SSO Design
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Checklist: Implementing a Web SSO Design

This parent checklist includes cross\-reference links to important concepts about the Web Single\-Sign\-On \(SSO\) design for Active Directory Federation Services \(AD FS\). It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.

![Icon for the Implementing a Web SSO Design check list.](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Web SSO Design**

|Task|Reference|
|--------|-------------|
|Review important concepts about the Web SSO design and determine which AD FS deployment goals you can use to customize this design to meet the needs of your organization. **Note:**|![Icon for the Identifying Your AD FS Deployment Goals link you can use in reference to implementing a Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Web SSO Design](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dd807033(v=ws.11))<p>![Icon for the Web SSO Design link you can use in reference to implementing a Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](../design/identifying-your-ad-fs-deployment-goals.md)|
|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying AD FS in your organization.|![Icon for the Appendix A: Reviewing AD FS Requirements link you can use in reference to implementing a Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff678034(v=ws.11))|
|According to your design plan, install one or more federation servers in the corporate network or in the perimeter network. **Note:** The Web SSO design requires only one federation server to function successfully. A single federation server acts in both the claims provider role and the relying party role.|![Icon for the Checklist: Setting Up a Federation Server link you can use in reference to implementing a Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)|
|\(Optional\) Determine whether or not your organization needs a federation server proxy in the perimeter network.|![Icon for the Checklist: Setting Up a Federation Server Proxy link you can use in reference to implementing a Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)|
|Depending on your Web SSO design plan and how you intend to use it, add the appropriate attribute store, relying party trusts, claims, and claim rules to the Federation Service.|![Icon for the Checklist: Configuring the Account Partner Organization link you can use in reference to implementing a Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](Checklist--Configuring-the-Account-Partner-Organization.md)|
|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft&reg; Office SharePoint&reg; Server application using WIF and the WIF SDK. **Note:**|![Icon for the Windows Identity Foundation link you can use in reference to implementing a Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](https://go.microsoft.com/fwlink/?LinkId=122266)<p>![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266)|

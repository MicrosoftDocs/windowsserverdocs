---
description: "Learn more about: Checklist: Implementing a Federated Web SSO Design"
ms.assetid: 6b49cde3-d2cb-4ece-b9b7-dc600e037495
title: Checklist - Implementing a Federated Web SSO Design
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Checklist: Implementing a Federated Web SSO Design

This parent checklist includes cross\-reference links to important concepts about the Federated Web Single\-Sign\-On \(SSO\) design for Active Directory Federation Services \(AD FS\). It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.

![Icon for the Implementing a Federated Web SSO Design check list.](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Federated Web SSO Design**

|Task|Reference|
|--------|-------------|
|Review important concepts about the Federated Web SSO design and determine which AD FS deployment goals you can use to customize this design to meet the needs of your organization.|![Icon for the Federated Web SSO Design link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Federated Web SSO Design](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dd807050(v=ws.11))<p>![Icon for the Identifying Your AD FS Deployment Goals link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](../design/identifying-your-ad-fs-deployment-goals.md)<p>![Icon for the Planning Your Deployment link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Your Deployment](../design/planning-your-deployment.md)|
|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying AD FS in your organization.|![Icon for the Appendix A: Reviewing AD FS Requirements link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff678034(v=ws.11))|
|Review important concepts about claims, claim rules, attribute stores, and the AD FS configuration database before deploying AD FS in both partner organizations.|![Icon for the Understanding Key AD FS Concepts link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md)|
|According to your design plan, install one or more federation servers in each partner organization. **Note:** For the Federated Web SSO design, you need at least one federation server in the account partner organization and at least one federation server in the resource partner organization.|![Icon for the Checklist: Setting Up a Federation Server link you can use in reference to implementing a federated Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)|
|\(Optional\) Determine whether or not your organization needs a federation server proxy. If your design plan calls for a proxy, you can install one or more federation server proxies in each partner organization.|![Icon for the Checklist: Setting Up a Federation Server Proxy link you can use in reference to implementing a federated Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)|
|According to your design plan, share certificates, configure clients, and configure the trust relationships in both partner organizations so that they can communicate over a federation trust.|![Icon for the Checklist: Configuring the Account Partner Organization link you can use in reference to implementing a federated Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](Checklist--Configuring-the-Account-Partner-Organization.md)<p>![Icon for the Checklist: Configuring the Resource Partner Organization link you can use in reference to implementing a federated Web SSO design.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Resource Partner Organization](Checklist--Configuring-the-Resource-Partner-Organization.md)|
|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft&reg; Office SharePoint&reg; Server application using WIF and the WIF SDK.|![Icon for the Windows Identity Foundation link you can use in reference to implementing a federated Web SSO design.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](https://go.microsoft.com/fwlink/?LinkId=122266)<p>![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266)|

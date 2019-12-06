---
ms.assetid: 6b49cde3-d2cb-4ece-b9b7-dc600e037495
title: Checklist - Implementing a Federated Web SSO Design
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Checklist: Implementing a Federated Web SSO Design

This parent checklist includes cross\-reference links to important concepts about the Federated Web Single\-Sign\-On \(SSO\) design for Active Directory Federation Services \(AD FS\). It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![federated web sso](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Federated Web SSO Design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![federated web sso](media/icon_checkboxo.gif)|Review important concepts about the Federated Web SSO design and determine which AD FS deployment goals you can use to customize this design to meet the needs of your organization.|![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Federated Web SSO Design](https://technet.microsoft.com/library/dd807050.aspx)<br /><br />![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](https://technet.microsoft.com/library/dd807053.aspx)<br /><br />![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Your Deployment](https://technet.microsoft.com/library/dd807083.aspx)|  
|![federated web sso](media/icon_checkboxo.gif)|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying AD FS in your organization.|![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](https://technet.microsoft.com/library/ff678034.aspx)|  
|![federated web sso](media/icon_checkboxo.gif)|Review important concepts about claims, claim rules, attribute stores, and the AD FS configuration database before deploying AD FS in both partner organizations.|![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md)|  
|![federated web sso](media/icon_checkboxo.gif)|According to your design plan, install one or more federation servers in each partner organization. **Note:** For the Federated Web SSO design, you need at least one federation server in the account partner organization and at least one federation server in the resource partner organization.|![federated web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)|  
|![federated web sso](media/icon_checkboxo.gif)|\(Optional\) Determine whether or not your organization needs a federation server proxy. If your design plan calls for a proxy, you can install one or more federation server proxies in each partner organization.|![federated web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)|  
|![federated web sso](media/icon_checkboxo.gif)|According to your design plan, share certificates, configure clients, and configure the trust relationships in both partner organizations so that they can communicate over a federation trust.|![federated web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](Checklist--Configuring-the-Account-Partner-Organization.md)<br /><br />![federated web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Resource Partner Organization](Checklist--Configuring-the-Resource-Partner-Organization.md)|  
|![federated web sso](media/icon_checkboxo.gif)|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft® Office SharePoint® Server application using WIF and the WIF SDK.|![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](https://go.microsoft.com/fwlink/?LinkId=122266)<br /><br />![federated web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266)|  

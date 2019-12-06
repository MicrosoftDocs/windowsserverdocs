---
ms.assetid: 30657638-5709-48c5-87aa-98f688e07b4c
title: Checklist - Implementing a Web SSO Design
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Checklist: Implementing a Web SSO Design

This parent checklist includes cross\-reference links to important concepts about the Web Single\-Sign\-On \(SSO\) design for Active Directory Federation Services \(AD FS\). It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![web sso](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Web SSO Design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![web sso](media/icon_checkboxo.gif)|Review important concepts about the Web SSO design and determine which AD FS deployment goals you can use to customize this design to meet the needs of your organization. **Note:**|![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Web SSO Design](https://technet.microsoft.com/library/dd807033.aspx)<br /><br />![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](https://technet.microsoft.com/library/dd807053.aspx)|  
|![web sso](media/icon_checkboxo.gif)|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying AD FS in your organization.|![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](https://technet.microsoft.com/library/ff678034.aspx)|  
|![web sso](media/icon_checkboxo.gif)|According to your design plan, install one or more federation servers in the corporate network or in the perimeter network. **Note:** The Web SSO design requires only one federation server to function successfully. A single federation server acts in both the claims provider role and the relying party role.|![web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)|  
|![web sso](media/icon_checkboxo.gif)|\(Optional\) Determine whether or not your organization needs a federation server proxy in the perimeter network.|![web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)|  
|![web sso](media/icon_checkboxo.gif)|Depending on your Web SSO design plan and how you intend to use it, add the appropriate attribute store, relying party trusts, claims, and claim rules to the Federation Service.|![web sso](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](Checklist--Configuring-the-Account-Partner-Organization.md)|  
|![web sso](media/icon_checkboxo.gif)|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft® Office SharePoint® Server application using WIF and the WIF SDK. **Note:**|![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](https://go.microsoft.com/fwlink/?LinkId=122266)<br /><br />![web sso](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](https://go.microsoft.com/fwlink/?LinkId=122266)| 

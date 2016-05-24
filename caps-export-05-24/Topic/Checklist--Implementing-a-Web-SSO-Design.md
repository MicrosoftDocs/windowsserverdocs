---
title: Checklist: Implementing a Web SSO Design
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ee64e335-92a2-435c-b2c1-a7b7b53bf80e
author: billmath
---
# Checklist: Implementing a Web SSO Design
This parent checklist includes cross\-reference links to important concepts about the Web Single\-Sign\-On \(SSO\) design for [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Web SSO Design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review important concepts about the Web SSO design and determine which [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment goals you can use to customize this design to meet the needs of your organization. **Note:**|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Web SSO Design](../Topic/Web-SSO-Design.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](../Topic/Identifying-Your-AD-FS-Deployment-Goals.md)|  
|![](../Image/icon_checkboxo.gif)|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in your organization.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](../Topic/Appendix-A--Reviewing-AD-FS-Requirements.md)|  
|![](../Image/icon_checkboxo.gif)|According to your design plan, install one or more [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in the corporate network or in the perimeter network. **Note:** The Web SSO design requires only one [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] to function successfully. A single [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] acts in both the claims provider role and the relying party role.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)|  
|![](../Image/icon_checkboxo.gif)|\(Optional\) Determine whether or not your organization needs a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxy in the perimeter network.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)|  
|![](../Image/icon_checkboxo.gif)|Depending on your Web SSO design plan and how you intend to use it, add the appropriate attribute store, relying party trusts, claims, and claim rules to the Federation Service.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md)|  
|![](../Image/icon_checkboxo.gif)|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft® Office SharePoint® Server application using [!INCLUDE[nextref_idfx](../Token/nextref_idfx_md.md)] and the [!INCLUDE[nextref_idfx](../Token/nextref_idfx_md.md)] SDK. **Note:**|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](http://go.microsoft.com/fwlink/?LinkId=122266)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](http://go.microsoft.com/fwlink/?LinkId=122266)|  
  

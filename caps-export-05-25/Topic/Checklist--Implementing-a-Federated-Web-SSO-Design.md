---
title: Checklist: Implementing a Federated Web SSO Design
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37f6d396-63c4-4c4e-a323-c73725a9e912
author: billmath
---
# Checklist: Implementing a Federated Web SSO Design
This parent checklist includes cross\-reference links to important concepts about the Federated Web Single\-Sign\-On \(SSO\) design for [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Implementing a Federated Web SSO Design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review important concepts about the Federated Web SSO design and determine which [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment goals you can use to customize this design to meet the needs of your organization.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Federated Web SSO Design](../Topic/Federated-Web-SSO-Design.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your AD FS Deployment Goals](../Topic/Identifying-Your-AD-FS-Deployment-Goals.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Your Deployment](../Topic/Planning-Your-Deployment.md)|  
|![](../Image/icon_checkboxo.gif)|Review the hardware, software, certificate, Domain Name System \(DNS\), attribute store, and client requirements for deploying AD FS in your organization.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: Reviewing AD FS Requirements](../Topic/Appendix-A--Reviewing-AD-FS-Requirements.md)|  
|![](../Image/icon_checkboxo.gif)|Review important concepts about claims, claim rules, attribute stores, and the AD FS configuration database before deploying [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in both partner organizations.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../Topic/Understanding-Key-AD-FS-Concepts.md)|  
|![](../Image/icon_checkboxo.gif)|According to your design plan, install one or more [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in each partner organization. **Note:** For the Federated Web SSO design, you need at least one [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the account partner organization and at least one [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner organization.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)|  
|![](../Image/icon_checkboxo.gif)|\(Optional\) Determine whether or not your organization needs a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)]. If your design plan calls for a proxy, you can install one or more [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies in each partner organization.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)|  
|![](../Image/icon_checkboxo.gif)|According to your design plan, share certificates, configure clients, and configure the trust relationships in both partner organizations so that they can communicate over a federation trust.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md)<br /><br />![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring the Resource Partner Organization](../Topic/Checklist--Configuring-the-Resource-Partner-Organization.md)|  
|![](../Image/icon_checkboxo.gif)|If you are an administrator in the resource partner organization, claims\-enable your Web browser application, Web service application, or Microsoft® Office SharePoint® Server application using [!INCLUDE[nextref_idfx](../Token/nextref_idfx_md.md)] and the [!INCLUDE[nextref_idfx](../Token/nextref_idfx_md.md)] SDK.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation](http://go.microsoft.com/fwlink/?LinkId=122266)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Windows Identity Foundation SDK](http://go.microsoft.com/fwlink/?LinkId=122266)|  
  

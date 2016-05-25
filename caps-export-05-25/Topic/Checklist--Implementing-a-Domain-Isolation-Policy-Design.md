---
title: Checklist: Implementing a Domain Isolation Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd54d290-021c-46a4-81ec-a5ff5ec60f62
author: vhorne
---
# Checklist: Implementing a Domain Isolation Policy Design
This parent checklist includes cross\-reference links to important concepts about the domain isolation policy design. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
>   
> The procedures in this section use the Group Policy MMC snap\-ins to configure the GPOs, but you can also use Windows PowerShell to configure GPOs. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](http://technet.microsoft.com/library/hh831755.aspx) at http:\/\/technet.microsoft.com\/library\/hh831755.aspx.  
>   
> For more information about the security algorithms and authentication methods available in each version of Windows, see [IPsec Algorithms and Methods Supported in Windows](http://technet.microsoft.com/library/dd125380.aspx) at http:\/\/technet.microsoft.com\/library\/dd125380.aspx.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Implementing a domain isolation policy design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/WFAS_icon_checkbox.gif)|Review important concepts and examples for the domain isolation policy design, determine your [!INCLUDE[wfas](../Token/wfas_md.md)] deployment goals, and customize this design to meet the needs of your organization.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](../Topic/Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Domain Isolation Policy Design](../Topic/Domain-Isolation-Policy-Design.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Domain Isolation Policy Design Example](../Topic/Domain-Isolation-Policy-Design-Example.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Domain Isolation Zones](../Topic/Planning-Domain-Isolation-Zones.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for the isolated domain.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Rules for the Isolated Domain](../Topic/Checklist--Configuring-Rules-for-the-Isolated-Domain.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for the boundary zone.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Rules for the Boundary Zone](../Topic/Checklist--Configuring-Rules-for-the-Boundary-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for the encryption zone.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Rules for the Encryption Zone](../Topic/Checklist--Configuring-Rules-for-the-Encryption-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for the isolated server zone.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Rules for an Isolated Server Zone](../Topic/Checklist--Configuring-Rules-for-an-Isolated-Server-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|According to the testing and roll\-out schedule in your design plan, add computer accounts to the membership group to deploy rules and settings to your computers.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Production Computers to the Membership Group for a Zone](../Topic/Add-Production-Computers-to-the-Membership-Group-for-a-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|After you confirm that network traffic is authenticated by IPsec, you can change authentication rules for the isolated domain and encryption zone from request to require mode.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Change Rules from Request to Require Mode](../Topic/Change-Rules-from-Request-to-Require-Mode.md)|  
  

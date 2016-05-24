---
title: Checklist: Implementing a Basic Firewall Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 77e0fe2a-6f45-4167-a3c6-e134c27b4feb
author: vhorne
---
# Checklist: Implementing a Basic Firewall Policy Design
This parent checklist includes cross\-reference links to important concepts about the basic firewall policy design. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
>   
> The procedures in this section use the Group Policy MMC snap\-in interfaces to configure the GPOs, but you can also use Windows PowerShell. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](http://technet.microsoft.com/library/hh831755.aspx) at http:\/\/technet.microsoft.com\/library\/hh831755.aspx.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Implementing a basic firewall policy design**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/WFAS_icon_checkbox.gif)|Review important concepts and examples for the basic firewall policy design to determine if this design meets the needs of your organization.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](../Topic/Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Basic Firewall Policy Design](../Topic/Basic-Firewall-Policy-Design.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Firewall Policy Design Example](../Topic/Firewall-Policy-Design-Example.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Settings for a Basic Firewall Policy](../Topic/Planning-Settings-for-a-Basic-Firewall-Policy.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create the membership group and a GPO for each set of computers that require different firewall rules. Where GPOs will be similar, such as for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], create one GPO, configure it by using the tasks in this checklist, and then make a copy of the GPO for the other version of Windows. For example, create and configure the GPO for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], make a copy of it for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and then follow the steps in this checklist to make the few required changes to the copy.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Group Policy Objects](../Topic/Checklist--Creating-Group-Policy-Objects.md)<br /><br />![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Copy a GPO to Create a New GPO](../Topic/Copy-a-GPO-to-Create-a-New-GPO.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|If you are working on a GPO that was copied from another, modify the group membership and WMI filters so that they are correct for the computers for which this GPO is intended.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](../Topic/Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Configure the GPO with firewall default settings appropriate for your design.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Basic Firewall Settings](../Topic/Checklist--Configuring-Basic-Firewall-Settings.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create one or more inbound firewall rules to allow unsolicited inbound network traffic.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Inbound Firewall Rules](../Topic/Checklist--Creating-Inbound-Firewall-Rules.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Create one or more outbound firewall rules to block unwanted outbound network traffic.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Outbound Firewall Rules](../Topic/Checklist--Creating-Outbound-Firewall-Rules.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](../Topic/Link-the-GPO-to-the-Domain.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|Add test computers to the membership group, and then confirm that the computers receive the firewall rules from the GPOs as expected.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](../Topic/Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|  
|![](../Image/WFAS_icon_checkbox.gif)|According to the testing and roll\-out schedule in your design plan, add computer accounts to the membership group to deploy the completed firewall policy settings to your computers.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Production Computers to the Membership Group for a Zone](../Topic/Add-Production-Computers-to-the-Membership-Group-for-a-Zone.md)|  
  

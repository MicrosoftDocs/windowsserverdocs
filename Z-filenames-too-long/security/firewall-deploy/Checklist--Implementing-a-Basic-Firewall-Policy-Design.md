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
---
# Checklist: Implementing a Basic Firewall Policy Design
This parent checklist includes cross\-reference links to important concepts about the basic firewall policy design. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.
> 
> The procedures in this section use the Group Policy MMC snap\-in interfaces to configure the GPOs, but you can also use Windows PowerShell. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](http://technet.microsoft.com/library/hh831755.aspx) at http:\/\/technet.microsoft.com\/library\/hh831755.aspx.

![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Implementing a basic firewall policy design**

||Task|Reference|
|-|--------|-------------|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Review important concepts and examples for the basic firewall policy design to determine if this design meets the needs of your organization.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](../../plan/windows-firewall-design-guide/Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Basic Firewall Policy Design](Basic-Firewall-Policy-Design.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Firewall Policy Design Example](Firewall-Policy-Design-Example.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Settings for a Basic Firewall Policy](Planning-Settings-for-a-Basic-Firewall-Policy.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Create the membership group and a GPO for each set of computers that require different firewall rules. Where GPOs will be similar, such as for Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 , and  Windows Server 2008 R2 , create one GPO, configure it by using the tasks in this checklist, and then make a copy of the GPO for the other version of Windows. For example, create and configure the GPO for Windows 8, make a copy of it for  Windows Server 2012 , and then follow the steps in this checklist to make the few required changes to the copy.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Group Policy Objects](Checklist--Creating-Group-Policy-Objects.md)<br /><br />![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Copy a GPO to Create a New GPO](Copy-a-GPO-to-Create-a-New-GPO.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|If you are working on a GPO that was copied from another, modify the group membership and WMI filters so that they are correct for the computers for which this GPO is intended.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Configure the GPO with firewall default settings appropriate for your design.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Basic Firewall Settings](Checklist--Configuring-Basic-Firewall-Settings.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Create one or more inbound firewall rules to allow unsolicited inbound network traffic.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Inbound Firewall Rules](Checklist--Creating-Inbound-Firewall-Rules.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Create one or more outbound firewall rules to block unwanted outbound network traffic.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Outbound Firewall Rules](Checklist--Creating-Outbound-Firewall-Rules.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](Link-the-GPO-to-the-Domain.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|Add test computers to the membership group, and then confirm that the computers receive the firewall rules from the GPOs as expected.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|
|![](../../../media/Checklist--Implementing-a-Basic-Firewall-Policy-Design/WFAS_icon_checkbox.gif)|According to the testing and roll\-out schedule in your design plan, add computer accounts to the membership group to deploy the completed firewall policy settings to your computers.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Production Computers to the Membership Group for a Zone](Add-Production-Computers-to-the-Membership-Group-for-a-Zone.md)|



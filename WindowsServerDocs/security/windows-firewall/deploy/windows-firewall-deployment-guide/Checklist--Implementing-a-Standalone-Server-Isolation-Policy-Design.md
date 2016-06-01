---
title: Checklist: Implementing a Standalone Server Isolation Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99fb5b77-ff03-4902-a919-70f8909d9c1b
---
# Checklist: Implementing a Standalone Server Isolation Policy Design
This checklist contains procedures for creating a server isolation policy design that is not part of an isolated domain. For the steps required to create an isolated server zone within an isolated domain, see [Checklist: Configuring Rules for an Isolated Server Zone](Checklist--Configuring-Rules-for-an-Isolated-Server-Zone.md).

This parent checklist includes cross\-reference links to important concepts about the domain isolation policy design. It also contains links to subordinate checklists that will help you complete the tasks that are required to implement this design.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.
> 
> The procedures in this section use the Group Policy MMC snap\-in interfaces to configure the GPOs, but you can also use Windows PowerShell. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](http://technet.microsoft.com/library/hh831755.aspx) at http:\/\/technet.microsoft.com\/library\/hh831755.aspx.

![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Implementing a standalone server isolation policy design**

||Task|Reference|
|-|--------|-------------|
|![](media/WFAS_icon_checkbox.gif)|Review important concepts and examples for the server isolation policy design to determine if this design meets your  deployment goals and the needs of your organization.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Server Isolation Policy Design](Server-Isolation-Policy-Design.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Server Isolation Policy Design Example](Server-Isolation-Policy-Design-Example.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Server Isolation Zones](Planning-Server-Isolation-Zones.md)|
|![](media/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for isolated servers.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Configuring Rules for Servers in a Standalone Isolated Server Zone](Checklist--Configuring-Rules-for-Servers-in-a-Standalone-Isolated-Server-Zone.md)|
|![](media/WFAS_icon_checkbox.gif)|Create the GPOs and connection security rules for the client computers that must connect to the isolated servers.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Rules for Clients of a Standalone Isolated Server Zone](Checklist--Creating-Rules-for-Clients-of-a-Standalone-Isolated-Server-Zone.md)|
|![](media/WFAS_icon_checkbox.gif)|Verify that the connection security rules are protecting network traffic on your test computers.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Verify That Network Traffic Is Authenticated](Verify-That-Network-Traffic-Is-Authenticated.md)|
|![](media/WFAS_icon_checkbox.gif)|After you confirm that network traffic is authenticated by IPsec as expected, you can change authentication rules for the isolated server zone to require authentication instead of requesting it.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Change Rules from Request to Require Mode](Change-Rules-from-Request-to-Require-Mode.md)|
|![](media/WFAS_icon_checkbox.gif)|According to the testing and roll\-out schedule in your design plan, add computer accounts for the client computers to the membership group so that you can deploy the settings.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Production Computers to the Membership Group for a Zone](Add-Production-Computers-to-the-Membership-Group-for-a-Zone.md)|



---
title: Checklist: Creating Outbound Firewall Rules
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2b43b94c-d29d-4294-834f-a7a7aca7c773
---
# Checklist: Creating Outbound Firewall Rules
This checklist includes tasks for creating outbound firewall rules in your GPOs. Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 , and  Windows Server 2008 R2  support the use of outbound rules.

> [!IMPORTANT]
> By default, in Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 , and  Windows Server 2008 R2 , outbound filtering is disabled. Because all outbound network traffic is permitted, outbound rules are typically used to block traffic that is not wanted on the network. However, it is a best practice for an administrator to create outbound allow rules for those applications that are approved for use on the organization’s network. If you do this, then you have the option to set the default outbound behavior to block, preventing any network traffic that is not specifically authorized by the rules you create.

![](../../../media/Checklist--Creating-Outbound-Firewall-Rules/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Creating outbound firewall rules for Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2**

||Task|Reference|
|-|--------|-------------|
|![](../../../media/Checklist--Creating-Outbound-Firewall-Rules/WFAS_icon_checkbox.gif)|Create a rule that allows a program to send any outbound network traffic on any port it requires.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Outbound Program or Service Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008 or Windows Server 2008 R2](Create-an-Outbound-Program-or-Service-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008-or-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Creating-Outbound-Firewall-Rules/WFAS_icon_checkbox.gif)|Create a rule that allows outbound network traffic on a specified port number.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Outbound Port Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008 or Windows Server 2008 R2](Create-an-Outbound-Port-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008-or-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Creating-Outbound-Firewall-Rules/WFAS_icon_checkbox.gif)|Enable a predefined rule or a group of predefined rules. Some predefined rules for basic network services are included as part of the installation of Windows; others can be created when you install a new application or network service.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Enable Predefined Outbound Rules on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2](Enable-Predefined-Outbound-Rules-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-or-Windows-Server-2008-R2.md)|



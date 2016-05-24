---
title: Checklist: Creating Claim Rules for a Claims Provider Trust
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 31758ff5-0483-493b-bd95-28d657de91ed
author: billmath
---
# Checklist: Creating Claim Rules for a Claims Provider Trust
This checklist includes tasks for planning, designing, and deploying claim rules that are associated with a claims provider trust in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)].  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Creating a claim rule set for a claims provider trust**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review concepts about claims, claim rules, claim rule sets, and claim rule templates and how they are associated with federated trusts.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claims](../Topic/The-Role-of-Claims.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claim Rules](../Topic/The-Role-of-Claim-Rules.md)|  
|![](../Image/icon_checkboxo.gif)|Review concepts about how a claim flows through all the stages in the claims issuance pipeline and how rules are processed by the claims issuance engine.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Pipeline](../Topic/The-Role-of-the-Claims-Pipeline.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Engine](../Topic/The-Role-of-the-Claims-Engine.md)|  
|![](../Image/icon_checkboxo.gif)|To effectively plan and implement the output claims that will be issued over this claims provider trust, determine whether one or more claim rules are needed and which claim rules you should use with this claims provider trust.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Determine the Type of Claim Rule Template to Use](../Topic/Determine-the-Type-of-Claim-Rule-Template-to-Use.md)|  
|![](../Image/icon_checkboxo.gif)|Review concepts about when to create one claim rule over another and how you can use the claim rule language to provide more complex logic than standard rules in order to provide a desired result in the ideal output claim set.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Pass Through or Filter Claim Rule](../Topic/When-to-Use-a-Pass-Through-or-Filter-Claim-Rule.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Transform Claim Rule](../Topic/When-to-Use-a-Transform-Claim-Rule.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send LDAP Attributes as Claims Rule](../Topic/When-to-Use-a-Send-LDAP-Attributes-as-Claims-Rule.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send Group Membership as a Claim Rule](../Topic/When-to-Use-a-Send-Group-Membership-as-a-Claim-Rule.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Custom Claim Rule](../Topic/When-to-Use-a-Custom-Claim-Rule.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claim Rule Language](../Topic/The-Role-of-the-Claim-Rule-Language.md)|  
|![](../Image/icon_checkboxo.gif)|A claim description must be created if one does not already exist that will fulfill the needs of your organization. [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] ships with a default set of claim descriptions that are exposed in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add a Claim Description](../Topic/Add-a-Claim-Description.md)|  
|![](../Image/icon_checkboxo.gif)|Depending on the needs of your organization, create one or more claim rules for the acceptance transform rules set that is associated with this claims provider trust so that claims will be issued appropriately.|![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Pass Through or Filter an Incoming Claim_1](../Topic/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim_1.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send LDAP Attributes as Claims_1](../Topic/Create-a-Rule-to-Send-LDAP-Attributes-as-Claims_1.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Group Membership as a Claim_1](../Topic/Create-a-Rule-to-Send-Group-Membership-as-a-Claim_1.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Transform an Incoming Claim](../Topic/Create-a-Rule-to-Transform-an-Incoming-Claim.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an Authentication Method Claim](../Topic/Create-a-Rule-to-Send-an-Authentication-Method-Claim.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim_1](../Topic/Create-a-Rule-to-Send-an-AD-FS-1.x-Compatible-Claim_1.md)<br /><br />![](../Image/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Claims Using a Custom Rule](../Topic/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule.md)|  
  

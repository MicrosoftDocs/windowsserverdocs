---
ms.assetid: 503733f8-be0c-429c-81f0-cd4205e8b118
title: Checklist - Creating Claim Rules for a Claims Provider Trust
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
ms.author: billmath
---

# Checklist: Creating Claim Rules for a Claims Provider Trust


This checklist includes tasks for planning, designing, and deploying claim rules that are associated with a claims provider trust in Active Directory Federation Services \(AD FS\).  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
  
![creating claim rules](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Creating a claim rule set for a claims provider trust**  
  
||Task|Reference|  
|-|--------|-------------|  
|![creating claim rules](media/icon_checkboxo.gif)|Review concepts about claims, claim rules, claim rule sets, and claim rule templates and how they are associated with federated trusts.|![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)|  
|![creating claim rules](media/icon_checkboxo.gif)|Review concepts about how a claim flows through all the stages in the claims issuance pipeline and how rules are processed by the claims issuance engine.|![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Pipeline](../../ad-fs/technical-reference/The-Role-of-the-Claims-Pipeline.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Engine](../../ad-fs/technical-reference/The-Role-of-the-Claims-Engine.md)|  
|![creating claim rules](media/icon_checkboxo.gif)|To effectively plan and implement the output claims that will be issued over this claims provider trust, determine whether one or more claim rules are needed and which claim rules you should use with this claims provider trust.|![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Determine the Type of Claim Rule Template to Use](../../ad-fs/technical-reference/Determine-the-Type-of-Claim-Rule-Template-to-Use.md)|  
|![creating claim rules](media/icon_checkboxo.gif)|Review concepts about when to create one claim rule over another and how you can use the claim rule language to provide more complex logic than standard rules in order to provide a desired result in the ideal output claim set.|![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Pass Through or Filter Claim Rule](../../ad-fs/technical-reference/When-to-Use-a-Pass-Through-or-Filter-Claim-Rule.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Transform Claim Rule](../../ad-fs/technical-reference/When-to-Use-a-Transform-Claim-Rule.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send LDAP Attributes as Claims Rule](../../ad-fs/technical-reference/When-to-Use-a-Send-LDAP-Attributes-as-Claims-Rule.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send Group Membership as a Claim Rule](../../ad-fs/technical-reference/When-to-Use-a-Send-Group-Membership-as-a-Claim-Rule.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Custom Claim Rule](../../ad-fs/technical-reference/When-to-Use-a-Custom-Claim-Rule.md)<br /><br />![creating claim rules](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claim Rule Language](../../ad-fs/technical-reference/The-Role-of-the-Claim-Rule-Language.md)|  
|![creating claim rules](media/icon_checkboxo.gif)|A claim description must be created if one does not already exist that will fulfill the needs of your organization. AD FS ships with a default set of claim descriptions that are exposed in the AD FS Management snap\-in.|![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add a Claim Description](../../ad-fs/operations/Add-a-Claim-Description.md)|  
|![creating claim rules](media/icon_checkboxo.gif)|Depending on the needs of your organization, create one or more claim rules for the acceptance transform rules set that is associated with this claims provider trust so that claims will be issued appropriately.|![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Pass Through or Filter an Incoming Claim](../../ad-fs/operations/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send LDAP Attributes as Claims](../../ad-fs/operations/Create-a-Rule-to-Send-LDAP-Attributes-as-Claims.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Group Membership as a Claim](../../ad-fs/operations/Create-a-Rule-to-Send-Group-Membership-as-a-Claim.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Transform an Incoming Claim](../../ad-fs/operations/Create-a-Rule-to-Transform-an-Incoming-Claim.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an Authentication Method Claim](../../ad-fs/operations/Create-a-Rule-to-Send-an-Authentication-Method-Claim.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim](../../ad-fs/operations/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim.md)<br /><br />![creating claim rules](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Claims Using a Custom Rule](../../ad-fs/operations/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule.md)|  
  


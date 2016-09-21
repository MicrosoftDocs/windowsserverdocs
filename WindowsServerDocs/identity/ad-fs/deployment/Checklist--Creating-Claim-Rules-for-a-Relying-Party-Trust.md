---
title: Checklist: Creating Claim Rules for a Relying Party Trust
description:
author: billmath
manager: femila
ms.date: 09/12/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
ms.author: billmath
ms.author: billmath
---

# Checklist: Creating Claim Rules for a Relying Party Trust

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This checklist includes the tasks that are necessary for planning, designing, and deploying claim rules that are associated with a relying party trust in Active Directory Federation Services \(AD FS\).  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
  
![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Creating a claim rule set for a relying party trust**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](media/icon_checkboxo.gif)|Review concepts about claims, claim rules, claim rule sets, and claim rule templates and how they are associated with federated trusts.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claims](The-Role-of-Claims.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of Claim Rules](The-Role-of-Claim-Rules.md)|  
|![](media/icon_checkboxo.gif)|Review concepts about how a claim flows through all the stages in the claims issuance pipeline and how rules are processed by the claims issuance engine.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Pipeline](The-Role-of-the-Claims-Pipeline.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claims Engine](The-Role-of-the-Claims-Engine.md)|  
|![](media/icon_checkboxo.gif)|To effectively plan and implement the output claims that will be issued over this relying party trust, determine whether one or more claim rules are needed and which claim rules you should use with this relying party trust.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Determine the Type of Claim Rule Template to Use](Determine-the-Type-of-Claim-Rule-Template-to-Use.md)|  
|![](media/icon_checkboxo.gif)|Review concepts about when to create one claim rule over another and how you can use the claim rule language to provide more complex logic than standard rules in order to provide a desired result in the ideal output claim set.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Pass Through or Filter Claim Rule](When-to-Use-a-Pass-Through-or-Filter-Claim-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Transform Claim Rule](When-to-Use-a-Transform-Claim-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send LDAP Attributes as Claims Rule](When-to-Use-a-Send-LDAP-Attributes-as-Claims-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Send Group Membership as a Claim Rule](When-to-Use-a-Send-Group-Membership-as-a-Claim-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use an Authorization Claim Rule](When-to-Use-an-Authorization-Claim-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[When to Use a Custom Claim Rule](When-to-Use-a-Custom-Claim-Rule.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The Role of the Claim Rule Language](The-Role-of-the-Claim-Rule-Language.md)|  
|![](media/icon_checkboxo.gif)|A claim description must be created if one does not already exist that will fulfill the needs of your organization. AD FS ships with a default set of claim descriptions that are exposed in the AD FS Management snap\-in.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add a Claim Description](Add-a-Claim-Description.md)|  
|![](media/icon_checkboxo.gif)|Depending on the needs of your organization, create one or more claim rules for the rule sets that are associated with this relying party trust so that claims will be issued appropriately.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Pass Through or Filter an Incoming Claim_1](Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim_1.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send LDAP Attributes as Claims_1](Create-a-Rule-to-Send-LDAP-Attributes-as-Claims_1.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Group Membership as a Claim_1](Create-a-Rule-to-Send-Group-Membership-as-a-Claim_1.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Transform an Incoming Claim](Create-a-Rule-to-Transform-an-Incoming-Claim.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an Authentication Method Claim](Create-a-Rule-to-Send-an-Authentication-Method-Claim.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim_1](Create-a-Rule-to-Send-an-AD-FS-1.x-Compatible-Claim_1.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Send Claims Using a Custom Rule](Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule.md)|  
|![](media/icon_checkboxo.gif)|Depending on the needs of your organization, create one or more claim rules for either the issuance authorization rules set or the delegation authorization rules set that is associated with this relying party trust so that users will be permitted access to the relying party.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Permit All Users_1](Create-a-Rule-to-Permit-All-Users_1.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Rule to Permit or Deny Users Based on an Incoming Claim_1](Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim_1.md)|  

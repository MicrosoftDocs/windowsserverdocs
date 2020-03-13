---
ms.assetid: 65e474b5-3076-4ba3-809d-a09160f7c2bd
title: The Role of Claim Rules
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---


# The Role of Claim Rules
The overall function of the Federation Service in Active Directory Federation Services \(AD FS\) is to issue a token that contains a set of claims. The decision regarding what claims AD FS accepts and then issues is governed by claim rules.

## What are claim rules?
A claim rule represents an instance of business logic that will take one or more incoming claims, apply conditions to them \(if x then y\) and produce one or more outgoing claims based on the condition parameters. For more information about incoming and outgoing claims, see [The Role of Claims](The-Role-of-Claims.md).

You use claim rules when you need to implement business logic that will control the flow of claims through the claims pipeline. While the claims pipeline is more a logical concept of the end\-to\-end process for flowing claims, claim rules are an actual administrative element that you can use to customize the flow of claims through the claims issuance process.

For more information about the claims pipeline, see [The Role of the Claims Engine](The-Role-of-the-Claims-Engine.md).

Claim rules provide the following benefits:

-   Provide a mechanism for administrators to apply run\-time business logic for trusting claims from claims providers

-   Provide a mechanism for administrators to define what claims are released to relying parties

-   Provide rich and detailed claims\-based authorization capabilities to administrators who want to permit or deny access to specific users

### How claim rules are processed
Claim rules are processed through the claims pipeline using the *claims engine*. The claims engine is a logical component of the Federation Service that examines the set of incoming claims presented by a user, and will then, depending on the logic in each rule, produce an output set of claims.

Together, the claims rule engine and the set of claim rules associated with a given federated trust determine whether incoming claims should be passed through as they are, filtered to meet a specific condition's criteria or transformed into an entirely new set of claims before they are issued as outgoing claims by your Federation Service.

For more information about this process, see [The Role of the Claims Engine](The-Role-of-the-Claims-Engine.md).

## What are claim rule templates?
AD FS includes a predefined set of claim rule templates that are designed to help you easily select and create the most appropriate claim rules for your particular business need. Claim rule templates are only used during the claim rule creation process.

In the AD FS Management snap\-in, rules can only be created using claim rule templates. After you use the snap\-in to select a claim rule template, input the necessary data for the rule logic and save it to the configuration database, it will be \(from that point forward\) referred to in the UI as a claim rule.

### How claim rule templates work
At first glance, claim rule templates appear to be just input forms provided by the snap\-in to collect data and process specific logic on incoming claims. However, at a much more detailed level, claim rule templates store the necessary claim rule language framework that make up the base logic necessary for you to quickly create a rule without needing to know the language intimately.

Each template that is provided in the user interface \(UI\) represents a prepopulated claim rule language syntax, based on the most commonly required administrative tasks. There is one rule template however, that is the exception. This template is referred to as the custom rule template. With this template, no syntax is prepopulated. Instead you must directly author the claim rule language syntax in the body of the claim rule template form using the claim rule language syntax.

For more information about how to use the claim rule language syntax, see [The Role of the Claim Rule Language](The-Role-of-the-Claim-Rule-Language.md) in the AD FS Deployment Guide.

> [!TIP]
> You can view the claim rule language associated with a rule at any time by clicking the **View Rule Language** button on the properties of a claim rule.

### How to create a claim rule
Claim rules are created separately for each federated trust relationship within the Federation Service and are not shared across multiple trusts. You can either create a rule from a claim rule template, start from scratch by authoring the rule using the claim rule language or use Windows PowerShell to customize a rule.

All of these options coexist to provide you with the flexibility of choosing the appropriate method for a given scenario. For more information about how to create a claim rule, see [Configuring Claim Rules](https://technet.microsoft.com/library/ee913571.aspx) in the AD FSDeployment Guide.

#### Using claim rule templates
Claim rule templates are only used during the claim rule creation process. You can use any of the following templates to create a claim rule:

-   Pass Through or Filter an Incoming Claim

-   Transform an Incoming Claim

-   Send LDAP Attributes as Claims

-   Send Group Membership as a Claim

-   Send Claims Using a Custom Rule

-   Permit or Deny Users Based on an Incoming Claim

-   Permit All Users

For more information describing each of these claim rule templates, see [Determine the Type of Claim Rule Template to Use](Determine-the-Type-of-Claim-Rule-Template-to-Use.md).

#### Using the claim rule language
For business rules that are beyond the scope of standard claim rule templates, you can use a custom rule template to express a series of complex logic conditions using the claim rule language. For more information about using a custom rule, see [When to Use a Custom Claim Rule](When-to-Use-a-Custom-Claim-Rule.md).

#### Using Windows PowerShell
You can also use the ADFSClaimRuleSet cmdlet object with Windows PowerShell to create or administer rules in AD FS. For more information about how you can use Windows PowerShell with this cmdlet, see [AD FS Administration with Windows PowerShell](https://go.microsoft.com/fwlink/?LinkID=179634).

## What is a claim rule set?
As shown in the following illustration, a claim rule set is a grouping of one or more rules for a given federated trust that will define how claims will be processed by the claims rule engine. When an incoming claim is received by the Federation Service the claim rule engine applies the logic specified by the appropriate claim rule set. It is the final sum of the logic from each rule in the set that will determine how claims will be issued for a given trust in its entirety.

![AD FS roles](media/adfs2_claimruleset.gif)

Claim rules are processed by the claims engine in chronological order within a given rule set. This order is important, because the output of one rule can be used as the input to the next rule in the set.

## What are claim rule set types?
A claim rule set type is a logical segment of a federated trust that categorically identifies whether the claim rule set associated with the trust will be used for claims issuance, authorization or acceptance. Each federated trust can have one or more claim rule set types associated with it, depending on the type of trust that is used.

The following table describes the various types of claim rule sets and explains its relation with either a claims provider trust or relying party trust.

|Claim rule set type|Description|Used on|
|-----------------------|---------------|-----------|
|Acceptance transform rule set|A set of claim rules that you use on a particular claims provider trust to specify the incoming claims that will be accepted from the claims provider organization and the outgoing claims that will be sent to the relying party trust.<br /><br />The incoming claims that will be used to source this rule set, will be the claims that are output by the issuance transform rule set as specified in the claims provider organization.<br /><br />By default, the claims provider trust node contains a claim provider trust named **Active Directory** which is used to represent the source attribute store for the acceptance transform rule set. This trust object is used to represent the connection from your Federation Service to an Active Directory database on your network. This default trust is what processes claims for users that have been authenticated by Active Directory and it cannot be deleted.|Claims provider trusts|
|Issuance Transform Rule Set|A set of claim rules that you use on a relying party trust to specify the claims that will be issued to the relying party.<br /><br />The incoming claims that will be used to source this rule set, will initially be the claims that are output by the acceptance transform rules.|Relying party trusts|
|Issuance Authorization Rule Set|A set of claim rules that you use on a relying party trust to specify the users that will be permitted to receive a token for the relying party.<br /><br />These rules determine whether a user can receive claims for a relying party and, therefore, access to the relying party.<br /><br />Unless you specify an issuance authorization rule, all users will be denied access by default.|Relying party trusts|
|Delegation Authorization Rule Set|A set of claim rules that you use on a relying party trust to specify the users that will be permitted to act as delegates for other users to the relying party.<br /><br />These rules determine whether the requester is permitted to impersonate a user while still identifying the requester in the token that is sent to the relying party.<br /><br />Unless you specify a delegation authorization rule, no users can act as delegates by default.|Relying party trusts|
|Impersonation Authorization Rule Set|A set of claim rules that you configure using Windows PowerShell to determine whether a user can fully impersonate another user to the relying party.<br /><br />These rules determine whether the requester is permitted to impersonate a user without identifying the requester in the token that is sent to the relying party.<br /><br />Impersonating another user in this way is a very powerful capability, because the relying party will not know that the user is being impersonated.|Relying party trust|

For more information about select the appropriate claim rules to use in your organization, see [Determine the Type of Claim Rule Template to Use](Determine-the-Type-of-Claim-Rule-Template-to-Use.md).



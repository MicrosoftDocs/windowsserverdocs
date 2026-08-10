---
title: AD FS Troubleshooting - Claims Rules
description: This article describes how to troubleshoot claims rule syntax with Active Directory Federation Services (AD FS).
ms.date: 02/13/2024
ms.topic: troubleshooting-general
ms.custom: sfi-image-nochange
---

# AD FS troubleshooting: Claims rules syntax

A claim is a statement that one subject makes about itself or another subject. A relying party issues the claims. They're given one or more values and then packaged in security tokens that the Active Directory Federation Services (AD FS) server issues. This article deals with the claims syntax and creation. For information on claims issuance, see [Troubleshoot AD FS](ad-fs-tshoot-claims-issuance.md).

## How claim rules are processed

Claim rules are processed through the [claims pipeline](../../ad-fs/technical-reference/The-Role-of-the-Claims-Pipeline.md) by using the [claims engine](../../ad-fs/technical-reference/The-Role-of-the-Claims-Engine.md). The claims engine is a logical component of AD FS that examines the set of incoming claims presented by a user. Depending on the logic in each rule, it produces an output set of claims.

## How to create a claim rule

Claim rules are created separately for each federated trust relationship within AD FS. They aren't shared across multiple trusts. You can:

- Create a rule from a [claim rule template](../../ad-fs/technical-reference/determine-the-type-of-claim-rule-template-to-use.md).
- Start from scratch by authoring the rule by using the [claim rule language](../../ad-fs/technical-reference/when-to-use-a-custom-claim-rule.md).
- Use Windows PowerShell to customize a rule.

## Components of the claim rule language

The claim rule language consists of the following components, separated by the `" =>"` operator:

- A condition is used to check input claims and determine whether the issuance statement of the rule should be executed. It represents a logical expression that must be evaluated to true to run the rule body part.
- An issuance statement.

Here's an example:

```
c:[type == "Name", value == "domain user"] => issue(type = "Role", value = "employee");
```

This claim has:

- **Condition**: `c:[type == "Name", value == "domain user"]` evaluates the input claim of whether the Windows account name is a domain user.
- **Issuance**: `issue(type = "Role", value = "employee")` adds a new claim to the input claim with the role of employee, if the condition is true.

For more information on claims and the syntax, see [The role of the claim rule language](../../ad-fs/technical-reference/the-role-of-the-claim-rule-language.md).

## Claims rule editor

The claims rule editor performs syntax checking after you finish the claim and select **OK**. If you have the incorrect syntax, the editor informs you.

![Screenshot that shows the A D F S Management dialog with a message stating that the custom claim rule syntax isn't valid.](media/ad-fs-tshoot-claims/claims1.png)

## Event logs

When you try to troubleshoot a claim by using the logs, the best approach is to look for claims output. Look for 1000 and 1001 events in the event log.

![Screenshot that shows the Event Properties dialog box with the results of a 1000 event I D.](media/ad-fs-tshoot-claims/claims2.png)

## Create a sample application

You can also create a sample application that echoes your claims. For example, you can use a sample application and create a relying party that has the same claim that you're trying to troubleshoot and see if the app has any issues with that claim.

![Screenshot that shows the sample application in a browser.](media/ad-fs-tshoot-claims/claim4.png)

A good sample web app is available. The app echoes the claims that it receives from the relying party. To use it, edit the web.config app:

- Change `https://app1.contoso.com/sampapp` to the URL that's used for hosting the sample app.
- Change all instances of `sts.contoso.com` to point to your AD FS server.
- Replace the thumbprint with your thumbprint.
- Replace the `decryptionKey` and the `validationKey` values with values that are appropriate for your scenario.

![Screenshot that shows the web config file in Visual Studio.](media/ad-fs-tshoot-claims/claims3.png)

[This blog article](/archive/blogs/tangent_thoughts/install-and-configure-a-simple-net-4-5-sample-federated-application-samapp) has excellent, in-depth instructions for setting up the app.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)

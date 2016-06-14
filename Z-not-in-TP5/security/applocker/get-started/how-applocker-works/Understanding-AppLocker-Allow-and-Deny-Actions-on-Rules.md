---
title: Understanding AppLocker Allow and Deny Actions on Rules
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9049e7a-5acb-4ca8-9bd9-d2df7511745f
---
# Understanding AppLocker Allow and Deny Actions on Rules
This topic explains the differences between allow and deny actions on AppLocker rules.

## Allow action versus deny action on rules
Unlike Software Restriction Policies \(SRP\), each AppLocker rule collection functions as an allowed list of files. Only the files that are listed within the rule collection are allowed to run. This configuration makes it easier to determine what will occur when an AppLocker rule is applied.

You can also create rules that use the deny action. When applying rules, AppLocker first checks whether any explicit deny actions are specified in the rule list. If you have denied a file from running in a rule collection, the deny action will take precedence over any allow action, regardless of which Group Policy Object \(GPO\) the rule was originally applied in. Because AppLocker functions as an allowed list by default, if no rule explicitly allows or denies a file from running, AppLocker's default deny action will block the file.

### Deny rule considerations
Although you can use AppLocker to create a rule to allow all files to run and then use rules to deny specific files, this configuration is not recommended. The deny action is generally less secure than the allow action because a malicious user could modify the file to invalidate the rule. Deny actions can also be circumvented. For example, if you configure a deny action for a file or folder path, the user can still run the file from any other path. The following table details security concerns for different rule conditions with deny actions.

|Rule condition|Security concern with deny action|
|------------------|-------------------------------------|
|Publisher|A user could modify the properties of a file \(for example, re\-signing the file with a different certificate\).|
|File hash|A user could modify the hash for a file.|
|Path|A user could move the denied file to a different location and run it from there.|

> [!IMPORTANT]
> If you choose to use the deny action on rules, you must ensure that you first create rules that allow the Windows system files to run. AppLocker enforces rules for allowed applications by default, so after one or more rules have been created for a rule collection \(affecting the Windows system files\), only the applications that are listed as being allowed will be permitted to run. Therefore, creating a single rule in a rule collection to deny a malicious file from running will also deny all other files on the computer from running.

## See Also
[How AppLocker Works](How-AppLocker-Works.md)



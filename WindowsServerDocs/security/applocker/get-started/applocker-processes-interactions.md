---
title: applocker Processes and Interactions
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b6f20e22-a96d-4233-886e-b9d687d8cfd2
---
# applocker Processes and Interactions
This topic for the IT professional describes the process dependencies and interactions when applocker evaluates and enforces rules.

## How policies are implemented by applocker
applocker policies are collections of applocker rules that might contain any one of the enforcement settings configured. When applied, each rule is evaluated within the policy and the collection of rules is applied according to the enforcement setting and according to your Group Policy structure.

The applocker policy is enforced on a computer through the Application Identity service, which is the engine that evaluates the policies. If the service is not running, policies will not be enforced. The Application Identity service returns the information from the binary—even if product or binary names are empty—to the results pane of the Local Security Policy snap\-in.

applocker policies are stored in a security descriptor format according to Application Identity service requirements. It uses file path, hash, or fully qualified binary name attributes to form allow or deny actions on a rule. Each rule is stored as an access control entry \(ACE\) in the security descriptor and contains the following information:

-   Either an allow or a deny ACE \("XA" or "XD" in security descriptor definition language \(SDDL\) form\).

-   The user security identifier \(SID\) that this rule is applicable to. \(The default is the authenticated user SID, or "AU" in SDDL.\)

-   The rule condition containing the **appid** attributes.

For example, an SDDL for a rule that allows all files in the %windir% directory to run uses the following format: XA;;FX;;;AU;\(APPID:\/\/PATH \=\= "%windir%\\\*"\).

An applocker policy for DLLs and executable files is read and cached by kernel mode code, which is part of appid.sys. Whenever a new policy is applied, appid.sys is notified by a policy converter task. For other file types, the applocker policy is read every time a **SaferIdentifyLevel** call is made.

### Understanding applocker rules
An applocker rule is a control placed on a file to govern whether or not it is allowed to run for a specific user or group. Rules apply to five different types, or collections, of files:

-   An executable rule controls whether a user or group can run an executable file. Executable files most often have the .exe or .com file name extensions and apply to applications.

-   A script rule controls whether a user or group can run scripts with a file name extension of .ps1, .bat, .cmd, .vbs, and .js.

-   A Windows Installer rule controls whether a user or group can run files with a file name extension of .msi, mst and .msp \(Windows Installer patch\).

-   A DLL rule controls whether a user or group can run files with a file name extension of .dll and .ocx.

-   A Packaged app and Packaged app installer rule controls whether a user or group can run or install a Packaged app. A Packaged app installer has the .appx extension.

There are three different types of conditions that can be applied to rules:

-   A publisher condition on a rule controls whether a user or group can run files from a specific software publisher. The file must be signed.

-   A path condition on a rule controls whether a user or group can run files from within a specific directory or its subdirectories.

-   A file hash condition on a rule controls whether a user or group can run files with matching encrypted hashes.

-   [Understanding applocker Rule Collections]()

    An applocker rule collection is a set of rules that apply to one of the following types: executable files, Windows Installer files, scripts, DLLs, and Packaged apps.

-   [Understanding applocker Rule Condition Types]()

    Rule conditions are criteria that the applocker rule is based on. Primary conditions are required to create an applocker rule. The three primary rule conditions are publisher, path, and file hash.

    -   [Understanding the Publisher Rule Condition in applocker]()

    -   [Understanding the Path Rule Condition in applocker]()

    -   [Understanding the File Hash Rule Condition in applocker]()

-   [Understanding applocker Default Rules]()

    applocker includes default rules for each rule collection. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed in an applocker rule collection.

    -   [Executable Rules in applocker]()

    -   [Windows Installer Rules in applocker]()

    -   [Script Rules in applocker]()

    -   [DLL Rules in applocker]()

    -   [Packaged Apps and Packaged App Installer Rules in applocker](Packaged-Apps-and-Packaged-App-Installer-Rules-in-applocker.md)

-   [Understanding applocker Rule Exceptions]()

    You can apply applocker rules to individual users or a group of users. If you apply a rule to a group of users, all users in that group are affected by that rule. If you need to allow only a subset of a user group to use an application, you can create a special rule for that subset.

-   [Understanding applocker Rule Behavior]() and [Understanding applocker Allow and Deny Actions on Rules]()

    Each applocker rule collection functions as an allowed list of files.

### Understanding applocker policies
An applocker policy is a set of rule collections and their corresponding configured enforcement settings that have been applied to one or more computers.

-   [Understand applocker Enforcement Settings]()

    Rule enforcement is applied only to collections of rules, not individual rules. applocker divides the rules into four collections: executable files, Windows Installer files, scripts, and DLL files. The options for rule enforcement are **Not configured**, **Enforce rules**, or **Audit only**. Together, all applocker rule collections compose the application control policy, or applocker policy. By default, if enforcement is not configured and rules are present in a rule collection, those rules are enforced.

### Understanding applocker and Group Policy
Group Policy can be used to create, modify, and distribute applocker policies in separate objects or in combination with other policies.

-   [Understand applocker Rules and Enforcement Setting Inheritance in Group Policy]()

    When Group Policy is used to distribute applocker policies, rule collections that are not configured will be enforced. Group Policy does not overwrite or replace rules that are already present in a linked Group Policy Object \(GPO\) and applies the applocker rules in addition to existing rules. applocker processes the explicit deny rule configuration before the allow rule configuration, and for rule enforcement, the last write to the GPO is applied.

## See Also
[applocker Technical Reference](applocker-technical-reference.md)



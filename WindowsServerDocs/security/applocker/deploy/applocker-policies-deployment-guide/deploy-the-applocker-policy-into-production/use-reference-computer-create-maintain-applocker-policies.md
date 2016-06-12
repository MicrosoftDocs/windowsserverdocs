---
title: Use a Reference Computer to Create and Maintain applocker Policies
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4137833b-d082-4abb-aa21-004cbe8ba216
---
# Use a Reference Computer to Create and Maintain applocker Policies
This topic for the IT professional describes the steps to create and maintain applocker policies by using a reference computer.

## Background and prerequisites
An applocker reference computer is a baseline computer you can use to configure policies and can subsequently be used to maintain applocker policies. For the procedure to configure a reference computer, see [Configure the applocker Reference Computer](assetId:///615506e9-fc32-4003-a241-01794c3a9bd3).

An applocker reference computer that is used to create and maintain applocker policies should contain the corresponding applications for each organizational unit \(OU\) to mimic your production environment.

> [!IMPORTANT]
> The reference computer must be running one of the supported editions of Windows. For information about operating system requirements for applocker, see [Requirements to Use applocker]().

You can perform applocker policy testing on the reference computer by using the **Audit only** enforcement setting or Windows PowerShell cmdlets. You can also use the reference computer as part of a testing configuration that includes policies that are created by using Software Restriction Policies.

## Step 1: Automatically generate rules on the reference computer
With applocker, you can automatically generate rules for all files within a folder. applocker scans the specified folder and creates the condition types that you choose for each file in that folder. For the procedure to do this, see [Run the Automatically Generate Rules Wizard]().

> [!NOTE]
> If you run this wizard to create your first rules for a Group Policy Object \(GPO\), after you complete the wizard, you will be prompted to create the default rules, which allow critical system files to run. You can edit the default rules at any time. If your organization has decided to edit the default rules or create custom rules to allow the Windows system files to run, ensure that you delete the default rules after you replace them with your custom rules.

## Step 2: Create the default rules on the reference computer
applocker includes default rules for each rule collection. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed in an applocker rule collection. You must run the default rules for each rule collection. For information about default rules and considerations for using them, see [Understanding applocker Default Rules](). For the procedure to create default rules, see [Create applocker Default Rules]().

> [!IMPORTANT]
> You can use the default rules as a template when you create your own rules. This allows files within the Windows directory to run. However, these rules are only meant to function as a starter policy when you are first testing applocker rules.

## Step 3: Modify rules and the rule collection on the reference computer
If applocker policies are currently running in your production environment, export the policies from the corresponding GPOs and save them to the reference computer. For the procedure to do this, see [Export an applocker Policy from a GPO](). If no applocker policies have been deployed, create the rules and develop the policies by using the following procedures:

-   [Create a Rule That Uses a Publisher Condition]()

-   [Create a Rule That Uses a File Hash Condition]()

-   [Create a Rule That Uses a Path Condition]()

-   [Edit applocker Rules]()

-   [Configure Exceptions for an applocker Rule]()

-   [Delete an applocker Rule]()

-   [Enable the DLL Rule Collection]()

-   [Enforce applocker Rules]()

## Step 4: Test and update applocker policy on the reference computer
You should test each set of rules to ensure that they perform as intended. The **Test\-applockerPolicy** Windows PowerShell cmdlet can be used to determine whether any of the rules in your rule collection will be blocked on your reference computer. Perform the steps on each reference computer that you used to define the applocker policy. Ensure that the reference computer is joined to the domain and that it is receiving the applocker policy from the appropriate GPO. Because applocker rules are inherited from linked GPOs, you should deploy all of the rules to simultaneously test all of your test GPOs. Use the following procedures to complete this step:

-   [Test an applocker Policy with Test\-applockerPolicy](http://technet.microsoft.com/library/ee791772(WS.10).aspx)

-   [Discover the Effect of an applocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx)

> [!CAUTION]
> If you have set the enforcement setting on the rule collection to **Enforce rules** or you have not configured the rule collection, the policy will be implemented when the GPO is updated in the next step. If you have set the enforcement setting on the rule collection to **Audit only**, application access events are written to the applocker log, and the policy will not take effect.

## Step 5: Export and import the policy into production
When the applocker policy has been tested successfully, it can be imported into the GPO \(or imported into individual computers that are not managed by Group Policy\) and checked for its intended effectiveness. To do this, perform the following procedures:

-   [Export an applocker Policy to an XML File]()

-   [Import an applocker Policy into a GPO]() or

-   [Discover the Effect of an applocker Policy](http://technet.microsoft.com/library/ee791823(WS.10).aspx)

If the applocker policy enforcement setting is **Audit only** and you are satisfied that the policy is fulfilling your intent, you can change it to **Enforce rules**. For information about how to change the enforcement setting, see [Configure an applocker Policy for Enforce Rules]().

## Step 6: Monitor the effect of the policy in production
If additional refinements or updates are necessary after a policy is deployed, use the appropriate following procedures to monitor and update the policy:

-   [Monitor Application Usage with applocker]()

-   [Edit an applocker Policy]()

-   [Refresh an applocker Policy]()

## See also
[Deploy the applocker Policy into Production]()



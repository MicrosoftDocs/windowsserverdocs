---
title: Edit an AppLocker Policy
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df5a618f-141a-4435-b496-13274b7bd7e5
---
# Edit an AppLocker Policy
This topic describes the steps you need to perform to modify an AppLocker policy in  Windows Server 2012  and Windows 8.

You can edit an AppLocker policy by adding, changing, or removing rules. However, you cannot create a new version of the policy by importing additional rules. To modify an AppLocker policy that is in production, you should use Group Policy management software that allows you to version Group Policy Objects \(GPOs\). If you have created multiple AppLocker policies and need to merge them to create one AppLocker policy, you can either manually merge the policies or use the Windows PowerShell cmdlets for AppLocker. You cannot automatically merge policies by using the AppLocker snap\-in. You must create one rule collection from two or more policies. The AppLocker policy is saved in XML format, and the exported policy can be edited with any text or XML editor. For information about merging policies, see [Merge AppLocker Policies Manually](Merge-AppLocker-Policies-Manually.md) or [Merge AppLocker Policies by Using Set-ApplockerPolicy](Merge-AppLocker-Policies-by-Using-Set-ApplockerPolicy.md).

There are two methods you can use to edit an AppLocker policy:

-   [Editing an AppLocker policy by using Group Policy](#BKMK_EditAppPolinGPO)

-   [Editing an AppLocker policy by using the Local Security Policy snap\-in](#BKMK_EditAppLolNotinGPO)

## <a name="BKMK_EditAppPolinGPO"></a>Editing an AppLocker policy by using Group Policy
The steps to edit an AppLocker policy distributed by Group Policy include the following:

### Step 1: Use Group Policy management software to export the AppLocker policy from the GPO
AppLocker provides a feature to export and import AppLocker policies as an XML file. This allows you to modify an AppLocker policy outside your production environment. Because updating an AppLocker policy in a deployed GPO could have unintended consequences, you should first export the AppLocker policy to an XML file. For the procedure to do this, see [Export an AppLocker Policy from a GPO](Export-an-AppLocker-Policy-from-a-GPO.md).

### Step 2: Import the AppLocker policy into the AppLocker reference computer or the computer you use for policy maintenance
After exporting the AppLocker policy to an XML file, you should import the XML file onto a reference computer so that you can edit the policy. For the procedure to import an AppLocker policy, see [Import an AppLocker Policy from Another Computer](Import-an-AppLocker-Policy-from-Another-Computer.md).

> [!CAUTION]
> Importing a policy onto another computer will overwrite the existing policy on that computer.

### Step 3: Use AppLocker to modify and test the rule
AppLocker provides ways to modify, delete, or add rules to a policy by modifying the rules within the collection.

-   For the procedure to modify a rule, see [Edit AppLocker Rules](Edit-AppLocker-Rules.md).

-   For the procedure to delete a rule, see [Delete an AppLocker Rule](Delete-an-AppLocker-Rule.md).

-   For procedures to create rules, see:

    -   [Create a Rule That Uses a Publisher Condition](Create-a-Rule-That-Uses-a-Publisher-Condition.md)

    -   [Create a Rule That Uses a Path Condition](Create-a-Rule-That-Uses-a-Path-Condition.md)

    -   [Create a Rule That Uses a File Hash Condition](Create-a-Rule-That-Uses-a-File-Hash-Condition.md)

    -   [Enable the DLL Rule Collection](Enable-the-DLL-Rule-Collection.md)

-   For steps to test an AppLocker policy, see [Test and Update an AppLocker Policy](Test-and-Update-an-AppLocker-Policy.md).

-   For procedures to export the updated policy from the reference computer back into the GPO, see [Export an AppLocker Policy to an XML File](Export-an-AppLocker-Policy-to-an-XML-File.md) and [Import an AppLocker Policy into a GPO](Import-an-AppLocker-Policy-into-a-GPO.md).

### Step 4: Use AppLocker and Group Policy to import the AppLocker policy back into the GPO
For procedures to export the updated policy from the reference computer back into the GPO, see [Export an AppLocker Policy to an XML File](Export-an-AppLocker-Policy-to-an-XML-File.md) and [Import an AppLocker Policy into a GPO](Import-an-AppLocker-Policy-into-a-GPO.md).

> [!CAUTION]
> You should never edit an AppLocker rule collection while it is being enforced in Group Policy. Because AppLocker controls what files are allowed run, making changes to a live policy can create unexpected behavior. For information about testing policies, see [Test and Update an AppLocker Policy](Test-and-Update-an-AppLocker-Policy.md).

> [!NOTE]
> If you are performing these steps by using Microsoft Advanced Group Policy Management \(AGPM\), check out the GPO before exporting the policy.

## <a name="BKMK_EditAppLolNotinGPO"></a>Editing an AppLocker policy by using the Local Security Policy snap\-in
The steps to edit an AppLocker policy distributed by using the Local Security Policy snap\-in include the following tasks.

### Step 1: Import the AppLocker policy
On the computer where you maintain policies, open the AppLocker snap\-in from the Local Security Policy snap\-in. If you exported the AppLocker policy from another computer, use AppLocker to import it onto the computer.

After exporting the AppLocker policy to an XML file, you should import the XML file onto a reference computer so that you can edit the policy. For the procedure to import an AppLocker policy, see [Import an AppLocker Policy from Another Computer](Import-an-AppLocker-Policy-from-Another-Computer.md).

> [!CAUTION]
> Importing a policy onto another computer will overwrite the existing policy on that computer.

### Step 2: Identify and modify the rule to change, delete, or add
AppLocker provides ways to modify, delete, or add rules to a policy by modifying the rules within the collection.

-   For the procedure to modify a rule, see [Edit AppLocker Rules](Edit-AppLocker-Rules.md).

-   For the procedure to delete a rule, see [Delete an AppLocker Rule](Delete-an-AppLocker-Rule.md).

-   For procedures to create rules, see:

    -   [Create a Rule That Uses a Publisher Condition](Create-a-Rule-That-Uses-a-Publisher-Condition.md)

    -   [Create a Rule That Uses a Path Condition](Create-a-Rule-That-Uses-a-Path-Condition.md)

    -   [Create a Rule That Uses a File Hash Condition](Create-a-Rule-That-Uses-a-File-Hash-Condition.md)

    -   [Enable the DLL Rule Collection](Enable-the-DLL-Rule-Collection.md)

### Step 3: Test the effect of the policy
For steps to test an AppLocker policy, see [Test and Update an AppLocker Policy](Test-and-Update-an-AppLocker-Policy.md).

### Step 4: Export the policy to an XML file and propagate it to all targeted computers
For procedures to export the updated policy from the reference computer to targeted computers, see [Export an AppLocker Policy to an XML File](Export-an-AppLocker-Policy-to-an-XML-File.md) and [Import an AppLocker Policy from Another Computer](Import-an-AppLocker-Policy-from-Another-Computer.md).

## Additional resources

-   For steps to perform other AppLocker policy tasks, see [Administer AppLocker](Administer-AppLocker.md).

## See Also
[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)



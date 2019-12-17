---
title: Create an Automatic Classification Rule
description: This article describes how to create a classification rule for a property.
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create an Automatic Classification Rule

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

The following procedure guides you through the process of creating a classification rule. Each rule sets the value for a single property. By default, a rule is run only once and ignores files that already have a property value assigned. However, you can configure a rule to evaluate files regardless of whether a value is already assigned to the property.

## To create a Classification Rule

1.  In **Classification Management**, click the **Classification Rules** node.

2.  Right-click **Classification Rules**, and then click **Create a New Rule** (or click **Create a New Rule** in the **Actions** pane). This opens the **Classification Rule Definitions** dialog box.

3.  On the **Rule Settings** tab, enter the following information:

    -   **Rule name**. Type a name for the rule.
    -   **Enabled**. This rule will only be applied if the Enabled check box is selected. To disable the rule, clear this box.
    -   **Description**. Type an optional description for this rule.
    -   **Scope**. Click **Add** to select a location where this rule will apply. You can add multiple locations, or remove a location by clicking **Remove**. The classification rule will apply to all folders and their subfolders in this list.

4.  On the **Classification** tab, enter the following information:

    -   **Classification mechanism**. Choose a method for assigning the property value.
    -   **Property name**. Select the property that this rule will assign.
    -   **Property value**. Select the property value that this rule will assign.

5.  Optionally, click the **Advanced** button to select further options. On the **Evaluation Type** tab, the check box to **Re-evaluate files** is unchecked by default. The options that can be selected here are as follows:

    -   **Re-evaluate files** unchecked: A rule is applied to a file if, and only if, the property specified by the rule has not been set to any value on the file.
    -   **Re-evaluate files** checked and the **Overwrite the existing value** option selected: the rule will be applied to the files every time the automatic classification process runs. For example, if a file has a Boolean property that is set to **Yes**, a rule using the folder classifier to set all files to **No** with this option set will leave the property set to **No**.
    -   **Re-evaluate files** checked and the **Aggregate the values** option selected: The rule will be applied to the files every time the automatic classification process runs. However, when the rule has decided what value to set the property file to, it aggregates that value with the one already in the file. For example, if a file has a Boolean property that is set to **Yes**, a rule using the folder classifier to set all files to **No** with this option set will leave the property set to **Yes**.

    On the **Additional Classification Parameters** tab, you can specify additional parameters that are recognized by the selected classification method by entering the name and value and clicking the **Insert** button.

6.  Click **OK** or **Cancel** to close the **Advanced** dialog box.

7.  Click **OK**.

## See also

-   [Create a Classification Property](create-classification-property.md)
-   [Classification Management](classification-management.md)
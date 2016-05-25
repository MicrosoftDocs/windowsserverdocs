---
title: Configure Classification Rules
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3771cc72-cc54-4f5b-87db-9851038be662
author: JasonGerend
---
# Configure Classification Rules
Classification properties are used to categorize files. They can be used to restrict access to files and to select files for scheduled file management tasks. The following procedure guides you through the process of creating a classification rule, assuming that the classification properties that you want to set have already been created. Each rule sets the value for a single property.  
  
> [!NOTE]  
> The Windows PowerShell classifier requires that the Windows PowerShell execution policy allows the script to run.  
  
#### To create a classification rule  
  
1.  In **Classification Management**, click the **Classification Rules** node.  
  
2.  Right\-click **Classification Rules**, and then click **Create Classification Rule**. This opens the **Create Classification Rule** dialog box.  
  
3.  On the **General** tab, enter the following information:  
  
    -   **Rule name**. Type a name for the rule.  
  
    -   **Enabled**. This rule will only be applied if the **Enabled** box is selected. To disable the rule, clear this box.  
  
    -   **Description**. Type an optional description for this rule.  
  
4.  On the **Scope** tab, specify what folders you want to classify by entering the following information:  
  
    -   Optionally, click **Set Folder Management Properties** to assign Folder Usage property values to folders and then click **Close** when you are finished. The Folder Usage property specifies the purpose of a folder and the kind of files that are stored in it. File management tasks and classification rules can use the value of the Folder Usage property that is assigned to a folder to determine whether to include the folder in a file management task or classification rule.  
  
    -   In the first box, specify the folders to include based on the Folder Usage property values that are assigned to the folders. When you select a Folder Usage property, all folders with that property assigned are listed as part of the scope.  
  
    -   Click **Add** to manually specify folders to include—independent of their assigned Folder Usage values.  
  
5.  On the **Classification** tab, enter the following information:  
  
    -   In the **Classification method** section, choose the classifier module that will assign the property to files.  
  
    -   In the **Property** section, choose the property to assign to files, and set the value of the property.  
  
    -   In the **Parameters** section, if present, click **Configure** to specify additional parameters that are recognized by the selected classification method.  
  
6.  On the **Evaluation Type** tab, optionally specify whether this classification rule should overwrite or add to any existing properties that are assigned to the affected files by using the following settings:  
  
    -   **Re\-evaluate existing property values** Controls whether this classification rule should overwrite or add to any existing properties that are assigned to the affected files. When the check box is cleared, the classification rule only applies if the property that is specified by the rule has not already been assigned to the affected files.  
  
    -   **Overwrite the existing value** Specifies that the rule should overwrite any existing values for the property that is assigned by the rule.  
  
    -   **Aggregate the values** Specifies that the rule should combine the values that are assigned by the rule with any already assigned to the file.  
  
7.  Click **OK** when you are finished creating the rule.  
  
8.  Optionally, in the **Classification Rules** node, click **Configure Classification Schedule** to schedule the rules to run automatically, or click **Run Classification With All Rules Now** to run the rules immediately.  
  

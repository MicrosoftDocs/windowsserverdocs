---
title: Create a Classification Property
description: This article describes classification properties, used to assign values to files within a specified folder or volume.
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a Classification Property

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

Classification properties are used to assign values to files within a specified folder or volume. There are many property types that you can choose from, depending on your needs. The following table defines the available property types.

|Property | Description |
| --- | --- |
| Yes/No | A Boolean property that can be **Yes** or **No**. When combining multiple values during classification or from file content, a **No** value will be overridden by a **Yes** value. |
| Date-time | A simple date/time property. When combining multiple values during classification or from file content, conflicting values will prevent re-classification. |
| Number | A simple number property. When combining multiple values during classification or from file content, conflicting values will prevent re-classification. |
| Ordered List | A list of fixed values. Only one value can be assigned to a property at a time. When combining multiple values during classification or from file content, the value highest in the list will be used. |
| String | A simple string property. When combining multiple values during classification or from file content conflicting values will prevent re-classification. |
| Multi-choice | A list of values that can be assigned to a property. More than one value can be assigned to a property at a time. When combining multiple values during classification or from file content, each value in the list will be used. |
| Multi-string | A list of strings that can be assigned to a property. More than one value can be assigned to a property at a time. When combining multiple values during classification or from file content, each value in the list will be used. |

<br />

The following procedure guides you through the process of creating a classification property.

## To create a Classification Property

1.  In **Classification Management**, click the **Classification Properties** node.

2.  Right-click **Classification Properties**, and then click **Create property** (or click **Create property** in the **Actions** pane). This opens the **Classification Property Definitions** dialog box.

3.  In the **Property Name** text box, type a name for the property.

4.  In the **Description** text box, add an optional description for the property.

5.  In the **Property Type** drop-down menu, select a property type from the list.

6.  Click **OK**.

## See also

-   [Create an Automatic Classification Rule](create-automatic-classification-rule.md)
-   [Classification Management](classification-management.md)
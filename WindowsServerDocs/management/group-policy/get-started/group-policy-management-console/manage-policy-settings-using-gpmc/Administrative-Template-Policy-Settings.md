---
title: Working with the Administrative Template Policy Settings Using GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 33b16754-d7bb-4f3f-94dc-4b61bb90a583
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Working with the Administrative Template Policy Settings Using GPMC

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to manage the Group Policy Administrative Template Policy using the GPMC

For information about how to edit Administrative Template Policy settings using the **Local Group Policy Editor**, see [Working with the Administrative Template policy settings using the Local Group Policy Editor](../../local-group-policy-editor/Working-with-the-Administrative-Template-policy-settings-using-the-Local-Group-Policy-Editor.md).

This topic contains procedures for Administrative Templates (ADMX) and Classic Administrative Templates (ADM):

-   How to edit Administrative policy settings

-   How to filter Administrative Template policy settings

-   How to filter using Keyword filters

-   How to filter by using Requirement filters

-   How to add comments to Administrative Template policy settings

-   How to add or remove Classic Administrative Templates (.adm files)

-   Filtering Classic Administrative Templates

## <a name="BKMK_Edit_ADMX"></a>Administrative Templates (ADMX)
Administrative Templates are registry-based policy settings that appear under the **Administrative Templates** node of both the **Computer** and **User Configuration** nodes. This hierarchy is created when the Group Policy Management Console reads XML-based Administrative Template files (.admx).

### How to edit Administrative policy settings

##### To edit Administrative Template policy settings

1.  Open the Group Policy Management Console. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  In the console tree, click the folder under **Administrative Templates** that contains the policy settings you want to configure.

3.  In the **Setting** column, click the name for a policy setting to read a description of the policy setting.

4.  To change that policy setting, double-click the name of the policy setting.

5.  On the policy setting dialog box, click one of the following:

    -   **Not Configured**: The registry is not modified.

    -   **Enabled**: The registry reflects that the policy setting is selected.

    -   **Disabled**: The registry reflects that the policy setting is not selected.

6.  Select any other options, and then click **OK**.

#### Additional considerations

-   Settings for **HKEY_LOCAL_MACHINE** are under **Computer Configuration**, and settings for **HKEY_CURRENT_USER** are under **User Configuration**.

-   If computer policy conflicts with user policy, computer policy generally takes precedence. However, if application authors disregard this convention, Group Policy cannot enforce it.

-   Administrative Template policy settings are also known as registry-based policy settings.

### How to filter Administrative Template policy settings
The Group Policy Management Console provides the option to filter Administrative Template policy settings based on:

-   Managed, Configured, or Commented policy settings.

-   Keywords within the title, Help text, or comment of policy settings.

-   Platform or application requirements of policy settings.

Apply filters on Administrative Template policy settings when you want to find a specific policy setting or when you want to limit the number of policy settings displayed in the Group Policy Management Console.

#### Managed
There are two kinds of Administrative Template policy settings: **Managed** and **Unmanaged**. The Group Policy service governs Managed policy settings and removes a policy setting when it is no longer within scope of the user or computer.

The Group Policy service does not govern unmanaged policy settings. These policy settings are persistent. The Group Policy service does not remove unmanaged policy settings, even if the policy setting is not within scope of the user or computer. Typically, you use these types of policy settings to set preferences for operating system components that are not policy enabled. You can also use unmanaged policy settings for application settings.

The Managed property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Group Policy Management Console to display all Administrative Template policy settings. Setting this property filter to **Yes** causes the editor to show only managed Administrative Template policy settings, hiding all unmanaged Administrative Template policy settings. Setting this property filter to **No** causes the editor to show only unmanaged Administrative Template policy settings, hiding all managed Administrative Template policy settings.

#### <a name="BKMK_MANAGED_PROC"></a>
###### To set the Administrative Templates Managed property filter

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Managed** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings, and close the **Filter Options** dialog box.

#### Configured
You can configure Administrative Template policy settings to one of three states: **Not Configured**, **Enabled**, and **Disabled**. **Not Configured** is the default state for all policy settings. Policy settings set to **Not Configured** do not affect users or computers. Enabling an Administrative Template policy setting activates the policy setting. When **Enabled**, the action described in the title of the policy setting applies to the user or computer. When **Disabled**, the opposite action described in the title of the policy setting applies to the user or computer. Usually **Not Configured** and **Disabled** policy settings produce the same results. The difference is that **Not Configured** policy settings do not apply to the user, but **Disabled** policy settings apply to a user.

Each Administrative Template policy setting provides detailed information about its **Enabled**, **Disabled**, and **Not Configured** states. You can view this information in the **Help** pane of each Administrative Template policy setting. Or, you can view this information for the selected policy setting in the Extended View of the editor.

The Configured property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Group Policy Management Console to display all Administrative Template policy settings and is the default setting for this filter. Setting this property filter to **Yes** causes the editor to show only configured Administrative Template policy settings, hiding not configured policy settings. Setting this property filter to **No** causes the editor to show only not configured Administrative Template policy settings, hiding configured policy settings.

#### <a name="BKMK_CONFIGURED_PROC"></a>
###### To set the Administrative Templates Configured property filter

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Configured** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings, and close the **Filter Options** dialog box.

#### Commented
Each Administrative Template policy setting has a comment property. The Commented property allows you to enter text associated with a specific policy setting.

The Commented property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Group Policy Management Editor to display all Administrative Template policy settings and is the default setting for this filter. Setting this proper filter to **Yes** causes the editor to show only commented Administrative Template policy settings, hiding policy settings without comments. Setting this property filter to **No** causes the editor to show only Administrative Template policy settings without comments, hiding commented policy settings.

###### To set the Administrative Templates Commented property filter

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Commented** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

##### Additional considerations

-   Filters are inclusive; therefore, select items you want to display rather than items you want to be removed.

-   Filters do not work with [Classic Administrative Templates](https://technet.microsoft.com/library/cc725586.aspx).

#### How to filter using Keyword filters
The Group Policy Management Console allows you to change the criteria for displaying Administrative Template policy settings. By default, the editor displays all policy settings, including preference settings (previously referred to as unmanaged policy settings). However, you can use keyword filters to change how the Group Policy Management Editor displays Administrative Template policy settings.

###### To set the Administrative Templates Keyword filter

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  Right-click **Administrative Templates** located under **Computer Configuration** or **User Configuration**. Click **Filter Options**.

3.  Select the **Enable Keyword Filters** check box.

4.  Type one or more keywords in the **Filter for word(s)** box.

5.  In the **Search Criteria** list, click the appropriate filter:

    -   **Any**: The filter includes any of the words in the **Filter for word(s)** box.

    -   **All**: The filter includes all of the words in the **Filter for word(s)** box.

    -   **Exact**: The filter includes exact matches of the words in the **Filter for word(s)** box.

6.  Select the appropriate check boxes next to **Within**.

    -   **Policy Setting Title**: The filter includes searching the title of the policy setting.

    -   **Help Text**: The filter includes searching the Help text of the policy setting.

    -   **Comment**: The filter includes searching the comment of the policy setting

7.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

##### Additional considerations

-   Filters are inclusive; therefore, select items you want to display rather than items you want to be removed.

-   Filters do not work with [Classic Administrative Templates](https://technet.microsoft.com/library/cc725586.aspx).

#### How to filter by using Requirement filters
The Group Policy Management Console allows you to change the criteria for displaying Administrative Template policy settings. By default, the editor displays all policy settings, including preference settings (previously referred to as unmanaged policy settings). However, you can use requirement filters to change how the Group Policy Management Console displays Administrative Template policy settings.

###### To set the Administrative Templates Requirement filter

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  Right-click **Administrative Templates** located under **Computer Configuration** or **User Configuration**. Click **Filter Options**.

3.  Select the **Enable Requirements Filters** check box.

4.  Type one or more keywords in the **Filter for word(s)** box.

5.  In the **Select the desired platform and application filter(s)** list, click the appropriate filter:

    -   **Include settings that match any of the selected platforms**.

    -   **Include settings that match all of the selected platforms**.

        > [!NOTE]
        > You can click **Select All** to select all of the items in the list, or you can click **Clear All** to clear all of the items in the list.

6.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

##### Additional considerations

-   Filters are inclusive; therefore, select items you want to display rather than items you want to be removed.

-   Filters do not work with [Classic Administrative Templates](https://technet.microsoft.com/library/cc725586.aspx).

### How to add comments to Administrative Template policy settings
You can include comments for each Administrative Template policy setting. You can use this space to further document the policy setting and why its implementation is important to your environment. Commenting policy settings allows you to later use keyword filters to help you quickly find policy settings with matching keywords.

##### To comment an Administrative Template policy setting

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  In the console tree, click the folder under **Administrative Templates** that contains the policy settings you want to configure.

3.  In the **Setting** column, double-click the name for the policy setting.

4.  Type your comments in the **Comment** box.

5.  Click **OK**.

## <a name="BKMK_Edit_ADM"></a>Classic Administrative Templates (ADM)
Classic Administrative Template files (also known as ADM files) do not use an XML format. Earlier versions of the Group Policy Management tool (previously titled Group Policy Object Editor) displayed these settings under the **Administrative Templates** node.

The current version of Administrative Template files (known as ADMX files) use XML. The Group Policy Management Console displays these settings under the **Administrative Templates** node. However, the Group Policy Management Console still recognizes ADM files and displays these settings under the **Classic Administrative Templates** node, which is a child node of **Administrative Templates**.

### How to add or remove Classic Administrative Templates (.adm files)

##### To add or remove Classic Administrative Templates (.adm files)

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  In the console tree, under either **Computer Configuration** or **User Configuration**, right-click **Administrative Templates**.

3.  Click **Add/Remove Templates**.

4.  Do one of the following:

    -   To add a template, click **Add**. In the **Policy Templates** dialog box, click the template you want to add, and then click **Open**.

    -   To remove a template, in the **Current Policy Templates** list, click the template, and then click **Remove**.

### Filtering Classic Administrative Templates
The Group Policy Management Console displays all Classic Administrative Templates policy settings under the **Classic Administrative Templates** node, which is a subfolder of **Administrative Templates**. This view includes both managed policy settings and preference settings included in any Classic Administrative Templates (also known as ADM files).The filtering options included in the Group Policy Management Console apply only to Administrative Templates (ADMX files) and do not apply to Classic Administrative Templates.



---
title: Step 4 - Configure Group Policy settings for automatic updates
description: This article is step four in a four-step process for deploying Windows Server Update Services (WSUS).
ms.topic: article
ms.assetid: 62177d05-d832-4ea8-bca4-47a8cd34a19c
ms.author: alalve
author: robinharwood
manager: mtillman
ms.date: 09/21/2023
---

# Step 4: Configure Group Policy settings for automatic updates

In an Active Directory environment, you can use Group Policy to define how computers and users can interact with Windows Update to obtain automatic updates from Windows Server Update Services (WSUS). This article refers to these computers and users as *WSUS clients*.

This article contains two main sections:

- [Group Policy settings for WSUS client updates](#group-policy-settings-for-wsus-client-updates) provides prescriptive guidance and behavioral details about the Windows Update and Maintenance Scheduler settings of Group Policy that control how WSUS clients can interact with Windows Update to obtain automatic updates.

- [Supplemental information](#supplemental-information) has the following subsections:

  - [Access the Windows Update settings in Group Policy](#access-the-windows-update-settings-in-group-policy) provides general guidance about using the Group Policy Management Editor (GPME). It also has information about accessing the policy extensions and Maintenance Scheduler settings in Group Policy for update services.

  - [Changes to WSUS relevant to this guide](#changes-to-wsus) gives a brief summary of key differences between the current and past versions of WSUS relevant to this guide. It's for administrators familiar with WSUS 3.2 and previous versions.

  - [Terms and definitions](#terms-and-definitions) defines terms that pertain to WSUS and update services.

## Group Policy settings for WSUS client updates

This section provides information about the following three extensions of Group Policy. In these extensions, you find the settings that you can use to configure how WSUS clients interact with Windows Update to receive automatic updates.

- [Computer Configuration &gt; Windows Update policy settings](#computer-configuration--windows-update-policy-settings)
- [Computer Configuration &gt; Maintenance Scheduler settings](#computer-configuration--maintenance-scheduler-settings)
- [User Configuration &gt; Windows Update policy settings](#user-configuration--windows-update-policy-settings)

> [!NOTE]
> This article assumes that you already use and are familiar with Group Policy. If you're not familiar with Group Policy, we advise that you review the information in the [Supplemental information](#supplemental-information) section of this article before you try to configure policy settings for WSUS.

### Computer Configuration > Windows Update policy settings

This section provides details about the following computer-based policy settings:

- [Allow Automatic Updates immediate installation](#allow-automatic-updates-immediate-installation)
- [Allow non-administrators to receive update notifications](#allow-non-administrators-to-receive-update-notifications)
- [Allow signed updates from an intranet Microsoft update service location](#allow-signed-updates-from-an-intranet-microsoft-update-service-location)
- [Automatic Updates detection frequency](#automatic-updates-detection-frequency)
- [Configure Automatic Updates](#configure-automatic-updates)
- [Delay Restart for scheduled installations](#delay-restart-for-scheduled-installations)
- [Do not adjust default option to 'Install Updates and Shut Down' in Shut Down Windows dialog box](#do-not-adjust-default-option-to-install-updates-and-shut-down-in-shut-down-windows-dialog-box)
- [Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box](#do-not-display-install-updates-and-shut-down-option-in-shut-down-windows-dialog-box)
- [Enable client-side targeting](#enable-client-side-targeting)
- [Enabling Windows Update Power Management to automatically wake up the computer to install scheduled updates](#enabling-windows-update-power-management-to-automatically-wake-up-the-computer-to-install-scheduled-updates)
- [No auto-restart with logged on users for scheduled automatic updates installations](#no-auto-restart-with-logged-on-users-for-scheduled-automatic-updates-installations)
- [Re-prompt for restart with scheduled installations](#re-prompt-for-restart-with-scheduled-installations)
- [Reschedule Automatic Updates scheduled installations](#reschedule-automatic-updates-scheduled-installations)
- [Specify intranet Microsoft update service location](#specify-intranet-microsoft-update-service-location)
- [Turn on recommended updates via Automatic Updates](#turn-on-recommended-updates-via-automatic-updates)
- [Turn on Software Notifications](#turn-on-software-notifications)

In the GPME, Windows Update policies for computer-based configuration are located in the path **\<policy-name\>** > **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Update**.

> [!NOTE]
> By default, these settings aren't configured.

#### Allow Automatic Updates immediate installation

You can use this policy setting to specify whether automatic updates automatically install updates that don't interrupt Windows services or restart Windows.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> If the **Configure Automatic Updates** policy setting is set to **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that updates aren't immediately installed. Local administrators can change this setting by using the Local Group Policy Editor.|
|**Enabled**|Specifies that automatic updates immediately install updates after they're downloaded and ready to install.|
|**Disabled**|Specifies that updates aren't immediately installed.|

**Options:** There are no options for this setting.

#### Allow non-administrators to receive update notifications

You can use this policy setting to specify whether non-administrative users receive update notifications based on the **Configure Automatic Updates** policy setting.

|Supported on|Excluding|
|---------|-------|
|Windows Server 2012 R2, Windows 8.1, and earlier versions|None|

> [!NOTE]
> If the **Configure Automatic Updates** policy setting is **Disabled** or **Not Configured**, this policy setting has no effect.

> [!IMPORTANT]
> Starting in Windows 8 and Windows RT, this policy setting is enabled by default. In all prior versions of Windows, it's disabled by default.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that users always see a **User Account Control** consent prompt and require elevated permissions to manage updates. A local administrator can change this setting by using the Local Group Policy Editor.<br><br>In Windows Vista, users also see a **User Account Control** consent prompt when hiding, restoring, and canceling updates, and they require elevated permissions to hide, restore, or cancel updates.|
|**Enabled**|Specifies that Windows Update and Microsoft Update include non-administrators when determining which signed-in user receives update notifications. Non-administrative users are able to install all optional, recommended, and important update content for which they receive a notification. Users don't see a **User Account Control** consent prompt. Users don't need elevated permissions to install these updates, except for updates that contain changes to the user interface, Microsoft Software License Terms, or Windows Update settings.<br><br>The operating system determines the effect of this setting on users' ability to hide, restore, and cancel updates:<p>-  In Windows Vista and Windows XP, users don't see a **User Account Control** consent prompt. These users don't need elevated permissions to hide, restore, or cancel updates.<br />-  In Windows 7, this policy setting has no effect. Users always see a **User Account Control** consent prompt, and they require elevated permissions to do these tasks.<br />-  In Windows 8 and Windows RT, this policy setting has no effect.|
|**Disabled**|Specifies that only signed-in administrators receive update notifications.|

**Options:** There are no options for this setting.

#### Allow signed updates from an intranet Microsoft update service location

You can use this policy setting to specify whether automatic updates accept updates that are signed by entities other than Microsoft when the update is found on an intranet Microsoft update service location.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
> Updates from a service other than an intranet Microsoft update service must always be signed by Microsoft. This policy setting doesn't affect those updates.

**Options:** There are no options for this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that updates from an intranet Microsoft update service location must be signed by Microsoft.|
|**Enabled**|Specifies that automatic updates accept updates received through an intranet Microsoft update service location if they're signed by a certificate found in the local computer's Trusted Publishers certificate store.|
|**Disabled**|Specifies that updates from an intranet Microsoft update service location must be signed by Microsoft.|

**Options:** There are no options for this setting.

#### Always automatically restart at the scheduled time

You can use this policy setting to specify whether a restart timer always begins immediately after Windows Update installs important updates, instead of first notifying users on the sign-in screen for at least two days.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> If the **No auto-restart with logged on users for scheduled automatic updates installations** policy setting is enabled, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Windows Update doesn't alter the computer's restart behavior.|
|**Enabled**|Specifies that a restart timer always begins immediately after Windows Update installs important updates, instead of first notifying users on the sign-in screen for at least two days.<p>The restart timer can be configured to start with any value from 15 to 180 minutes. When the timer runs out, the restart proceeds even if the computer has signed-in users.|
|**Disabled**|Specifies that Windows Update doesn't alter the computer's restart behavior.|

**Options:** If this setting is enabled, you can specify the amount of time that elapses after updates are installed before a forced computer restart occurs.

#### Automatic Updates detection frequency

You can use this policy setting to specify the hours that Windows uses to determine how long to wait before checking for available updates. The exact wait time is between 80 and 100 percent of the hours specified in this frequency. For example, if this policy is used to specify a 20-hour detection frequency, all clients to which this policy applies wait between 16 and 20 hours before checking for updates.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
>
> - The **Specify intranet Microsoft update service location** setting must be **Enabled** for this policy to take effect.
> - If the **Configure Automatic Updates** policy setting is **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Windows checks for available updates at the default interval of 22 hours.|
|**Enabled**|Specifies that Windows checks for available updates at the specified interval.|
|**Disabled**|Specifies that Windows checks for available updates at the default interval of 22 hours.|

**Options:** If this setting is enabled, you can specify the time interval in hours that Windows Update waits before checking for updates.

#### Configure Automatic Updates

You can use this policy setting to specify whether automatic updates are enabled on this computer.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

You can configure automatic updates under **Computer Configuration\Administrative Templates\Windows Components\Windows Update\Manage end user experience\Configure Automatic Updates**.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the use of automatic updates isn't specified at the Group Policy level. An administrator can still configure automatic updates through the Settings app, under **Settings** > **Update & security** > **Windows Update** > **Advanced options**.|
|**Enabled**|Specifies that Windows recognizes when the computer is online and uses its internet connection to search Windows Update for available updates. To use this setting, you must select one of the five options that are listed after this table. Local administrators are allowed to use the Windows Update control panel to select a configuration option of their choice. However, local administrators aren't allowed to set the automatic updates configuration to **Disabled**.|
|**Disabled**|Specifies that users must manually download and install any available client updates from the public Windows Update service by going to **Settings** > **Update & security** > **Windows Update**.|

**Options:** If this setting is enabled, you must select one of the following options:

|Option|Behavior|
|-|-|
|**2 - Notify for download and auto install**|When Windows Update finds updates that apply to the computer, users are notified that updates are ready for download. Users can then run Windows Update to download and install any available updates.|
|**3 - Auto download and notify for install**|This option is the default setting. Windows Update finds applicable updates and downloads them in the background. Users aren't notified or interrupted during this process. When the downloads are complete, users are notified that updates are ready to install. Users can then run Windows Update to install the downloaded updates.|
|**4 - Auto download and schedule the install**|You can specify the install schedule by using this Group Policy option. If no schedule is specified, the default schedule for all installations is every day at 3:00 AM. If any updates require a restart to complete the installation, Windows restarts the computer automatically. If a user is signed in to the computer when Windows is ready to restart, the user is notified and given the option to delay the restart.<p>Starting with Windows 8, you can set updates to install during automatic maintenance instead of using a specific Windows Update schedule. Automatic maintenance installs updates when the computer isn't in use, and avoids installing updates when the computer is running on battery power. If automatic maintenance can't install updates within two days, Windows Update installs the updates right away. Users are then notified about a pending restart. A restart happens only if there's no potential for accidental data loss.|
|**5 - Allow local admin to choose setting**|This option specifies whether local administrators are allowed to use the automatic updates control panel to choose configuration options. For example, it specifies whether a local administrator can choose a scheduled installation time. Local administrators aren't allowed to set the configuration for automatic updates to **Disabled**. |
|**7 - Auto Download, Notify to install, Notify to Restart**|*This option is available only in Windows Server SKU, versions 2016 and later.* With this option, local administrators can use Windows Update to proceed with installations or restarts manually. Windows downloads applicable updates to the device, and notifies users that updates are ready to be installed. After updates are installed, users are notified to restart the device.|

> [!NOTE]
> On Windows Server, the **Configure Automatic Updates** policy setting option is configured to **3** in the registry by default. This value isn't reflected in the GPO editor. If an admin configures the option to a different setting, the new setting takes effect. Setting the **Configure Automatic Updates** policy setting to **Not Configured** results in the behavior of automatically downloading and installing updates.

#### Delay Restart for scheduled installations

You can use this policy setting to specify the amount of time automatic updates wait before proceeding with a scheduled restart.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This policy applies only when automatic updates are configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that after updates are installed, the default wait time of 15 minutes elapses before any scheduled restart occurs.|
|**Enabled**|Specifies that when the installation is finished, a scheduled restart occurs after the specified number of minutes has expired.|
|**Disabled**|Specifies that after updates are installed, the default wait time of 15 minutes elapses before any scheduled restart occurs.|

**Options:** If this setting is enabled, you can specify the amount of time in minutes that automatic updates wait before proceeding with a scheduled restart.

#### Do not adjust default option to 'Install Updates and Shut Down' in Shut Down Windows dialog box

You can use this policy setting to specify whether the **Install Updates and Shut Down** option is permitted as the default choice in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This policy setting has no effect if the **\<policy-name\>** > **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Update** > **Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box** policy setting is **Enabled**.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that **Install Updates and Shut Down** is the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|Specifies that the user's last shutdown choice, for example **Hibernate** or **Restart**, is the default option in the **Shut Down Windows** dialog, regardless of whether the **Install Updates and Shut Down** option is available on the **What do you want the computer to do?** menu.|
|**Disabled**|Specifies that **Install Updates and Shut Down** is the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Do not connect to any Windows Update Internet locations

You can use this policy setting to specify that Windows should no longer connect to public update services. Even when Windows Update is configured to receive updates from an intranet update service, it periodically retrieves information from the public Windows Update service. This information enables future connections to Windows Update and other services, such as Microsoft Update or Microsoft Store.

> [!NOTE]
> This policy applies only when the computer is configured to connect to an intranet update service by using the **Specify intranet Microsoft update service location** policy setting.

|Supported on|Excluding|
|---------|-------|
|Starting with  Windows Server 2012 R2, Windows 8.1, or Windows RT 8.1, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that computers can retrieve information from public update services such as Windows Update and Microsoft Store.|
|**Enabled**|Specifies that Windows no longer connects to public update services such as Windows Update or Microsoft Store. This setting causes most functionality of the Microsoft Store app to stop working.<p>Users who search for updates by using the Settings app or Control Panel see updates only from the intranet update service. They aren't presented with the **Check online for updates from Windows Update** option.<p>Programs that use the Windows Update Agent APIs are unable to search for updates from any service other than the intranet update service.|
|**Disabled**|Specifies that computers can retrieve information from public update services.|

**Options:** There are no options for this setting.

#### Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box

You can use this policy setting to specify whether the **Install Updates and Shut Down** option is displayed in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the **Install Updates and Shut Down** option is available in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that **Install Updates and Shut Down** doesn't appear as a choice in the **Shut Down Windows** dialog, even if updates are available for installation when the user selects the **Shut Down** option to shut down the computer.|
|**Disabled**|Specifies that the **Install Updates and Shut Down** option is the default option in the **Shut Down Windows** dialog if updates are available for installation when the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Enable client-side targeting

You can use this policy setting to specify the target group name or names that are configured in the WSUS console that receives updates from WSUS.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
> This policy applies only when this computer is configured to support the specified target group names in WSUS. If the target group name doesn't exist in WSUS, it's ignored until it's created. If the **Specify intranet Microsoft update service location** policy setting is disabled or not configured, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that no target group information is sent to WSUS. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that the specified target group information is sent to WSUS, which uses it to determine which updates should be deployed to this computer. If WSUS supports multiple target groups, you can use this policy to specify multiple group names, separated by semicolons, if you add the target group names in the computer group list in WSUS. Otherwise, a single group must be specified.|
|**Disabled**|Specifies that no target group information is sent to WSUS.|

**Options:** Use this space to specify one or more target group names.

#### Enabling Windows Update Power Management to automatically wake up the computer to install scheduled updates

You can use this policy setting to specify whether Windows Update uses the Windows Power Management or Power Options features to automatically wake up the computer from hibernation if updates are scheduled for installation.

The computer automatically wakes only if Windows Update is configured to install updates automatically. If the computer's in hibernation when the scheduled installation time occurs and there are updates to be applied, Windows Update uses the Windows Power Management or Power Options features to automatically wake the computer to install the updates. Windows Update also wakes the computer and installs an update if an installation deadline occurs.

The computer doesn't wake unless there are updates to be installed. If the computer is on battery power, when Windows Update wakes it, it doesn't install updates. The computer automatically returns to hibernation in two minutes.

|Supported on|Excluding|
|---------|-------|
|Starting with Windows Vista and Windows Server 2008, including Windows 7, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Windows Update doesn't wake the computer from hibernation to install updates. A local administrator can change this setting by using a local policy.|
|**Enabled**|Windows Update wakes the computer from hibernation to install updates under the previously listed conditions.|
|**Disabled**|Windows Update doesn't wake the computer from hibernation to install updates.|

**Options:** There are no options for this setting.

#### No auto-restart with logged on users for scheduled automatic updates installations

You can use this policy setting to specify that to complete a scheduled installation, automatic updates wait for the computer to be restarted by any user who's signed in, instead of causing the computer to restart automatically.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This policy applies only when automatic updates are configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that automatic updates notify the user about the computer automatically restarting in five minutes to complete the installation.|
|**Enabled**|Specifies that automatic updates don't restart a computer automatically during a scheduled installation if a user is signed in to the computer. Instead, if the updates can't take effect until the computer is restarted, automatic updates notify the user to restart the computer.|
|**Disabled**|Specifies that automatic updates notify the user about the computer automatically restarting in five minutes to complete the installation.|

**Options:** There are no options for this setting.

#### Re-prompt for restart with scheduled installations

You can use this policy setting to specify the amount of time for automatic updates to wait before prompting again with a scheduled restart.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!IMPORTANT]
> This policy applies only when automatic updates are configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|A scheduled restart occurs 10 minutes after the prompt-for-restart message is dismissed. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that after a prompt for restart is postponed, a scheduled restart occurs after the specified number of minutes elapses.|
|**Disabled**|A scheduled restart occurs 10 minutes after the prompt-for-restart message is dismissed.|

**Options:** When this setting is enabled, you can specify the amount of time in minutes that elapses before users are prompted again about a scheduled restart.

#### Reschedule Automatic Updates scheduled installations

You can use this policy setting to specify the amount of time for automatic updates to wait after a computer startup before proceeding with a scheduled installation that was previously missed.

If the status is set to **Not Configured**, a missed scheduled installation occurs one minute after the computer is next started.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This policy applies only when automatic updates are configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that a missed scheduled installation occurs one minute after the computer is next started.|
|**Enabled**|Specifies that a missed scheduled installation occurs the specified number of minutes after the computer is next started.|
|**Disabled**|Specifies that a missed scheduled installation occurs with the next scheduled installation.|

**Options:** When this policy setting is enabled, you can specify a number of minutes after the computer is next started that a missed scheduled installation occurs.

#### Specify intranet Microsoft update service location

You can use this policy setting to specify an intranet server to host updates from Microsoft Update. When you specify a server, you can use WSUS to automatically update computers on your network.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

You can use this setting to specify a WSUS server on your network that functions as an internal update service. Instead of using the public Windows Update and Microsoft Update services on the internet, WSUS clients search this service for updates that apply. Enabling this setting means that users in your organization don't have to go through a firewall to get updates. It also gives you the opportunity to test updates before deploying them.

To use this setting, you must set two server name values: the server from which the client detects and downloads updates, and the server to which updated workstations upload statistics. The values don't need to be different if both services are configured on the same server.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that clients connect directly to the Windows Update site on the internet.|
|**Enabled**|Specifies that the client connects to the specified WSUS server, instead of Windows Update, to search for and download updates. If automatic updates aren't disabled by policy or user preference, automatic updates search for, download, and install updates from the specified WSUS server, instead of from Windows Update.<p>Users of the **Windows Update Settings** page, or the **Windows Update** Control Panel page on older versions of Windows, normally see updates from the specified WSUS server, instead of from Windows Update. Users also see a **Check online for updates from Windows Update** option that provides a way for them to use the public update services on the internet. You can remove this option by using the **Do not connect to any Windows Update Internet locations** policy setting.<p>Applications that use the Windows Update Agent APIs to search for, download, and install updates normally operate against the specified WSUS server. Applications can specifically request to use the public update services on the internet. You can remove this option by using the **Do not connect to any Windows Update Internet locations** policy setting. |
|**Disabled**|Specifies that clients connect directly to the Windows Update site on the internet.|

**Options:** When this policy setting is enabled, you must specify the intranet update service that WSUS clients use when detecting updates, and the internet statistics server to which updated WSUS clients upload statistics. The following table provides example values:

|                    Setting option                    |    Example value    |
|-------------------------------------------------------|----------------------|
| Set the intranet update service for detecting updates |  `http://wsus01:8530`  |
|          Set the intranet statistics server           | `http://IntranetUpd01` |

#### Turn on recommended updates via Automatic Updates

You can use this policy setting to specify whether automatic updates deliver important and recommended updates from WSUS.

|Supported on|Excluding|
|---------|-------|
|Starting with Windows Vista, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that automatic updates continue to deliver important updates if they're already configured to do so.|
|**Enabled**|Specifies that automatic updates install recommended updates and important updates from WSUS.|
|**Disabled**|Specifies that automatic updates continue to deliver important updates if they're already configured to do so.|

**Options:** There are no options for this setting.

#### Turn on Software Notifications

You can use this policy setting to specify whether users see detailed enhanced notification messages about featured software from the Microsoft Update service. Enhanced notification messages convey the value and promote the installation and use of optional software. This policy setting is intended for loosely managed environments in which you allow the user access to the Microsoft Update service.

If you're not using the Microsoft Update service, the **Software Notifications** policy setting has no effect.

If the **Configure Automatic Updates** policy setting is **Disabled** or **Not Configured**, the **Software Notifications** policy setting has no effect.

|Supported on|Excluding|
|---------|-------|
|Starting with  Windows Server 2008, Windows Vista, and Windows 7, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> By default, this policy setting is disabled.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Users on computers that are running Windows 7 aren't offered messages for optional applications. Users on computers that are running Windows Vista aren't offered messages for optional applications or updates. A local administrator can change this setting by using Control Panel or a local policy.|
|**Enabled**|A notification message appears on the user's computer when featured software is available. The user can select the notification to open Windows Update and get more information about the software or install it. The user can also select **Close this message** or **Show me later** to defer the notification as appropriate.<p>In Windows 7, this policy setting controls only detailed notifications for optional applications. In Windows Vista, this policy setting controls detailed notifications for optional applications and updates.|
|**Disabled**|Specifies that users running Windows 7 aren't offered detailed notification messages for optional applications. Also specifies that users running Windows Vista aren't offered detailed notification messages for optional applications or optional updates.|

**Options:** There are no options for this setting.

### Computer Configuration > Maintenance Scheduler settings

In the **Configure Automatic Updates** setting, if you select the **4 - Auto download and schedule the install** option, you can specify Maintenance Scheduler settings in the Group Policy Management Console (GPMC) for computers running Windows 8 and Windows RT. If you don't select option **4** in the **Configure Automatic Updates** setting, you don't need to configure these settings for the purpose of automatic updates.

Maintenance Scheduler settings are located in the path **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Maintenance Scheduler**. The Maintenance Scheduler extension of Group Policy contains the following settings:

- [Automatic Maintenance Activation Boundary](#automatic-maintenance-activation-boundary)
- [Automatic Maintenance Random Delay](#automatic-maintenance-random-delay)
- [Automatic WakeUp Policy](#automatic-wakeup-policy)

#### Automatic Maintenance Activation Boundary

You can use this policy setting to configure the Automatic Maintenance activation boundary.

The activation boundary is the daily scheduled time at which Automatic Maintenance starts.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This setting is related to option **4** in **Configure Automatic Updates**. If you don't select option 4 in **Configure Automatic Updates**, you don't need to configure this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|The daily scheduled time as specified on client computers in Control Panel > **Action Center** > **Automatic Maintenance** applies.|
|**Enabled**|Any default or modified settings configured on client computers in Control Panel > **Action Center** > **Automatic Maintenance** (or in some client versions, **Maintenance**) are overridden.|
|**Disabled**|The daily scheduled time as specified in Control Panel > **Action Center** > **Automatic Maintenance** applies.|

#### Automatic Maintenance Random Delay

You can use this policy setting to configure the random delay for Automatic Maintenance activation.

The maintenance random delay is the amount of time up to which Automatic Maintenance delays, starting from its activation boundary. This setting is useful for virtual machines where random maintenance might be a performance requirement.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This setting is related to option **4** in **Configure Automatic Updates**. If you don't select option **4** in **Configure Automatic Updates**, you don't need to configure this setting.

By default, when this setting is enabled, the regular maintenance random delay is **PT4H**.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|A four-hour random delay is applied to **Automatic**.|
|**Enabled**|A random delay that lasts up to the specified amount of time is applied to Automatic Maintenance.|
|**Disabled**|No random delay is applied to Automatic Maintenance.|

#### Automatic WakeUp Policy

You can use this policy setting to configure the wake-up policy for Automatic Maintenance.

The wake-up policy specifies whether Automatic Maintenance makes a wake-up request to the operating computer for daily scheduled maintenance.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> If the operating computer's power-wake policy is explicitly disabled, this setting has no effect. This setting is related to option **4** in **Configure Automatic Updates**. If you don't select option **4** in **Configure Automatic Updates**, you don't need to configure this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|The wake-up setting as specified in Control Panel > **Action Center** > **Automatic Maintenance** applies.|
|**Enabled**|Automatic Maintenance attempts to set an operating system wake-up policy and make a wake-up request for the daily scheduled time, if required.|
|**Disabled**|The wake-up setting as specified in Control Panel > **Action Center** > **Automatic Maintenance** applies.|

### User Configuration > Windows Update policy settings

This section provides details about the following user-based policy settings:

- [Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box](#do-not-display-install-updates-and-shut-down-option-in-shut-down-windows-dialog-box)
- [Do not adjust default option to 'Install Updates and Shut Down' in Shut Down Windows dialog box](#do-not-adjust-default-option-to-install-updates-and-shut-down-in-shut-down-windows-dialog-box)
- [Remove access to use all Windows Update features](#remove-access-to-use-all-windows-update-features)

In the GPME, the user settings for automatic computer updates are located in the path **\<policy-name\>** > **User Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Update**. The settings are listed in the same order as they appear in the Computer Configuration and User Configuration extensions in Group Policy, when the **Settings** tab of the Windows Update policy is selected to sort the settings alphabetically.

> [!NOTE]
> By default, unless otherwise noted, these settings aren't configured.

For each of these settings, you can use the following steps to enable, disable, or move between settings.

#### Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box

You can use this policy setting to specify whether the **Install Updates and Shut Down** option is displayed in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the **Install Updates and Shut Down** option appears in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|Specifies that **Install Updates and Shut Down** doesn't appear as a choice in the **Shut Down Windows** dialog, even if updates are available for installation when the user selects the **Shut Down** option to shut down the computer.|
|**Disabled**|Specifies that the **Install Updates and Shut Down** option appears in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Do not adjust default option to 'Install Updates and Shut Down' in Shut Down Windows dialog box

You can use this policy setting to specify whether the **Install Updates and Shut Down** option is allowed as the default choice in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

> [!NOTE]
> This policy setting has no effect if the **\<policy-name\>** > **User Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update** > **Do not display Install Updates and Shut Down option in Shut Down Windows** dialog is enabled.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies whether the **Install Updates and Shut Down** option is the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|Specifies whether the user's last shutdown choice (for example, **Hibernate** or **Restart**) is the default option in the **Shut Down Windows** dialog, regardless of whether the **Install Updates and Shut Down** option is available on the **What do you want the computer to do?** menu.|
|**Disabled**|Specifies whether the **Install Updates and Shut Down** option is the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Remove access to use all Windows Update features

You can use this setting to remove WSUS client access to Windows Update.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|None|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Users can connect to the Windows Update website.|
|**Enabled**|All Windows Update features are removed. Access is blocked to the Windows Update website `http://windowsupdate.microsoft.com` from the Windows Update hyperlink on the **Start** menu or startup screen, and on the **Tools** menu in Internet Explorer. <p>Windows automatic updates are also disabled. The user isn't notified about critical updates and doesn't receive critical updates from Windows Update. This setting also prevents Device Manager from automatically installing driver updates from the Windows Update website. You can configure one of the notification options listed after this table.|
|**Disabled**|Users can connect to the Windows Update website.|

**Options:** If this setting is enabled, select one of the following options:

| Option | Behavior |
| --- | --- |
| **0 - Do not show any notifications** | All access to Windows Update features is removed, and no notifications are shown. |
| **1 - Show restart required notifications** | Notifications about restarts that are required to complete an installation are shown. On computers running Windows 8 and Windows RT, only notifications related to restarts and the inability to detect updates are shown. The notification options aren't supported. Notifications on the sign-in screen are always displayed. |

## Supplemental information

This section provides more information about using, opening, and saving WSUS settings in Group Policy. This section also supplies definitions for terms used in this article. For administrators who are familiar with past versions of WSUS (WSUS 3.2 and previous versions), a table summarizes differences between WSUS versions.

### Access the Windows Update settings in Group Policy

The following procedures describe how to work with Group Policy objects (GPOs) and other Group Policy settings.

> [!NOTE]
> To perform these procedures, you must be a member of the **Domain Admins** group or its equivalent.

#### To open a Group Policy object

1. On your domain controller, go to **Server Manager** > **Tools** > **Group Policy Management**. The GPMC opens.

1. On the side pane, expand your forest. For example, double-click **forest: example.com**.

1. On the side pane, double-click **Domains**, and then double-click the domain for which you want to manage a Group Policy object. For example, double-click **example.com**.

1. Take one of the following steps:

   - To open an existing domain-level GPO for editing:
     1. Double-click the domain that contains the Group Policy object that you want to manage.
     1. Right-click the domain policy that you want to manage, and then select **edit**. The GPME opens.

   - To create a new Group Policy object and open it for editing:
     1. Right-click the domain for which you want to create a new Group Policy object, and then select **Create a GPO in this domain, and link it here**.
     1. In **New GPO**, in **Name**, enter a name for the new Group Policy object, and then select **OK**.
     1. Right-click your new Group Policy object, and then select **edit**. The GPME opens.

#### To open the Windows Update or Maintenance Scheduler extensions of Group Policy

In the GPME, take one of the following steps:

- Expand **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Update**.

- Expand **User Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Update**.

- Expand **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Maintenance Scheduler**.

For more information about Group Policy, see [Group Policy overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831791(v=ws.11)).

#### To configure Group Policy settings

After you open the extension of Group Policy that you want, you can use the following steps to enable, disable, or move between settings:

1. Double-click the setting that you want to view or modify.

1. Take one of the following steps:

   - To retain the default unspecified state of the setting, select **Not Configured**.
   - To enable the setting, select **Enabled**.
   - To disable the setting, select **Disabled**.

1. In **Options**, if any options are listed, retain the default values or modify them as needed.

1. Take one of the following steps:

   - To save your changes and proceed to the next setting, select **Apply**, and then select **Next Setting**.
   - To save your changes and close the dialog, select **OK**.
   - To discard all unsaved changes and close the dialog, select **Cancel**.

### Changes to WSUS

The following table summarizes key differences between the current and past versions of WSUS that are relevant to this article.

|Windows Server and WSUS versions|Description|
|------------------|--------|
| Windows Server 2012 R2 with WSUS 6.0, and subsequent versions|Starting in Windows Server 2012, the WSUS server role is integrated with the operating system. The associated Group Policy settings for WSUS clients are, by default, included in Group Policy.|
| Windows Server 2008 and earlier versions of Windows Server with WSUS 3.2 and earlier|In Windows Server 2008 and earlier versions of Windows Server using WSUS versions 3.2 and earlier, the Group Policy settings that govern WSUS clients aren't included in the operating system. The policy settings are in the WSUS administrative template *wuau.adm*. In these server versions, the WSUS administrative template must be added into the GPMC before the WSUS client settings can be configured.|

### Terms and definitions

This article uses the following terms:

|Term|Definition|
|----|-------|
|automatic updates or Automatic Updates|The client computer component that manages the Windows Update Agent, which automatically schedules and downloads updates. Automatic Updates is built into the Microsoft Windows Vista, Windows Server 2003, Windows XP, and Windows 2000 with SP3 operating systems to get updates from Microsoft Update or Windows Update.|
|autonomous server|A downstream WSUS server on which administrators can manage WSUS components.|
|downstream server|A WSUS server that gets updates from another WSUS server rather than from Microsoft Update or Windows Update.|
|Group Policy extension or extension of Group Policy|A collection of settings in Group Policy that control how users and computers to whom the policies apply can configure and use various Windows services and features. Administrators can use WSUS with Group Policy for client-side configuration of the Automatic Updates client, to help ensure that users can't disable or circumvent corporate update policies.<p>WSUS doesn't require the use of Active Directory or Group Policy. Client configuration can also be applied by using a local group policy or by modifying the Windows registry.|
|internal update service|A casual reference to a network infrastructure that uses one or more WSUS servers to distribute updates.|
|replica server|A downstream WSUS server that mirrors the approvals and settings on the upstream server to which it's connected. You can't manage WSUS on a replica server.|
|Microsoft Update|A Microsoft internet site that stores and distributes updates for Windows computers, device drivers, Windows operating systems, and other Microsoft software products.|
|Software Update Services (SUS)|The predecessor product for WSUS.|
|updates|Any of a collection of software revisions, hot fixes, service packs, feature packs, and device drivers that can be installed on a computer to extend functionality, or to improve performance and security.|
|update files|The files required to install an update on a computer.|
|update information or update metadata|The information about an update, as opposed to the binary files in an update package. For example, metadata supplies information about the properties of an update so you can find out what the update is useful for. Metadata also includes Microsoft Software License Terms. The metadata package downloaded for an update is typically much smaller than the update file package.|
|update source|The location to which a WSUS server synchronizes to get update files. This location can be either Microsoft Update or an upstream WSUS server.|
|upstream server|A WSUS server that provides update files to another, downstream WSUS server.|
|Windows Server Update Services (WSUS)|A server role program that runs on one or more Windows Server computers on a corporate network. A WSUS infrastructure enables you to manage updates for computers on your network to install.<p>You can use WSUS to approve or decline updates before release, to force updates to install by a certain date, and to obtain extensive reports on what updates each computer on your network requires. You can configure WSUS to approve certain classes of updates automatically, including critical updates, security updates, service packs, and drivers. You can also use WSUS to approve updates for detection only, so that you can see what computers require a particular update without having to install the update.<p>In a WSUS implementation, at least one WSUS server in the network must be able to connect to Microsoft Update to get available updates. Based on network security and configuration, the administrator can determine how many other servers connect directly to Microsoft Update.<p>You can configure a WSUS server to get updates over the internet from Microsoft Update, Windows Update, or Microsoft Store.|
|Windows Update|A Microsoft internet site that stores and distributes updates for Windows computers, device drivers, and Windows operating systems. Windows Update is also the name of a service that runs on Windows computers and detects, downloads, and installs updates.<p>Depending on computer and policy configurations, the Windows Update Agent can download updates from:<p>- Microsoft Update<br />- Windows Update<br />- Microsoft Store<br />- An internet (network) update service (WSUS)<p>Computers that aren't managed in a WSUS-based environment typically use Windows Update to connect directly over the internet to Windows Update, Microsoft Update, or Microsoft Store to obtain updates.|
|WSUS client|A computer that receives updates from a WSUS intranet update service. In the case of Group Policy settings that control user interaction with Automatic Updates, a WSUS client is a user of a computer in a WSUS environment.|

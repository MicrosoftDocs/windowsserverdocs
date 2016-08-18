---
title: Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8136e3ce-9db4-412d-8680-b73051587e8c
---
# Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy
This troubleshooting topic explains the interaction between the required synchronous processing for certain Group Policy client-side extensions (CSEs) and Fast Logon Optimization, which was introduced in Windows XP. Fast Logon Optimization may cause you to sign in or restart the computer multiple times before certain Group Policy settings are applied to the client computer. This topic also discusses the effect that the fast startup feature introduced in Windows 8 has on Group Policy settings that are applied during startup or shutdown.

## Prerequisites
This topic applies to computers that are running Windows 8.1, Windows 8, Windows 7, Windows Vista, or Windows XP.

## Group Policy settings and CSEs
Policy settings are grouped into categories, such as Administrative Templates, Security Settings, Folder Redirection, Disk Quota, Software Installation, and the Group Policy preference extensions. The settings in each category require a specific CSE to process them, and each CSE has its own rules for processing settings. For this discussion, it’s important to understand that Group Policy preference extensions represent a set of client-side extensions, not a single CSE. Each Group Policy preference extension has rules to process settings.

## <a name="bkmk_SyncAsync"></a>Asynchronous and synchronous processing
Asynchronous processing refers to processes that do not depend on the outcome of other processes. Therefore, they can occur on different threads simultaneously.

Synchronous processing refers to processes that depend on each other’s outcome. Therefore, synchronous processes must wait for the previous process to finish before the next process can start.

Asynchronous processing affects Group Policy in the following ways:

-   **At startup** The client computer does not wait for the network to be fully initialized before sign-in is available to the user. Group Policy for the client computer processes when the network becomes available in parallel to startup and sign-in activities.

-   **At sign-in** A user does not have to wait for Group Policy to finish processing before signing in.

For CSEs such as Folder Redirection, Software Installation, and Drive Maps preference extension, the outcome of Group Policy processing might adversely affect the user’s experience, for example, a program being uninstalled while the user is working with it. To keep this from happening, the CSE is designed to require synchronous processing to apply the new settings. During asynchronous processing, the CSE signals the system to indicate that a synchronous application of Group Policy is required. A synchronous application of Group Policy occurs at the next startup (if it is signaled during the computer Group Policy refresh) or at the user’s next sign-in (if it is signaled during the user Group Policy refresh).

## Foreground and background processing
Group Policy foreground processing applies when the computer starts or shuts down and when the user signs in or signs out. During foreground processing, policy settings can be applied asynchronously or synchronously.

Group Policy background processing applies during periodic refreshes after the computer has started or a user has signed in. All requested Group Policy refreshes that are performed by using **GPUpdate.exe** also run as background processing. During background processing, policy settings are only applied asynchronously.

## <a name="BKMK_REQ"></a>CSE processing requirements
When Group Policy processes on a Windows-based computer, client-side extensions interpret the stored policy settings and make the appropriate changes to the environment. When troubleshooting a given client-side extension’s application of Group Policy, the administrator can view the configuration parameters that affect that extension’s operation. These parameters are in the form of registry values.

> [!IMPORTANT]
> This section provides an overview about the information that is stored in the registry. This is for informational purposes, and it is not recommended that you adjust the CSE processing properties by using the registry. Serious problems might occur if you modify the registry incorrectly. If you do make any changes to the registry, it is recommended that you back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [article 322756](http://support.microsoft.com/kb/322756) in the Microsoft Knowledge Base.

Each client-side extension is identified by a subkey under the following path:

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions

The subkey name takes the form of a Globally Unique Identifier (GUID). For more information about identifying registered Group Policy client-side extensions, see [article 216357](http://support.microsoft.com/kb/216357/EN-US) in the Microsoft Knowledge Base.

The **NoBackgroundPolicy** registry key determines if a CSE is called during Group Policy background policy processing. If this value is set to 1, the CSE will not be called during background processing. A CSE that requires synchronous processing can still be called during background processing. However, because background processing is always performed in asynchronous mode, a CSE that requires synchronous processing exits after signaling a request for the next sign-in  to be run in synchronous mode.

Each CSE determines if it requires synchronous processing to apply changes to the policy settings.

The following table provides information about the synchronous processing requirements and the default background processing behavior of CSEs in Group Policy.

|CSE name|Requires synchronous processing|Called during background processing|
|------------|-----------------------------------|---------------------------------------|
|Disk Quota|No|Yes|
|EFS Recovery|No|Yes|
|Folder Redirection|Yes|Yes|
|Internet Explorer Maintenance|No|Yes|
|IP security|No|Yes|
|Registry|No|Yes|
|Scripts|-   Startup scripts run synchronously by default.<br />-   Sign-in scripts run asynchronously by default.|Yes, but scripts are run only in foreground processing.|
|Security|No|Yes|
|Software Installation|Yes|Yes|
|Wired Networking|No|Yes|
|Wireless Networking|No|Yes|
|Applications preference extension|No|Yes|
|Data Sources preference extension|No|Yes|
|Devices preference extension|No|Yes|
|Drive Maps preference extension|Yes|No|
|Environment preference extension|No|Yes|
|Files preference extension|No|Yes|
|Folder Options preference extension|No|Yes|
|Folders preference extension|No|Yes|
|Ini Files preference extension|No|Yes|
|Internet Settings preference extension|No|Yes|
|Local Users and Groups preference extension|No|Yes|
|Network Options preference extension|No|Yes|
|Network Shares preference extension|No|Yes|
|Power Options preference extension|No|Yes|
|Printers preference extension|No|Yes|
|Regional Options preference extension|No|Yes|
|Registry preference extension|No|Yes|
|Scheduled Tasks preference extension|No|Yes|
|Services preference extension|No|Yes|
|Shortcuts preference extension|No|Yes|
|Start Menu preference extension|No|Yes|

Although the requirement to run a client-side extension in synchronous mode is not configurable, other default behavior for each CSE can be configured through policy settings. To configure the properties that are associated with a CSE, apply the Administrative Templates computer configuration policy settings that are created for this purpose. The following table provides the names of the policy settings and the CSE properties that can be modified. If the CSE property includes an X, it can be modified for the specific CSE.

|Policy Setting Name|Allows processing across a slow network connection|Do not apply during periodic background processing|Process even if the Group Policy Objects have not changed|Allows background processing priority|
|-----------------------|------------------------------------------------------|------------------------------------------------------|-------------------------------------------------------------|-----------------------------------------|
|Configure disk quota policy processing|X|X|X||
|Configure EFS recovery policy processing|X|X|X||
|Configure Folder Redirection policy processing|X||X||
|Configure Internet Explorer Maintenance policy processing|X|X|X||
|Configure IP security policy processing|X|X|X||
|Configure Registry policy processing||X|X||
|Configure Scripts policy processing|X|X|X||
|Configure Security policy processing||X|X||
|Configure Software Installation policy processing|X||X||
|Configure Wired Networking policy processing|X|X|X||
|Configure Wireless Networking policy processing|X|X|X||
|Configure Applications preference extension policy processing|X|X|X|X|
|Configure Data Sources preference extension policy processing|X|X|X|X|
|Configure Devices preference extension policy processing|X|X|X|X|
|Configure Drive Maps preference extension policy processing|X||X|X|
|Configure Environment preference extension policy processing|X|X|X|X|
|Configure Files preference extension policy processing|X|X|X|X|
|Configure Folder Options preference extension policy processing|X|X|X|X|
|Configure Folders preference extension policy processing|X|X|X|X|
|Configure Ini Files preference extension policy processing|X|X|X|X|
|Configure Internet Settings preference extension policy processing|X|X|X|X|
|Configure Local Users and Groups preference extension policy processing|X|X|X|X|
|Configure Network Options preference extension policy processing|X|X|X|X|
|Configure Network Shares preference extension policy processing|X|X|X|X|
|Configure Power Options preference extension policy processing|X|X|X|X|
|Configure Printers preference extension policy processing|X|X|X|X|
|Configure Regional Options preference extension policy processing|X|X|X|X|
|Configure Registry preference extension policy processing|X|X|X|X|
|Configure Scheduled Tasks preference extension policy processing|X|X|X|X|
|Configure Services preference extension policy processing|X|X|X|X|
|Configure Shortcuts preference extension policy processing|X|X|X|X|
|Configure Start Menu preference extension policy processing|X|X|X|X|

## Fast Logon Optimization and Group Policy processing
By default in Windows 8.1,  Windows 8, Windows 7, Windows Vista, and Windows XP, the Fast Logon Optimization feature is set for domain and workgroup members. Policy settings apply asynchronously when the computer starts and when the user signs in. As a result, these operating systems do not wait for the network to be fully initialized at startup and sign-in. Existing users are signed in by using cached credentials. This results in shorter sign-in times. Group Policy is applied after the network becomes available.

Fast Logon Optimization is always off during sign-in when a user:

-   First signs in to a computer.

-   Has a roaming user profile or a home directory for sign-in purposes.

-   Has synchronous sign-in scripts.

> [!NOTE]
> Under the preceding conditions, computer startup can still be asynchronous. However, because sign-in is synchronous under these conditions, sign-in does not exhibit optimization.

## How Fast Logon Optimization affects CSE processing
With Fast Logon Optimization, enabled Group Policy foreground processing runs asynchronously. When a CSE requires synchronous processing:

-   Policy settings do not apply during the asynchronous processing cycle.

-   The CSE that requires synchronous policy application can still be called during asynchronous policy application. Instead of applying policy settings, the CSE signals for synchronous processing to be applied at the next startup or sign-in.

### <a name="BKMK_ReqSynch"></a>Fast Logon Optimization and required synchronous policy application
When synchronous policy application is required and Fast Logon Optimization is enabled, it can take up to two reboots or two sign-ins for the policy settings to apply. This is demonstrated in the following examples.

-   In example 1, a user is not signed in to the client computer when a change is made to user policy settings, and synchronous processing is not requested. In this case, the policy settings are applied after two sign-ins.

-   In example 2 a user is signed in to the client computer when a change is made to user policy settings, and the user stays signed in to the computer so that background processing takes place prior to sign-out. In this case, the policy settings are applied after one sign-in.

> [!NOTE]
> These examples assume that only policy settings for a single CSE that requires synchronous processing have changed.
> 
> When you troubleshoot Group Policy, consider that there may be interactions with multiple CSEs. You may find that the expected behavior for a single CSE varies when combined with the processing requirements of other CSEs. For more specific examples, see the Group Policy topics in [Wiki: Group Policy Troubleshooting Portal](http://social.technet.microsoft.com/wiki/contents/articles/2200.wiki-troubleshooting-portal.aspx#Group_Policy).

**Example 1: Fast Logon Optimization with synchronous processing when the user is not signed in**

In this example, the user is not signed in to the computer when there is a change to the user policy setting for a CSE that requires synchronous processing. Synchronous processing was not requested when the user policy setting was last processed. In this example, it takes two sign-ins for the CSE to apply the policy settings.

When the user signs in, Fast Logon Optimization is in effect and Group Policy processes asynchronously. The Group Policy engine determines that there is a change to the policy settings for the CSE, and the Group Policy engine calls that CSE.

The CSE determines that it requires synchronous processing to apply the new settings. With the current processing session in asynchronous mode, the CSE exits without applying the policy settings, and the CSE signals to the Group Policy engine that synchronous processing is needed for the next sign-in.

At the second sign-in, Group Policy processes synchronously. The Group Policy engine determines that the CSE did not completely process the policy settings during the last sign-in session. The Group Policy engine calls the CSE. The CSE determines that Group Policy is processing synchronously, and the CSE applies the policy settings.

**Example 2: Fast Logon Optimization with synchronous processing when the user is signed in**

In this example, the user is already signed in to the computer when there is a change to the user policy setting for a CSE that requires synchronous processing. The user stays signed in to the computer until Group Policy background processing occurs, and the CSE applies the policy settings after a single sign-in.

When the user stays signed in to a client computer, by default, background processing occurs approximately every ninety minutes. Background processing is always run asynchronously. During this background processing, the Group Policy engine determines that there is a change to the policy settings for a CSE. The Group Policy engine calls that CSE.

The CSE determines that it requires synchronous processing to apply the new settings. With the background processing session in asynchronous mode, the CSE exits without applying the policy settings. The CSE signals to the Group Policy engine that synchronous processing is needed for the next sign-in. During subsequent background refreshes, the CSE is called, but it exits without applying the policy settings because it still requires synchronous processing.

At the next sign-in, Group Policy processes synchronously. The Group Policy engine determines that the CSE did not complete processing during the last sign-in session. The Group Policy engine calls the CSE. The CSE determines that Group Policy is processing synchronously, and the CSE applies the policy settings with a single sign-in.

### Fast Logon Optimization, required synchronous processing, and required foreground processing for a CSE
A CSE can require synchronous processing and foreground processing to apply settings. The foreground processing requirement is set when the **NoBackgroundPolicy** registry key is set to a value of 1. In this case, the CSE applies the policy settings with two sign-ins.

For example, the user is signed in to the computer when there is a change to a user policy setting that requires synchronous processing and can only be applied during foreground processing. The user stays signed in to the client computer until Group Policy background processing occurs (by default, approximately every ninety minutes). During background processing, the Group Policy engine determines that there is a change to the policy settings for a CSE, but the **NoBackgroundPolicy** registry key is set to 1, and the Group Policy engine does not call this CSE during background processing. Additionally, during subsequent background refreshes, the Group Policy engine does not call the CSE.

At the next sign-in, Group Policy processes asynchronously because Fast Logon Optimization is in effect. This is foreground processing, so the Group Policy engine calls the CSE, which was set to only process in the foreground.

The CSE determines that it requires synchronous processing to apply the new policy settings. With the current processing session in asynchronous mode, the CSE exits without applying the policy settings. The CSE signals to the Group Policy engine that synchronous processing is needed for the next sign-in.

At the next sign-in, Group Policy processes synchronously. The Group Policy engine determines that the CSE did not completely process the policy settings during the last sign-in session. The Group Policy engine calls the CSE. The CSE determines that Group Policy is processing synchronously and applies the policy settings. In this case, it takes two sign-ins for the CSE to apply the settings.

> [!NOTE]
> This example assumes that only policy settings for a single CSE that requires synchronous processing and foreground processing, have changed.
> 
> When you troubleshoot Group Policy, consider that there may be interactions with multiple CSEs, and you may find that the expected behavior for a single CSE varies when combined with the processing requirements of other CSEs. For more specific examples, see the Group Policy topics in [Wiki: Group Policy Troubleshooting Portal](http://social.technet.microsoft.com/wiki/contents/articles/2200.wiki-troubleshooting-portal.aspx#Group_Policy).

## Fast startup and Group Policy processing
Group Policy settings or scripts that are applied during startup or shutdown might not be applied on computers that are running Windows 8.1 or Windows 8 because, by default, these computers are not fully shut down by the **Shut down** command. Instead, the computer enters a hibernate state. Full shutdown only occurs when the system is set to reboot or when a pending software update or other event causes the computer to process a full shutdown. You can use the **Restart Computer** command in Windows 8.1 and Windows 8 to achieve startup or shutdown on client computers.

If you do not want fast startup to apply to computers in your enterprise, you can apply a GPO that disables the **Computer Configuration/Policies/Administrative Templates/System/Shutdown/Require use of fast startup** policy setting. Be aware that disabling this policy setting results in full shutdowns  and longer startup times for client computers. The enabled state of the **Require use of fast startup** policy setting does not take precedence over any Group Policy setting that disables hibernation.

## Related resources

-   [Troubleshooting Group Policy Client-Side Extension Behavior](http://support.microsoft.com/kb/216358)

-   [Description of the Windows XP Professional Fast Logon Optimization feature](http://support.microsoft.com/kb/305293)



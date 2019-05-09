---
title: Troubleshoot user profiles with events
description: How to troubleshoot problems loading and unloading user profiles by using events and trace logs.
ms.prod: windows-server-threshold 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 04/05/2018
ms.localizationpriority: medium
---
# Troubleshoot user profiles with events

>Applies to: Windows 10, Windows 8, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, and Windows Server (Semi-annual Channel).

This topic discusses how to troubleshoot problems loading and unloading user profiles by using events and trace logs. The following sections describe how to use the three event logs that record user profile information.

## Step 1: Checking events in the Application log

The first step in troubleshooting issues with loading and unloading user profiles (including roaming user profiles) is to use Event Viewer to examine any Warning and Error events that User Profile Service records in the Application log.

Here's how to view User Profile Services events in the Application log:

1. Start Event Viewer. To do so, open **Control Panel**, select **System and Security**, and then, in the **Administrative Tools** section, select **View event logs**. The Event Viewer window opens.
2. In the console tree, first navigate to **Windows Logs**, then **Application**.
3. In the Actions pane, select **Filter Current Log**. The Filter Current Log dialog box opens.
4. In the **Event sources** box, select the **User Profiles Service** checkbox, and then select **OK**.
5. Review the listing of events, paying particular attention to Error events.
6. When you find noteworthy events, select the Event Log Online Help link to display additional information and troubleshooting procedures.
7. To perform further troubleshooting, note the date and time of noteworthy events and then examine the Operational log (as described in Step 2) to view details about what the User Profile Service was doing around the time of the Error or Warning events.

>[!NOTE]
>You can safely ignore User Profile Service event 1530 "Windows detected your registry file is still in use by other applications or services."

## Step 2: View the Operational log for the User Profile Service

If you cannot resolve the issue using the Application log alone, use the following procedure to view User Profile Service events in the Operational log. This log shows some of the inner workings of the service, and can help pinpoint where in the profile load or unload process the problem is occurring.

Both the Windows Application log and the User Profile Service Operational log are enabled by default in all Windows installations.

Here's how to view the Operational log for the User Profile Service:

1. In the Event Viewer console tree, navigate to **Applications and Services Logs**, then **Microsoft**, then **Windows**, then **User Profile Service**, and then **Operational**.
2. Examine the events that occurred around the time of the Error or Warning events that you noted in the Application log.

## Step 3: Enable and view analytic and debug logs

If you require more detail than the Operational log provides, you can enable analytic and debug logs on the affected computer. This level of logging is much more detailed and should be disabled except when trying to troubleshoot an issue.

Here's how to enable and view analytic and debug logs:

1. In the **Actions** pane of Event Viewer, select **View**, and then select **Show Analytic and Debug Logs**.
2. Navigate to **Applications and Services Logs**, then **Microsoft**, then **Windows**, then **User Profile Service**, and then **Diagnostic**.
3. Select **Enable Log** and then select **Yes**. This enables the Diagnostic log, which will start logging.
4. If you require even more detailed information, see [Step 4: Creating and decoding a trace](#step-4-creating-and-decoding-a-trace) for more information about how to create a trace log.
5. When you are finished troubleshooting the issue, navigate to the **Diagnostic** log, select **Disable Log**, select **View** and then clear the **Show Analytic and Debug Logs** checkbox to hide analytic and debug logging.

## Step 4: Creating and decoding a trace

If you cannot resolve the issue using events, you can create a trace log (an ETL file) while reproducing the issue, and then decode it using public symbols from the Microsoft symbol server. Trace logs provide very specific information about what the User Profile Service is doing, and can help pinpoint where the failure occurred.

The best strategy when using ETL tracing is to first capture the smallest log possible. Once the log is decoded, search the log for failures.

Here's how to create and decode a trace for the User Profile Service:

1. Sign on to the computer where the user is experiencing problems, using an account that is a member of the local Administrators group.
2. From an elevated command prompt enter the following commands, where *\<Path\>* is the path to a local folder that you have previously created, for example C:\\logs:
        
    ```PowerShell
    logman create trace -n RUP -o <Path>\RUP.etl -ets
    logman update RUP -p {eb7428f5-ab1f-4322-a4cc-1f1a9b2c5e98} 0x7FFFFFFF 0x7 -ets
    ```
3. From the Start screen, select the user name, and then select **Switch account**, being careful not to log off the administrator. If you are using Remote Desktop, close the Administrator session to establish the user session.
4. Reproduce the problem. The procedure to reproduce the problem is typically to sign on as the user experiencing the issue, sign the user off, or both.
5. After reproducing the problem, sign on as the local administrator again.
6. From an elevated command prompt run the following command to save the log into an ETL file:
  
    ```PowerShell
    logman stop -n RUP -ets
    ```
7. Type the following command to export the ETL file into a human-readable file in the current directory (likely your home folder or the %WINDIR%\\System32 folder):
    
    ```PowerShell
    Tracerpt <path>\RUP.etl
    ```
8. Open the **Summary.txt** file and **Dumpfile.xml** file (you can open them in Microsoft Excel to more easily view the complete details of the log). Look for events that include **fail** or **failed**; you can safely ignore lines that include the **Unknown** event name.

## More information

* [Deploy Roaming User Profiles](deploy-roaming-user-profiles.md)
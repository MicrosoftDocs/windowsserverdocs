---
title: Msdt
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ead1b672-a120-4e16-94aa-a8e13602c1d0
---
# Msdt
Invokes a troubleshooting pack at the command line or as part of an automated script, and enables additional options without user input.

## Syntax

```
msdt </id <name> | /path <name> | /cab < name>> <</parameter> [options] … <parameter> [options]>>
```

## Parameters
The following table includes the parameters and options supported by msdt.exe.

|Parameter|Description|
|-------------|---------------|
|/id <package name>|Specifies which diagnostic package to run. For a list of available packages, see the Troubleshooting Pack ID in the “Available troubleshooting packs” section later in this topic.|
|/path <directory &#124; .diagpkg file &#124; .diagcfg file>|Specifies the full path to a diagnostic package. If you specify a directory, the directory must contain a diagnostic package. You cannot use the /path parameter in conjunction with the */id*, */dci*, or */cab* parameter.|
|/dci <passkey>|Prepopulates the passkey field in msdt. This parameter is only used when a support provider has supplied a passkey.|
|/dt <directory>|Displays the troubleshooting history in the specified directory. Diagnostic results are stored in the user’s **%LOCALAPPDATA%\Diagnostics** or **%LOCALAPPDATA%\ElevatedDiagnostics** directories.|
|/af <answer file>|Specifies an answer file in XML format that contains responses to one or more diagnostic interactions.|
|/modal <ownerHWND>|Makes the troubleshooting pack modal to a window designated by the parent Console Window Handle (HWND), in decimal. This parameter is typically used by applications that launch a troubleshooting pack. For more information about obtaining Console Window Handles, see [How to Obtain a Console Window Handle (HWND)](http://go.microsoft.com/fwlink/?LinkId=160258).|
|/moreoptions <true &#124; false>|Enables (true) or suppresses (false) the final troubleshooting screen that asks if the user wants to explore additional options. This parameter is typically used when the troubleshooting pack is launched by a troubleshooter that is not part of the operating system.|
|/param <parameters>|Specifies a set of interaction responses at the command line, similar to an answer file. This parameter is not typically used within the context of troubleshooting packs created with TSP Designer. For more information about developing custom parameters, see [Windows Troubleshooting Platform](http://go.microsoft.com/fwlink/?LinkId=144215).|
|/advanced|Expands the advanced link on the Welcome page by default when the troubleshooting pack is started.|
|/custom|Prompts the user to confirm each possible resolution before it is applied.|

### Return codes
Troubleshooting packs comprise a set of **root causes**, each of which describes a specific technical problem. After completing the troubleshooting pack tasks, each root cause returns a state of **fixed**, **not fixed**, **detected** (but not fixable), or **not found**. In addition to specific results reported in the troubleshooter user interface, the troubleshooting engine returns a code in the results describing, in general terms, whether or not the troubleshooter fixed the original problem. The return codes are shown in the following table.

|Return Code|Explanation|
|---------------|---------------|
|-1|**Interruption:** The troubleshooter was closed before the troubleshooting tasks were completed.|
|0|**Fixed:** The troubleshooter identified and fixed at least one root cause, and no root causes remain in a **not fixed** state.|
|1|**Present, but not fixed:** The troubleshooter identified one or more root causes that remain in a **not fixed** state. This code is returned even if another root cause was fixed.|
|2|**Not found:** The troubleshooter did not identify any root causes.|

|Troubleshooting Pack ID|Description|Application or Feature Dependency|Windows 8|Windows RT|Windows 7|Windows Server 2008|Windows Server 2012|
|---------------------------|---------------|-------------------------------------|-------------|--------------|-------------|-----------------------|-----------------------|
|AeroDiagnostic|Troubleshoots problems displaying Aero effects such as transparency.|Aero Display Theme installed|Deprecated|Deprecated|Yes|No|No|
|NetworkDiagnosticsDA|Troubleshoots problems connecting to a workplace network over the Internet using DirectAccess.|DirectAccess installed|Yes|Yes|Yes|Yes|Yes|
|DeviceDiagnostic|Troubleshoots problems using hardware and access devices connected to the computer.|None|Yes|Yes|Yes|No|No|
|HomeGroupDiagnostic|Troubleshoots problems viewing computers or shared files in a homegroup.|HomeGroup installed|Yes|Yes|Yes|No|No|
|NetworkDiagnosticsInbound|Troubleshoots problems with allowing other computers to communicate with the target computer through Windows Firewall.|None|Yes|Yes|Yes|Yes|Yes|
|NetworkDiagnosticsWeb|Troubleshoots problems connecting to the Internet or to a specific website.|None|Yes|Yes|Yes|Yes|Yes|
|IEBrowseWebDiagnostic|Helps the user prevent add-on problems and optimize temporary files and connections.|Internet Explorer installed|Yes|Yes|Yes|No|No|
|IESecurityDiagnostic|Helps the user prevent malware, pop-up windows, and online attacks.|Internet Explorer installed|Yes|Yes|Yes|No|No|
|NetworkDiagnosticsNetworkAdapter|Troubleshoots problems with Ethernet, wireless, or other network adapters.|None|Yes|Yes|Yes|No|No|
|PerformanceDiagnostic|Helps the user adjust settings to improve operating system speed and performance.|None|Deprecated|Deprecated|Yes|No|No|
|AudioPlaybackDiagnostic|Troubleshoots problems playing sounds and other audio files.|Audio output device installed|Yes|Yes|Yes|No|No|
|PowerDiagnostic|Helps the user adjust power settings to improve battery life and reduce power consumption.|None|Yes|Yes|Yes|No|No|
|PrinterDiagnostic|Troubleshoots problems printing.|None|Yes|Yes|Yes|No|No|
|PCWDiagnostic|Helps the user configure older programs so that they can run in the current version of Windows.|None|Yes|No|Yes|Yes|Yes|
|AudioRecordingDiagnostic|Troubleshoots problems recording audio from a microphone or other input source.|Audio input device installed|Yes|Yes|Yes|No|No|
|SearchDiagnostic|Troubleshoots problems with search and indexing using Windows Search.|Search enabled|Yes|Yes|Yes|No|No|
|NetworkDiagnosticsFileShare|Troubleshoots problems accessing shared files and folders on other computers over the network.|None|Yes|Yes|Yes|Yes|Yes|
|MaintenanceDiagnostic|Helps the user perform maintenance tasks.|None|Yes|Yes|Yes|No|No|
|WindowsMediaPlayerDVDDiagnostic|Troubleshoots problems playing a DVD using Windows Media Player.|Windows Media Player installed|Yes|No|Yes|No|No|
|WindowsMediaPlayerLibraryDiagnostic|Troubleshoots problems with adding media files to the Windows Media Player library.|Windows Media Player installed|Yes|No|Yes|No|No|
|WindowsMediaPlayerConfigurationDiagnostic|Helps the user reset Windows Media Player settings to the default configuration.|Windows Media Player installed|Yes|No|Yes|No|No|
|WindowsUpdateDiagnostic|Troubleshoots problems that prevent Windows Update from performing update tasks.|None|Yes|Yes|Yes|No|No|

## Additional references

-   For more information about obtaining Console Window Handles, see [How to Obtain a Console Window Handle (HWND)](http://go.microsoft.com/fwlink/?LinkId=160258).

-   For more information about developing custom parameters for use with troubleshooting packs, see [Windows Troubleshooting Platform](http://go.microsoft.com/fwlink/?LinkId=144215).



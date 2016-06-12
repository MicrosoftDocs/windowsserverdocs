---
title: Windows Defender Overview for Windows Server Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 751efb33-a08e-4e90-9208-6f2bc319e029
---
# Windows Defender Overview for Windows Server Technical Preview
Windows Server® 2016 Technical Preview now includes Windows Defender. Windows Defender is malware protection that immediately and actively protects Windows Server 2016 Technical Preview against known malware and can regularly update antimalware definitions through Windows Update.

This topic includes information important for running Windows Defender on a server platform. Use the following links to get to the information you need in this topic:

-   [Using Windows Defender](windows-defender-overview-windows-server-technical-preview.md#BKMK_UsingDef)

-   [Verify Windows Defender is running](windows-defender-overview-windows-server-technical-preview.md#BKMK_DefRun)

-   [Update antimalware definitions](windows-defender-overview-windows-server-technical-preview.md#BKMK_UpdateDef)

-   [Submit Samples](windows-defender-overview-windows-server-technical-preview.md#BKMK_DefSamples)

-   [Automatic exclusions](windows-defender-overview-windows-server-technical-preview.md#BKMK_DefExclusions)

## <a name="BKMK_UsingDef"></a>Using Windows Defender
By default, Windows Defender is installed and functional on Windows Server 2016 Technical Preview. The user interface is installed by default on some SKUs. You can manage Windows Defender by using WMI, Windows PowerShell®, or by using Group Policy.

If the user interface is not installed,  use **Add Roles and Features Wizard**, or the **Install\-WindowsFeature** cmdlet.

To install Windows Defender, start a Windows PowerShell console as an administrator, and run the following command:

`Install-WindowsFeature -Name Windows-Defender-GUI`

To disable Windows Defender, you must uninstall it by using the **Remove Roles and Features Wizard** or by using the **Uninstall\-WindowsFeature** cmdlet.

To uninstall Windows Defender, start a Windows PowerShell console as an administrator, and run the following command:

`Uninstall-WindowsFeature -Name Windows-Server-Antimalware`

> [!TIP]
> Event messages for the antimalware engine included with Windows Defender can be found in [Windows Defender Events]().

## <a name="BKMK_DefRun"></a>Verify Windows Defender is running
To verify that Windows Defender is running on the server, run the following command: `sc query Windefend`. The `sc query` command returns information about the Windows Defender service. If Windows Defender is running, the `STATE` value displays `RUNNING`.

## <a name="BKMK_UpdateDef"></a>Update antimalware definitions
In order to get updated antimalware definitions, you must have the Windows Update service running. If you use an update management service, like Windows Server Update Services \(WSUS\), make sure that updates for Windows Defender definitions are approved for the computers you manage.

By default, Windows Update does not download and install updates automatically on Windows Server 2016 Technical Preview. You can change this configuration by using one of the following methods:

-   **Windows Update** in Control Panel.

    -   **Install updates automatically** results in all updates being automatically installed, including Windows Defender definition updates.

    -   **Download updates but let me choose whether to install them** allows Windows Defender to download and install definition updates automatically, but other updates are not automatically installed.

-   **Group Policy**. You can set up and manage Windows Update by using the settings available in Group Policy, in the following path: **Administrative Templates\\Windows Components\\Windows Update\\Configure Automatic Updates**

-   The **AUOptions** registry key. The following two values allow Windows Update to automatically download and install definition updates.

    -   **4** Install updates automatically. This value results in all updates being automatically installed, including Windows Defender definition updates.

    -   **3** Download updates but let me choose whether to install them.  This value allows Windows Defender to download and install definition updates automatically, but other updates are not automatically installed.

To ensure that protection from malware is maintained, we recommend that you enable the following services:

-   Windows Defender Network Inspection service

-   Windows Error Reporting service

-   Windows Update service

The following table lists the services for Windows Defender and the dependent services.

|Service Name|File Location|Description|
|----------------|-----------------|---------------|
|Windows Defender Service \(Windefend\)|C:\\Program Files\\Windows Defender\\MsMpEng.exe|This is the main Windows Defender service that needs to be running at all times.|
|Windows Defender Network Inspection Service \(Wdnissvc\)|C:\\Program Files\\Windows Defender\\NisSrv.exe|This service is invoked when Windows Defender encounters a trigger to load it.|
|Windows Error Reporting Service \(Wersvc\)|C:\\WINDOWS\\System32\\svchost.exe \-k WerSvcGroup|This service sends   error reports back to Microsoft.|
|Windows Firewall \(MpsSvc\)|C:\\WINDOWS\\system32\\svchost.exe \-k LocalServiceNoNetwork|We recommend leaving the Windows Firewall service enabled.|
|Windows Update \(Wuauserv\)|C:\\WINDOWS\\system32\\svchost.exe \-k netsvcs|Windows Update is needed to get definition updates and antimalware engine updates|

For more information about managing Windows Defender by using Windows PowerShell, see [Windows Defender Cmdlets](http://technet.microsoft.com/library/dn433280.aspx).

As an example of managing Windows Defender by using Windows PowerShell cmdlets, scheduling a time of day to check for definition updates would be enabled by starting a Windows PowerShell console as an administrator and setting the **ScanScheduleTime** value:

`Set-MpPreference –ScanScheduleTime 120`

## <a name="BKMK_DefSamples"></a>Submit Samples
Sample submission allows Microsoft to collect samples of potentially malicious software.  To help provide continued and up\-to\-date protection, Microsoft researchers use these samples to analyze suspicious activities and produce updated antimalware definitions.

We collect program executable files, such as EXE files and DLL files. We do not collect files that contain personal data, like Microsoft Word documents and PDF files.

#### Enable automatic sample submission

-   To enable automatic sample submission, start a Windows PowerShell console as an administrator, and set the **SubmitSamplesConsent** value data according to one of the following settings:

    -   **0** Always prompt. The Windows Defender service prompts you to confirm submission of all required files. This is the default setting for Windows Defender, but is not recommended for Windows Server 2016 Technical Preview installations without a GUI.

    -   **1** Send safe samples automatically. The Windows Defender service sends all files marked as “safe” and prompts for the remainder of the files.

    -   **2** Never send. The Windows Defender service does not prompt and does not send any files.

    -   **3** Send all samples automatically. The Windows Defender service sends all files without a prompt for confirmation.

## <a name="BKMK_DefExclusions"></a>Automatic exclusions
To help ensure security and performance, certain exclusions are automatically added based on the roles and features you install. Windows Defender delivers automatic exclusions for Windows Server 2016 Technical Preview roles via the regularly scheduled definition update process.

To add custom exclusions in addition to the ones automatically added, start a Windows PowerShell console as an administrator, and run the following command:

`Add-MpPreference -ExclusionPath "c:\temp"`

To remove exclusions, start a Windows PowerShell console as an administrator, and run the following command:

`Remove-MpPreference -ExclusionPath "c:\temp"`

> [!TIP]
> Custom and duplicate exclusions do not conflict with automatic exclusions.

For more information about automatic exclusions, see [Automatic exclusions for Windows Defender]().

## See Also
[Windows Defender Cmdlets](http://technet.microsoft.com/library/dn433280.aspx)
[Windows Defender Events]()
[Automatic exclusions for Windows Defender]()



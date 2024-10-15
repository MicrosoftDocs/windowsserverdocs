---
title: How to configure App Control policies in Windows Server 2025 (preview)
description: Learn how to configure App Control for Business using OSConfig PowerShell commands to harden security by implementing custom security policies.
ms.topic: how-to
ms.product: windows-server
ms.author: wscontent
author: xelu86
ms.contributor: Dona Mukherjee, PM
ms.date: 10/15/2024
---


# How to configure App Control for Business with OSConfig

App Control for Business is a software-based security layer that reduces attack surface by enforcing an explicit list of software that is allowed to run. Microsoft developed a default policy for Windows Server 2025, which can be implemented on the server using PowerShell cmdlets. App Control implementation is facilitated by using the OSConfig security configuration platform and provides two main operation modes:

- **Audit mode**: Allows untrusted code to run while events are recorded.
- **Enforcement mode**: Disallows untrusted code from running while events are recorded.

To learn more about these security event logs, see [Understanding App Control events](/windows/security/application-security/application-control/app-control-for-business/operations/event-id-explanations) and [Understanding App Control event tags](/windows/security/application-security/application-control/app-control-for-business/operations/event-tag-explanations).

As a component of Windows Server 2025, the deployment of App Control policies provides easier access to audit mode and enforcement mode through PowerShell. By default, there aren't policies set in audit mode in Windows Server 2025. Instead, businesses can utilize the OSConfig tool to add these policies. OSConfig includes base policies (unsigned) that can be customized with supplemental policies to meet specific business needs. To learn more about this security enhancement, see [Application Control for Windows](/windows/security/application-security/application-control/app-control-for-business/appcontrol).

> [!NOTE]
> The Azure Monitor workbook was created to simplify the process of reviewing audit or block events that are emitted by the Operating System when App Control is activated. This workbook provides insights on file audit and block activity, as well as the following:
>
> - Collecting and sending Windows Event logs for App Control for Business to your Log Analytics workspace.
> - Identifing file and policy event activities using various dashboards, charts, filters, and export capabilities. These features help you analyze and troubleshoot the effects and the status of your App Control policies.
> - Refine your App Control policies by exporting the workbook data and ingesting it into the WDAC Policy Wizard.
>
> To begin using the Azure Monitor workbook for Application Control for Business (Preview), see [How to get insights into App Control for Business (WDAC) events](https://github.com/microsoft/AzureMonitorCommunity/tree/master/Scenarios/How%20to%20get%20insights%20into%20App%20Control%20(WDAC)%20events#how-to-get-insights-into-app-control-for-business-wdac-events).

## Prerequisites

- You must be running Windows Server 2025 on your device and have the OSConfig PowerShell module installed. See [Install the OSConfig PowerShell module](osconfig-how-to-configure-security-baselines.md#install-the-osconfig-powershell-module) for details.
- You must be running Windows 10 version 1909 or later on your client device, and have the [WDAC Policy Wizard](https://webapp-wdac-wizard.azurewebsites.net/) installed.

> [!NOTE]
> If the client device doesn't have **.NET Desktop Runtime 8.0** or later installed, the WDAC Policy Wizard will prompt to download and install this application.

### Manage default policies

# [Configure](#tab/configure)

To configure the default App Control policies in audit mode, open PowerShell as admin and run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\DefaultPolicy\Audit -Default
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\AppBlockList\Audit -Default
```

To configure the default App Control policies in enforcement mode, open PowerShell as admin and run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\DefaultPolicy\Enforce -Default
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\AppBlockList\Enforce -Default
```

# [Verify](#tab/verify)

To verify that the App Control policy was applied, run the following command and hit <kbd>Enter</kbd> twice:

```powershell
citool -lp | findstr /I "WS2025"
```

If policies were configured in audit mode, users should expect the following output:

```output
Friendly Name: BlockUMCI_Microsoft_WS2025_Audit
Friendly Name: AllowMicrosoft_WS2025_Audit
```

If policies were configured in enforcement mode, users should expect the following output:

```output
Friendly Name: BlockUMCI_Microsoft_WS2025_Enforce
Friendly Name: AllowMicrosoft_WS2025_Enforce
```

# [Remove](#tab/remove)

To remove the default App Control policies from audit mode, open PowerShell as admin and run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\DefaultPolicy\Audit
Remove-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\AppBlockList\Audit
```

To remove the default App Control policies from enforcement mode, open PowerShell as admin and run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\DefaultPolicy\Enforce
Remove-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\AppBlockList\Enforce
```

After a policy is removed, there should be no output after running `citool -lp | findstr /I "WS2025"` for verification.

> [!CAUTION]
> Removing App Control policies manually or through citool.exe causes the drift control protection of OSConfig to reestablish the policies after a refresh period of 4 hours by default. Therefore, we recommend using OSConfig to remove any App Control policies that were set by OSConfig.

---

### Monitor event logs

To view captured events after applying the App Control policy, first choose any third-party application you want to run on your device. Then check to see if **Event ID 3076** was emitted for any third-party applications. The system detects attempts by the third-party application to access restricted content and takes measures to block access. To view and export these event logs, follow these steps:

# [View](#tab/view)

1. Right-click on **Start**, select **Event Viewer**.
1. In the left pane, navigate to **Applications and Service Logs\Microsoft\Windows\CodeIntegrity\Operational**.
1. In the middle pane, look for **Event ID 3076**.

# [Export](#tab/export)

1. In the left pane, navigate to **Applications and Service Logs\Microsoft\Windows\CodeIntegrity**.
1. Right-click on the **Operational** log, then select **Filter Current Log**.
1. In the **Filter Current Log** dialog box, select **Clear**, type **3076** in the **\<All Event IDs>** field, then select **OK**.
1. Right-click on the **Operational** log again, then select **Save Filtered Log File As**.
1. In the **Save As** dialog box, provide a name and location of your choice for the `.evtx` file, then select **OK**.
1. The **Display Information** dialog box prompts you if displaying the event log information in another language is required. Choose the appropriate option based on your needs and select **OK**.

---

### Configure supplemental policies

To create supplemental App Control policies, follow these steps:

1. Copy the `.extv` log file from your server to your client device.
1. On the client device, open the **WDAC Policy Wizard**.
1. On the **Home** screen, select **Policy Editor**.
1. On the **Policy Editor** screen, select **Convert Event Log to a WDAC Policy**, then under **Parse Event Log evtx Files to Policy**, select **Parse Log File(s)**.
1. In the **Choose event logs to convert to policy** dialog box, locate your `.evtx` file, select **Open**, select **OK** on the following prompt, then select **Next**.
1. On the **File Rules** screen, under **Filename**, select the file you want to add to into the policy.
1. Under **Rule Type**, select **Path**, then select **+ Add Allow**.
1. Repeat step 7 for all items you want to add into the policy, then select **Next**.

> [!NOTE]
> By default, supplemental policies are stored in **C:\Users\Username\Documents** in XML format.

Once the supplemental policy is generated, copy the XML file to your server and run the following script:

```powershell
$policyPath = "<Path to the XML policy file>" 

# Reset GUID (Best practice)  

Set-CIPolicyIdInfo -FilePath $policyPath -ResetPolicyID 

# Set Policy Version (VersionEx in the XML file)  

$policyVersion = "1.0.0.1" 

Set-CIPolicyVersion -FilePath $policyPath -Version $policyVersion 

# Set Policy Info (PolicyName and PolicyID in the XML file)  

Set-CIPolicyIdInfo -FilePath $policyPath -PolicyID "<App name>-Policy_$policyVersion" -PolicyName "<App name>-Policy" # E.g. Set-CIPolicyIdInfo -FilePath $policyPath -PolicyID "Chrome-Policy_$policyVersion" -PolicyName "Chrome-Policy" 

$base = "{9214D8EE-9B0F-4972-9073-A04E917D7989}" 

Set-CIPolicyIdInfo -FilePath $policyPath -SupplementsBasePolicyID $base 

#Set the new policy into the system  

Set-OSConfigDesiredConfiguration -Scenario AppControl -Name Policies -Value $policyPath
```

To verify that the supplemental policies were applied, monitor **Event ID 3076** as described in [Monitor event logs](#monitor-event-logs) and verify that no new events were generated.

### Query policies

To view what policies are currently in effect in your environment, run the following command:

```powershell
(Get-OSConfigDesiredConfiguration -Scenario AppControl).Value.PolicyInfo | Where-Object { $_.IsEffective -eq $true }
```

To view policies that are currently inactive in your environment, run the following command:

```powershell
(Get-OSConfigDesiredConfiguration -Scenario AppControl).Value.PolicyInfo | Where-Object { $_.IsEffective -eq $false }
```

Output for these queries varies based on your policy configuration needs.

## See also

- [CiTool technical reference](/windows/security/application-security/application-control/app-control-for-business/operations/citool-commands)

- [ConfigCI PowerShell reference](/powershell/module/configci)

- [Provide App Control feedback](mailto:heseccon@microsoft.com)

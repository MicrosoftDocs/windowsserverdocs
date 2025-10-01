---
title: Configure App Control policies in Windows Server
description: Learn how to configure App Control for Business through OSConfig PowerShell commands to harden security by implementing custom security policies.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.contributor: Dona Mukherjee, Carlos Mayol Berral
ms.date: 05/20/2025
---

# Configure App Control for Business by using OSConfig

App Control for Business is a software-based security layer that reduces attack surface by enforcing an explicit list of software that's allowed to run. Microsoft developed a default policy for Windows Server 2025, which you can implement on the server by using Windows PowerShell cmdlets. App Control implementation is facilitated through the OSConfig security configuration platform and provides two main operation modes:

- **Audit mode**: Allows untrusted code to run while events are recorded.
- **Enforcement mode**: Disallows untrusted code from running while events are recorded.

To learn more about these security event logs, see [Understanding App Control events](/windows/security/application-security/application-control/app-control-for-business/operations/event-id-explanations) and [Understanding App Control event tags](/windows/security/application-security/application-control/app-control-for-business/operations/event-tag-explanations).

Because App Control is a component of Windows Server 2025, deployment of its policies provides easier access to audit mode and enforcement mode through PowerShell. By default, audit-mode App Control policies aren't set in Window Server 2025. Instead, organizations can use businesses can use the OSConfig tool to add these policies. OSConfig includes base policies (unsigned) that can be customized with supplemental policies to meet specific business needs. To learn more about this security enhancement, see [Application Control for Windows](/windows/security/application-security/application-control/app-control-for-business/appcontrol).

> [!NOTE]
> An Azure Monitor workbook simplifies the process of reviewing audit or block events that the operating system emits when App Control is activated. This workbook provides insights on file audit and block activity, along with:
>
> - Collecting and sending Windows event logs for App Control for Business to your Log Analytics workspace.
> - Identifying file and policy event activities by using various dashboards, charts, filters, and export capabilities. These features help you analyze and troubleshoot the effects and the status of your App Control policies.
> - Refining your App Control policies by exporting the workbook data and ingesting it in the Microsoft App Control Wizard.
>
> To begin using the Azure Monitor workbook for App Control for Business, see [How to get insights into App Control for Business (WDAC) events](https://aka.ms/appcontrolworkbook).

## Prerequisites

- You must be running a production-signed Windows Server 2025 build on your device. This requirement ensures compliance with the App Control for Business policies.

  > [!CAUTION]
  > Flight-signed binaries aren't permitted. Failure to comply with this requirement results in the inability to start your device.
- The OSConfig PowerShell module must be installed on your server device. See [Install the OSConfig PowerShell module](osconfig-how-to-configure-security-baselines.md#install-the-osconfig-powershell-module) for details.
- You must be running Windows 10 version 1909 or later on your client device, and have the [App Control Wizard](https://webapp-wdac-wizard.azurewebsites.net/) installed.

> [!NOTE]
> If the client device doesn't have .NET Desktop Runtime 8.0 or later installed, the App Control Wizard prompts you to download and install this application.

## Manage default policies

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

To verify that the App Control policy was applied, run the following command and select the <kbd>Enter</kbd> key twice:

```powershell
citool -lp | findstr /I "WS2025"
```

If you configured policies in audit mode, you should expect the following output:

```output
Friendly Name: BlockUMCI_Microsoft_WS2025_Audit
Friendly Name: AllowMicrosoft_WS2025_Audit
```

If you configured policies in enforcement mode, you should expect the following output:

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

After you remove a policy, there should be no output when you run `citool -lp | findstr /I "WS2025"` for verification.

> [!CAUTION]
> Removing App Control policies manually or through `citool.exe` causes the drift control protection of OSConfig to reestablish the policies after a refresh period of four hours by default. We recommend that you use OSConfig to remove any App Control policies that you set by using OSConfig.

---

## Monitor event logs

To view captured events after you apply the App Control policy, choose any third-party application that you want to run on your device. If you set the App Control policy in audit mode, check if the operating system emitted event ID **3076** for any third-party applications. If you set the policy in enforcement mode, check if the operating system emitted event ID **3077**.

The system detects attempts by the third-party application to access restricted content and takes measures to block access. To view and export these event logs, see the following steps:

# [View](#tab/view)

1. Right-click **Start**, and then select **Event Viewer**.
1. On the left pane, go to **Applications and Service Logs\Microsoft\Windows\CodeIntegrity\Operational**.
1. On the middle pane, look for event ID **3076** for audit mode or **3077** for enforcement mode.

# [Export](#tab/export)

1. On the left pane, go to **Applications and Service Logs\Microsoft\Windows\CodeIntegrity**.
1. Right-click the **Operational** log, and then select **Filter Current Log**.
1. In the **Filter Current Log** dialog, select **Clear**, enter **3076** in the **\<All Event IDs>** box, and then select **OK**.
1. Right-click the **Operational** log again, and then select **Save Filtered Log File As**.
1. In the **Save As** dialog, provide a name and location of your choice for the `.evtx` file, and then select **OK**.
1. The **Display Information** dialog asks if you need the event log information displayed in another language. Choose the appropriate option based on your needs, and then select **OK**.

This instruction set is for exporting event logs if you configured your environment for audit mode. To export logs where you used enforcement mode, in the **\<All Event IDs>** box, filter for event ID **3077** instead.

---

## Configure supplemental policies

To create supplemental App Control policies, follow these steps:

1. Copy the `.evtx` log file from your server to your client device.
1. On the client device, open the **App Control Wizard**.
1. On the **Home** screen, select **Policy Editor**.
1. On the **Policy Editor** screen, select **Convert Event Logs to a Policy**. Then, under **Parse Event Log evtx Files to Policy**, select **Parse Log File(s)**.
1. In the **Choose event logs to convert to policy** dialog, locate your `.evtx` file, and then select **Open**. Select **OK** in the prompt, and then select **Next**.
1. On the **File Rules** screen, under **Filename**, select the file that you want to add to the policy.
1. Under **Rule Type**, select **Path**, and then select **+ Add Allow**.
1. Repeat step 7 for all items that you want to add to the policy, and then select **Next**.

> [!NOTE]
> By default, supplemental policies are stored in **C:\Users\Username\Documents** in XML format.

After the supplemental policy is generated, copy the XML file to your server and run the following script:

```powershell
$policyPath = "<Path to the XML policy file>"

# Reset GUID (best practice)

Set-CIPolicyIdInfo -FilePath $policyPath -ResetPolicyID

# Set policy version (VersionEx in the XML file)

$policyVersion = "1.0.0.1"

Set-CIPolicyVersion -FilePath $policyPath -Version $policyVersion

# Set policy info (PolicyName and PolicyID in the XML file)

Set-CIPolicyIdInfo -FilePath $policyPath -PolicyID "<App name>-Policy_$policyVersion" -PolicyName "<App name>-Policy" # E.g. Set-CIPolicyIdInfo -FilePath $policyPath -PolicyID "Chrome-Policy_$policyVersion" -PolicyName "Chrome-Policy"

$base = "{9214D8EE-9B0F-4972-9073-A04E917D7989}"

Set-CIPolicyIdInfo -FilePath $policyPath -SupplementsBasePolicyID $base

#Set the new policy into the system

Set-OSConfigDesiredConfiguration -Scenario AppControl -Name Policies -Value $policyPath
```

To verify that the supplemental policies were applied, monitor event IDs **3076** and **3077** as described earlier in [Monitor event logs](#monitor-event-logs). Verify that the operating system didn't generate any new events.

## Query policies

To view the policies that are currently in effect in your environment, run the following command:

```powershell
(Get-OSConfigDesiredConfiguration -Scenario AppControl).Value.PSObject.Properties | ForEach-Object { $_.Value.PolicyInfo } | Where-Object { $_.IsEffective -eq $true }
```

To view policies that are currently inactive in your environment, run the following command:

```powershell
(Get-OSConfigDesiredConfiguration -Scenario AppControl).Value.PSObject.Properties | ForEach-Object { $_.Value.PolicyInfo } | Where-Object { $_.IsEffective -eq $false }
```

Output for these queries varies based on your policy configuration needs.

## Related content

- [CiTool technical reference](/windows/security/application-security/application-control/app-control-for-business/operations/citool-commands)
- [ConfigCI PowerShell reference](/powershell/module/configci)


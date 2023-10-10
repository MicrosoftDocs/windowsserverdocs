---
title: AD FS Help Diagnostics Analyzer
description:  This article describes AD FS Help Diagnostics Analyzer and how it can perform the basic checks using AD FS diagnostics PowerShell module.
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# AD FS Help Diagnostics Analyzer

AD FS includes numerous settings that support the wide variety of functionality it provides for authentication and application development. During troubleshooting, it's recommended to ensure that all of the AD FS settings are correctly configured. Doing a manual check of these settings can sometimes be time consuming. AD FS Help Diagnostics Analyzer can help perform the basic checks using the ADFSToolbox PowerShell module. After performing the checks, AD FS Help provides the [Diagnostics Analyzer](https://aka.ms/adfsdiagnosticsanalyzer) to help you easily visualize the results and offer remediation steps.

The diagnostics operation can be divided into three simple steps:

- Step 1 - Set up the ADFSToolbox module on the primary AD FS server or WAP server
- Step 2 - Execute the diagnostics and upload the file to AD FS Help
- Step 3 - View diagnostics analysis and resolve any issues

Go to [AD FS Help Diagnostics Analyzer (https://aka.ms/adfsdiagnosticsanalyzer)](https://aka.ms/adfsdiagnosticsanalyzer) to start troubleshooting.

![AD FS diagnostics analyzer tool on AD FS Help](media/ad-fs-diagonostics-analyzer/home.png)

## Step 1: Set up the ADFSToolbox module on AD FS server

To run the [Diagnostics Analyzer](https://aka.ms/adfsdiagnosticsanalyzer), you must install the ADFSToolbox PowerShell module. If the AD FS server has connectivity to the internet, you can install the ADFSToolbox module directly from the PowerShell gallery. If there's no connectivity to the internet, you can manually install it.

[!WARNING]
If you're using AD FS 2.1 or lower, you must install version 1.0.13 of ADFSToolbox. ADFSToolbox no longer supports AD FS 2.1 or lower on the latest versions.

![AD FS diagnostics analyzer - setup](media/ad-fs-diagonostics-analyzer/step1_v2.png)

### Setup using PowerShell gallery

If the AD FS server has internet connectivity, it's recommended to install the ADFSToolbox module directly from the PowerShell gallery using the following PowerShell commands.

   ```powershell
    Install-Module -Name ADFSToolbox -force
    Import-Module ADFSToolbox -force
   ```

### Setup manually

The ADFSToolbox module must be manually copied over to the AD FS or WAP servers. The following procedure copies the ADFSToolbox to the desired location.

1. Launch an elevated PowerShell window on a machine that has internet access.
1. Install the AD FS Toolbox module.

    ```powershell
    Install-Module -Name ADFSToolbox -Force
    ```

1. Copy the ADFSToolbox folder located `%SYSTEMDRIVE%\Program Files\WindowsPowerShell\Modules\` on your local machine to the same location on your AD FS or WAP machine.

1. Launch an elevated PowerShell window on your AD FS machine and run the following cmdlet to import the module.

    ```powershell
    Import-Module ADFSToolbox -Force
    ```

## Step 2: Execute the diagnostics cmdlet

![AD FS diagnostics analyzer tool - execute and upload results](media/ad-fs-diagonostics-analyzer/step2_v2.png)

A single command can be used to conveniently execute the diagnostics tests across all the AD FS servers in the farm. The PowerShell module uses remote PowerShell sessions to execute the diagnostics tests across different servers in the farm.

```powershell
    Export-AdfsDiagnosticsFile [-ServerNames <list of servers>]
```

In a Windows Server 2016 or later AD FS farm, the command reads the list of AD FS servers from AD FS configuration. The diagnostics tests are then attempted against each server in the list. If the list of AD FS servers isn't available (example 2012R2), then the tests are run against the local machine. To specify a list of servers against which the tests are to be executed, use the **ServerNames** argument to provide a list of servers. The following example is provided.

```powershell
    Export-AdfsDiagnosticsFile -ServerNames @("adfs1.contoso.com", "adfs2.contoso.com")
```

The result is a JSON file that is created in the same directory where the command was run. The name of the file is AdfsDiagnosticsFile-\<timestamp\>. An example file name is AdfsDiagnosticsFile-07312019-184201.json.

## Step 3: Upload the diagnostics file

Following step 3 in the article [https://aka.ms/adfsdiagnosticsanalyzer](https://aka.ms/adfsdiagnosticsanalyzer), use the file browser to select the result file to upload.

Select **Upload** to finish the upload.

When you sign in with a Microsoft account, your diagnostics results can be saved for a later viewing point and can be sent to Microsoft support. If at any point you open a support case, Microsoft is able to view the Diagnostic Analyzer results and help troubleshoot your issue faster.

![AD FS diagnostics analyzer tool - sign in](media/ad-fs-diagonostics-analyzer/sign_in_step.png)

## Step 4: View diagnostics analysis and resolve any issues

There are five sections of the test results:

- Failed: This section contains list of tests that failed.
- Warning: This section contains a list of tests that resulted in a warning. These issues don't result in any issues around authentication on a broader scale but should be addressed as early as possible.
- Passed: This section contains the list of tests that passed and require no other action.
- Not run: This section contains the list of tests that couldn't be run due to missing information.
- Not applicable: This section contains the list of tests that weren't executed because they weren't applicable for the particular server on which the command was executing.

![AD FS diagnostics analyzer tool - test results list](media/ad-fs-diagonostics-analyzer/step3a_v3.png)

Each test result is displayed with details that describe the test and the resolution steps. Details include:

- Test name: Name of the test that was executed
- Description: A description of the test
- Details: Description of the overall operation performed during the test
- Resolution steps: The suggested steps to resolve the issue highlighted by the test

![AD FS diagnostics analyzer tool - failure resolution](media/ad-fs-diagonostics-analyzer/step3b_v3.png)

## Related links

- [Use AD FS Help troublehshooting guides](https://aka.ms/adfshelp/troubleshooting )
- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)

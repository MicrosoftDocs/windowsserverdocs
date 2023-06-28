---
title: Extension support for the management of Windows Defender Application Control (WDAC) enforced infrastructure
description: Develop an extension using Windows Admin Center SDK - Ensuring your extension can manage WDAC-enforced servers and clusters
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 06/27/2023
---
# Extension support for the management of Windows Defender Application Control (WDAC) enforced infrastructure

>Applies to: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center supports the management of Windows Defender Application Control (WDAC) enforced infrastructure at the platform level. Learn more about [managing WDAC enforced infrastructure in Windows Admin Center](../../use/manage-application-control-infrastructure.md).

Support for this management at the platform level doesn't mean extensions built for Windows Admin Center also support the management of WDAC enforced infrastructure by default. This guide outlines the requirements for an extension to support the management of WDAC enforced infrastructure.

## Extension structure requirements
To manage WDAC enforced infrastructure, Windows Admin Center must ingest and run PowerShell scripts in a particular fashion to adhere to best security practices. To ensure your extension's scripts are run correctly, ensure your extension conforms to the following requirements.

### All PowerShell scripts must be stored in a file
Historically, developers of WAC extensions may have chosen to include custom PowerShell code as a string in their extension manifest.json file. For example, one may choose to define the [conditions for a tool extension’s visibility](dynamic-tool-display.md) by providing a PowerShell script in the “script” property. For PowerShell scripts to be compatible with WDAC, they must be signed. Strings can't be signed.

To ensure this requirement is met, follow these steps:
1. Identify any PowerShell scripts in your manifest.json file.
2. After defining any script content in your manifest.json file, remove the script content and store it in a .ps1 file in the ```resources/scripts``` directory of your extension. Script code in the extension manifest now follows the same rules as [other Windows Admin Center PowerShell](powershell.md). 
3. Update the conditions property in the extension manifest to the following format:
    ```json
    "conditions": [
        {
            "powerShell": {
                "command": "Script-File-Name",
                "module": "powerShellModuleName",
                "script": "Your script text goes here."
            }
        }
    ]
    ```
    The PowerShell module name already exists in your extension manifest. **Its value in the manifest and in the PowerShell field must match.**
4. Identify any other places where PowerShell scripts are being created dynamically. Creating a PowerShell script dynamically using string concatenation can allow an attacker to inject arbitrary PowerShell script to be executed. This method can be used to bypass limitations enforced on a remote user that is using a restricted run space. It can also be used to achieve standard command injection against any application that builds PowerShell scripts with user input and executes it.

Example of script block created with string concatenation:
```PowerShell
param($UserInputVar)
$DynamicScript = "Get-ChildItem $UserInputVar"
$ScriptBlock = [ScriptBlock]::Create($DynamicScript)
Invoke-Command $ScriptBlock
```

Example of this same script block constructed without string concatenation:
```PowerShell
param($UserInputVar)
 [ScriptBlock]$ScriptBlock = {
Param($SafeUserInput)
Get-ChildItem $ SafeUserInput
 }
 Invoke-Command -ScriptBlock $ScriptBlock -ArgumentList @($UserInputVar)

# OR, alternatively
param($UserInputVar)
 Invoke-Command -ScriptBlock {
 param(
    [String] $SafeUserInput
 )
Get-ChildItem $SafeUserInput

} -ArgumentList $UserInputVar
```

Script files should also not be constructed using string concatenation. Here's an example of how not to construct script files: 
```PowerShell
$Script=@'
    Get-ChildItem $UserInputVar
'@
$Script = '$ UserInputVar =' + "'$ UserInputVar;"+$Script 
$path = “C:\temp”
$Script | Out-File $path
```

Construct your script files like this instead:
```PowerShell
Function test {
    param(
        [String] $userInputVar
     )
    Get-ChildItem $UserInputVar
    }
   
    $path = “C:\temp”
    (Get-Command test).ScriptBlock | Set-Content -path $path
```

### All PowerShell code must be signed and stored in the proper location
As part of the changes Windows Admin Center made to support the management of WDAC enforced infrastructure, signed PowerShell scripts for an extension are now transferred to the node Windows Admin Center is currently connected to before being run. Additionally, as mentioned in the previous requirement, WDAC enforced infrastructure only runs signed PowerShell scripts. Because of these requirements, all your PowerShell code must be signed. All your PowerShell must also be located in a consistent location so that the Windows Admin Center platform can predictably locate an extension’s signed modules.

If your extension repository doesn't contain a ```powershell-module``` directory containing signed PowerShell module(s), the Windows Admin Center platform will be unable to identify transferable code, and operations will fail in a WDAC-enforced environment.

The Windows Admin Center ```gulp build``` command updates the ```/dist``` folder inside your repository, generating your unsigned .psd1 and .psm1 files inside a module folder. These files need to be signed with a signing certificate that matches one that is allow-listed in the WDAC policy.

To make this change, it's highly recommended to create a build pipeline that incorporates PowerShell signing.

You can validate that your PowerShell is in the proper format in one of two ways:
1.	When your extension is installed, you can view the ```ProgramData\Server Management Experience\UX\modules``` directory on your gateway machine (the one on which Windows Admin Center is running). Here you should see the ```powershell-module``` folder and the signed PowerShell module(s)
2.	Extract the contents of your extension’s .nupkg artifact. The ```powershell-module``` folder should be present and contain the signed PowerShell module(s).

In both cases, verifying that the .psd1 and .psm1 files themselves are signed can be done by running the [Get-AuthenticodeSignature command](/powershell/module/microsoft.powershell.security/get-authenticodesignature?view=powershell-7.3&preserve-view=true) on the file, or by right-clicking the file itself and validating the digital signature.

### WorkItems that utilize the "powerShellScript" property should be updated to use the "powerShellCommand" property
The Windows Admin Center platform needs to be able to determine which module a PowerShell command belongs to. Because of this requirement, WorkItems that specify a PowerShell command using the ```powerShellScript``` property cause an error. 

To mitigate this behavior, use the ```powerShellCommand``` property, along with the ```createCommand``` method, to form a valid command object.

Here’s an example of a WorkItem using the old method:
```ts
    const workItem : WorkItemSubmitRequest = {
      typeId: "SampleWorkItem",
      title: "Title",
      powerShellScript: PowerShellScripts.[scriptName],
      successMessage: "Success",
      errorMessage: "Error",
      progressMessage: "In progress..."
    }
```

And here's the same WorkItem using the new method:
```ts
    const workItem : WorkItemSubmitRequest = {
      typeId: "SampleWorkItem",
      title: "Title",
      powerShellCommand: PowerShell.createCommand(PowerShellScripts.[scriptName]),
      successMessage: "Success",
      errorMessage: "Error",
      progressMessage: "In progress..."
    }
```

## Ensuring PowerShell scripts run in Constrained Language mode
Many WDAC policies force all PowerShell scripts to run in Constrained-Language mode. To maintain full functionality throughout Windows Admin Center, you should ensure that all scripts in your extension follow these best practices:
1. If your script files are exported using PowerShell modules, they must explicitly export the functions by name without the use of wildcard characters. This requirement is to prevent inadvertently exposing helper functions that may not be meant to be used publicly. 
2. Dot sourcing a script file brings all functions, variables, aliases from that script into the current scope. This functionality blocks a trusted script from being dot sourced into an untrusted script and exposing all its internal functions. Similarly, an untrusted script is prevented from being dot sourced into a trusted script so that it can't pollute the trusted scope.
3. It's recommended to avoid using the Start-Job command to run script blocks unless that script block can already be run successfully in Constrained-Language mode.

## Suggested error handling for failure to support WDAC enforced infrastructure management
If you don't plan to support running your extension on WDAC-enforced machines, we suggest adding UI explaining that the management of WDAC enforced infrastructure is an unsupported scenario in your extension to avoid user confusion. We recommend a layout like our existing Azure hybrid services pages, which features the extension icon and text centered on the extension iFrame. 

For the text on this page, we suggest the following wording: 

“This extension doesn't currently support running on machines with Windows Defender Application Control (WDAC) enforced.”

This text is only a suggestion. If you’re unsure about the wording you’d like to use, email the Windows Admin Center team at wacextensionrequests@microsoft.com. 

## Detecting WDAC enforcement from your extension
To follow the guidance in the previous section, you need to determine if the node you're connected to has WDAC enforced. Windows Admin Center exposes a method called ```getPsLanguageMode```, defined as part of Windows Admin Center’s WDAC operations, to determine WDAC enforcement.

This method has two outputs:
- Status – HTTPStatusCode type
- psLanguageMode – PsLanguageMode type ([enum](/dotnet/api/system.management.automation.pslanguagemode?view=powershellsdk-7.0.0&preserve-view=true))

You may consider WDAC to be enforced if PowerShell is running in Constrained Language Mode, which corresponds to a psLanguageMode value of 3.

The following TypeScript sample code gives an example of how to use this method:
```ts
import { Component, OnInit } from '@angular/core';
import { AppContextService } from '@microsoft/windows-admin-center-sdk/angular';
import { WdacOperations } from '@microsoft/windows-admin-center-sdk/core';
import { PSLanguageMode, PsLanguageModeResult } from '@microsoft/windows-admin-center-sdk/core/data/wdac-operations';

@Component({
  selector: 'default-component',
  templateUrl: './default.component.html',
  styleUrls: ['./default.component.css']
})
export class DefaultComponent implements OnInit {
wdacEnforced: boolean;

  constructor(private appContextService: AppContextService) {
    //
  }

  public ngOnInit(): void {

  }

  public checkWDACEnforced(): void {
    const wdacOperations = new WdacOperations(this.appContextService);
    wdacOperations.getPsLanguageMode(this.appContextService.activeConnection.nodeName).subscribe(
      (response: PsLanguageModeResult) => {
          if (response.psLanguageMode.toString() === PSLanguageMode[PSLanguageMode.ConstrainedLanguage]) {
            this.wdacEnforced = true;
          }
          else {
            this.wdacEnforced = false;
          }
      }
    );
  }
}
```

## Testing your extension on WDAC enforced infrastructure
Read more about the [Windows Defender Application Control policy requirements for Windows Admin Center](../../use/manage-application-control-infrastructure.md) to get started with testing your extension on WDAC enforced infrastructure. 

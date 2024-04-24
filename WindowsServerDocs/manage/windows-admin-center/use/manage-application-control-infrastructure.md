---
title: Managing Windows Defender application control (WDAC) enforced infrastructure with Windows Admin Center
description: Managing WDAC-enforced servers and clusters with Windows Admin Center
ms.topic: article
author: prasidharora
ms.author: praror
ms.date: 08/18/2022
---
# Managing Windows Defender Application Control (WDAC) enforced infrastructure

>Applies to: Windows Admin Center Preview

Windows Defender application control (WDAC) can help mitigate many security threats by restricting the applications that users are allowed to run and the code that runs in the System Core (kernel). Application control policies can also block unsigned scripts and MSIs, and restrict Windows PowerShell to run in [Constrained Language Mode](/powershell/module/microsoft.powershell.core/about/about_language_modes). Learn more about [Application Control for Windows](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control).

Extra configuration is required for Windows Admin Center to install on and manage WDAC enforced environments. This document covers these requirements and known issues when managing a WDAC enforced environment.

## Requirements
This section provides the requirements for using Windows Admin Center to manage your WDAC enforced infrastructure (servers, client machines, or clusters).

- [Policy requirements](#policy-requirements)
- [Networking requirements](#networking-requirements)
- [Permissions](#permissions)
- [PowerShell execution policy](#powershell-execution-policy)

### Policy requirements
Depending on your use case, you'll need to allowlist one or more certificates as part of your base or supplemental policies. Learn more about [deploying a base or supplemental policy](/windows/security/threat-protection/windows-defender-application-control/types-of-devices).

**Case [1]**: Only your managed nodes have WDAC enforced. 

**Case [2]**: Both your managed node and the machine on which you deploy Windows Admin Center have WDAC enforced.

For case **[1]**, only the following signer rule is required to be allowlisted in the WDAC policy on your managed node:
```xml
<Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011"> 
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" /> 
  <CertPublisher Value="Microsoft Corporation" /> 
</Signer> 
```

For case **[2]**:
- The signer rule above is required to be allowlisted on **both** your managed node and the machine on which you deploy Windows Admin Center.
- Additionally, the following signer and file/hash rules are required to be allowlist **only** on the machine on which you deploy Windows Admin Center: 
>Signer rule:
```xml
<Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011"> 
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" /> 
  <CertPublisher Value="Microsoft 3rd Party Application Component" /> 
</Signer> 
```
>File/Hash rule:
```xml
<FileRules>
    <!--Requirement from WAC to allow files from WiX-->
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll" Hash="9DE61721326D8E88636F9633AA37FCB885A4BABE" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll" Hash="B216DFA814FC856FA7078381291C78036CEF0A05" />
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll" Hash="233F5E43325615710CA1AA580250530E06339DEF861811073912E8A16B058C69" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll" Hash="B216DFA814FC856FA7078381291C78036CEF0A05" />
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="EB4CB5FF520717038ADADCC5E1EF8F7C24B27A90" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="6C65DD86130241850B2D808C24EC740A4C509D9C" />
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="C8D190D5BE1EFD2D52F72A72AE9DFA3940AB3FACEB626405959349654FE18B74" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="6C65DD86130241850B2D808C24EC740A4C509D9C" />
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX firewall.dll" Hash="2F0903D4B21A0231ADD1B4CD02E25C7C4974DA84" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX firewall.dll" Hash="868635E434C14B65AD7D7A9AE1F4047965740786" />
    <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX firewall.dll" Hash="5C29B8255ACE0CD94C066C528C8AD04F0F45EBA12FCF94DA7B9CA1B64AD4288B" />
    <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX firewall.dll" Hash="868635E434C14B65AD7D7A9AE1F4047965740786" />
  </FileRules>
  ```
>[!NOTE]
> Signer and Allow ID (i.e., Signer ID="ID_SIGNER_S_XXXXX") should be generated automatically by the policy creation tool/script. For more info, refer to the [WDAC documentation](/windows/security/threat-protection/windows-defender-application-control/types-of-devices)

>[!TIP]
> The [WDAC Wizard tool](/windows/security/threat-protection/windows-defender-application-control/wdac-wizard) can be very helpful for creating/editing WDAC Policies. Remember that when creating a new policy, whether by the Wizard or the PowerShell commands, use the “Publisher” rule on binaries to generate rules. For example, when using the wizard, you can generate the WDAC policy for case **[1]** based off the Windows Admin Center .msi. For case **[2]**, you can still use the wizard, but you will need to manually edit your WDAC policy to include the listed signer and hash rule.

### Networking requirements
By default, Windows Admin Center communicates with your servers over WinRM over HTTP (port 5985) or HTTPS (port 5986). For WDAC enforced infrastructure, Windows Admin Center additionally needs SMB access to the nodes that are being managed (TCP port 445).

### Permissions
File transfer based on UNC paths over SMB port 445 is critical for Windows Admin Center to manage these environments. Make sure you're an administrator on the managed server or cluster and file transfers aren't blocked by any security policies.

### PowerShell execution policy
The default PowerShell [ExecutionPolicy](/powershell/module/microsoft.powershell.core/about/about_execution_policies) is sufficient for Windows Admin Center to manage a Windows Defender Application Control enforced machine. However, if the default ExecutionPolicy has changed on the machine, you need to ensure the ```LocalMachine```'s scope is set to ```RemoteSigned``` to allow signed scripts to be loaded and executed. This is a PowerShell security feature and changes should be done only when appropriate and necessary.

## Installing and connecting
### Installing
Install Windows Admin Center on your WDAC enforced server or client machine just like you normally would. If the above requirements are met, Windows Admin Center should install and function as normal.

### Connecting
Connect to your WDAC enforced server, client, or cluster machines like you normally would. Upon connecting to your server, you can track the enforcement status by the "PowerShell Language Mode" field on the **Overview** page. If the value of this field is "Constrained", then WDAC is being enforced.

When you connect to a WDAC enforced cluster for the first time, it may take a few minutes for Windows Admin Center to set up connection to your cluster. Subsequent connections won't have a delay.

>[!NOTE]
> If you change the WDAC enforcement status of your managed nodes, do not use Windows Admin Center for at least 30 seconds for this change to be reflected.

## Known issues
- Currently, deploying Azure Kubernetes Service on Azure Stack HCI and Resource Bridge through Windows Admin Center isn't supported on a WDAC enforced environment. Additionally, using the Remote Support and GPU extension on Azure Stack HCI isn't currently supported.

- Using RBAC on a single server is currently not supported.

- Certain operations in the Certificates tool are currently not supported.

## Troubleshooting
- "Module not found" or "failed to connect" error
    1. In order to confirm whether or not Windows Admin Center successfully transferred files to your managed node, navigate to the `%PROGRAMFILES%\WindowsPowerShell\Modules` folder on your managed node, and verify that modules with the name `Microsoft.SME.*` exist in that folder
    1. In the event they don't exist, reconnect to your server or cluster from Windows Admin Center
    1. Ensure that the machine that has Windows Admin Center installed has access to TCP port 445 on the managed node

## Related articles

- [WDAC design guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-design-guide)
- [WDAC deployment guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide)
- [AppLocker overview](/windows/security/threat-protection/windows-defender-application-control/applocker/applocker-overview)

---
title: Manage Windows Defender Application Control (WDAC) Enforced Infrastructure with Windows Admin Center
description: Learn about managing WDAC-enforced servers and clusters by using Windows Admin Center.
ms.topic: article
author: davannaw-msft
ms.author: roharwoo
ms.date: 08/18/2022
---
# Manage Windows Defender Application Control (WDAC)-enforced infrastructure

Windows Defender Application Control (WDAC) can help mitigate many security threats by restricting the applications that users are allowed to run and the code that runs in the system core (kernel). Application control policies can also block unsigned scripts and MSI files, and restrict Windows PowerShell to running in [`ConstrainedLanguage` mode](/powershell/module/microsoft.powershell.core/about/about_language_modes). [Learn more about application control for Windows](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control).

Extra configuration is required for Windows Admin Center to install on and manage WDAC-enforced environments. This article covers these requirements and known issues in managing a WDAC-enforced environment.

## Requirements

The following sections provide the requirements for using Windows Admin Center to manage your WDAC-enforced infrastructure (servers, client machines, or clusters).

### Policy requirements

Depending on your use case, you need to add one or more certificates to your allowlist as part of your base or supplemental policies. [Learn more about deploying a base or supplemental policy](/windows/security/threat-protection/windows-defender-application-control/types-of-devices).

- **Case 1**: Only your managed nodes have WDAC enforced.
- **Case 2**: Both your managed node and the machine on which you deploy Windows Admin Center have WDAC enforced.

For Case 1, only the following signer rule needs to be allowlisted in the WDAC policy on your managed node:

```xml
<Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011"> 
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" /> 
  <CertPublisher Value="Microsoft Corporation" /> 
</Signer> 
```

For Case 2, the preceding signer rule must be allowlisted on *both* your managed node and the machine on which you deploy Windows Admin Center. Additionally, the following signer rules must be allowlisted *only* on the machine on which you deploy Windows Admin Center:

```xml
<Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011"> 
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" /> 
  <CertPublisher Value="Microsoft 3rd Party Application Component" /> 
</Signer>
<Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011">
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" />
  <CertPublisher Value=".NET" />
</Signer>
```

The signer rule with `CertPublisher Value=".NET"` is not required if you're using a version of Windows Admin Center older than 2410. However, these older versions require the following file/hash rules to be allowlisted *only* on the machine on which you deploy Windows Admin Center:

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

The policy creation tool/script should automatically generate `Signer ID` and `Allow ID` (that is, `Signer ID="ID_SIGNER_S_XXXXX"`). For more info, refer to the [WDAC documentation](/windows/security/threat-protection/windows-defender-application-control/types-of-devices).

> [!TIP]
> The [App Control for Business Wizard](/windows/security/application-security/application-control/app-control-for-business/design/appcontrol-wizard) can be helpful for creating and editing WDAC policies. Remember that when you're creating a new policy, whether by using the wizard or the PowerShell commands, use the `Publisher` rule on binaries to generate rules. For example, when you're using the wizard, you can generate the WDAC policy for Case 1 based on the Windows Admin Center .msi file. For Case 2, you can still use the wizard, but you need to manually edit your WDAC policy to include the listed signer and hash rule.

### Network requirements

By default, Windows Admin Center communicates with your servers via WinRM over HTTP (port 5985) or HTTPS (port 5986). For WDAC-enforced infrastructure, Windows Admin Center additionally needs SMB access to the managed nodes (TCP port 445).

### Permissions

File transfer based on UNC paths over SMB port 445 is critical for Windows Admin Center to manage these environments. Make sure that you're an administrator on the managed server or cluster. Also make sure that security policies aren't blocking file transfers.

### PowerShell execution policy

The default PowerShell [execution policy](/powershell/module/microsoft.powershell.core/about/about_execution_policies) is sufficient for Windows Admin Center to manage a WDAC-enforced machine. However, if the default execution policy changes on the machine, you need to ensure that the `LocalMachine` scope is set to `RemoteSigned` to allow signed scripts to be loaded and executed. This is a PowerShell security feature, and you should make changes only when they're appropriate and necessary.

## Installing

Install Windows Admin Center on your WDAC-enforced server or client machine just as you normally would. If you meet the preceding requirements, Windows Admin Center should install and function as normal.

## Connecting

Connect to your WDAC-enforced server, client, or cluster machines as you normally would. Upon connecting to your server, you can track the enforcement status via the **PowerShell Language Mode** field on the **Overview** page. If the value of this field is **Constrained**, WDAC is being enforced.

When you connect to a WDAC-enforced cluster for the first time, Windows Admin Center might take a few minutes to set up a connection to your cluster. Subsequent connections won't have a delay.

> [!NOTE]
> If you change the WDAC enforcement status of your managed nodes, don't use Windows Admin Center for at least 30 seconds for this change to be reflected.

## Known issues

- Currently, deploying Azure Kubernetes Service on Azure Local and Azure Arc resource bridge through Windows Admin Center isn't supported in a WDAC-enforced environment.

- Using role-based access control (RBAC) on a single server is currently not supported.

- Certain operations in the Certificates tool are currently not supported.

## Troubleshooting

If you get a "Module not found" or "failed to connect" error:

- To confirm whether Windows Admin Center successfully transferred files to your managed node, go to the `%PROGRAMFILES%\WindowsPowerShell\Modules` folder on your managed node and verify that modules with the name `Microsoft.SME.*` exist in that folder.

  If the modules don't exist, reconnect to your server or cluster from Windows Admin Center.

- Ensure that the machine where Windows Admin Center is installed has access to TCP port 445 on the managed node.

## Related content

- [WDAC design guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-design-guide)
- [WDAC deployment guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide)
- [AppLocker overview](/windows/security/threat-protection/windows-defender-application-control/applocker/applocker-overview)

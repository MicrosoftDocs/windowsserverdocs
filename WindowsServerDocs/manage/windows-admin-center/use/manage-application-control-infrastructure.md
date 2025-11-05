---
title: WDAC enforced infrastructure in Windows Admin Center
description: Learn about Windows Defender Application Control (WDAC) enforced servers and clusters in using Windows Admin Center including settings and requirements.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 08/14/2025
---

# WDAC enforced infrastructure in Windows Admin Center

Windows Defender Application Control (WDAC) enhances security by restricting which applications and code can run on your systems, including kernel-level code. WDAC policies can block unsigned scripts, `.msi` installers, and enforce [ConstrainedLanguage](/powershell/module/microsoft.powershell.core/about/about_language_modes) mode in Windows PowerShell.

To successfully install and manage Windows Admin Center in WDAC-enforced environments, additional configuration steps are required. When you connect to your WDAC-enforced server, client, or cluster, Windows Admin Center displays the enforcement status on the **Overview** page under the **PowerShell Language Mode** field. If the value is **Constrained**, WDAC enforcement is active. Initial connections to WDAC-enforced clusters might take several minutes, but subsequent connections are typically faster.

> [!NOTE]
> If you modify the WDAC enforcement status of your managed nodes, wait at least ~30 seconds before using Windows Admin Center to allow the change to be reflected accurately.

## Requirements

The following sections outline the essential requirements for your WDAC-enforced infrastructure, such as servers, client machines, or clusters, using Windows Admin Center. Ideally, both Windows Admin Center and the managed nodes should belong to the same domain or have a trusted relationship to simplify management and authentication processes. Here are other requirements and considerations you should be aware of:

- **Installation**: Install Windows Admin Center on your WDAC-enforced server or client machine just as you normally would.

- **Administrator access**: Ensure that you have local administrator rights on both the Windows Admin Center host machine and the managed nodes. These rights are essential for performing management tasks. File transfers based on the UNC paths over SMB port 445 are crucial for Windows Admin Center to effectively manage these environments. Ensure you have administrative rights on the managed server or cluster and confirm that security policies don't impede file transfers. If delegation of permissions is required, ensure that delegation policies are correctly configured to grant necessary permissions without excessive privilege.

- **Supported Operating Systems**: Verify that the operating systems of both the Windows Admin Center host and the managed nodes are supported by Windows Admin Center.

- **Network configuration**: Ensure proper network configuration, particularly firewall settings, to allow HTTP (port 5985), HTTPS (port 5986), and SMB traffic as necessary for WinRM and file transfers. Windows Admin Center needs SMB access to the managed nodes on TCP port 445. If using HTTPS for secure communication, ensure that appropriate TLS/SSL certificates are installed and configured on the Windows Admin Center gateway.

## Policy requirements

Depending on your specific use case, you'll need to authorize one or more certificates in your allowlist, either within your base policies or as supplemental policies. To learn more, see [App Control for Business deployment in different scenarios](/windows/security/threat-protection/windows-defender-application-control/types-of-devices).

- **Case 1**: Only your managed nodes have WDAC enforced.

  Only the following signer rule needs to be allowlisted in the WDAC policy on your managed node:

  ```xml
  <Signer ID="ID_SIGNER_S_XXXXX" Name="Microsoft Code Signing PCA 2011">
  <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" />
  <CertPublisher Value="Microsoft Corporation" />
  </Signer>
  ```

- **Case 2**: Both your managed node and the machine hosting Windows Admin Center have WDAC enforced.

  Apply the mentioned signer rule from case 1 on both the managed node and the machine hosting Windows Admin Center. Additionally, add the following signer rules to the allowlist solely on the machine hosting Windows Admin Center:

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

The [App Control for Business Wizard](/windows/security/application-security/application-control/app-control-for-business/design/appcontrol-wizard) can help in creating and editing WDAC policies. When crafting a new policy, either via the wizard or PowerShell commands, utilize the `Publisher` rule based on binaries to formulate rules. For example:

- In case 1, generate the WDAC policy using the Windows Admin Center `.msi` file with the wizard.

- In case 2, you can still employ the wizard but must manually update your WDAC policy to incorporate the specified signer and hash rule.

For versions of Windows Admin Center before 2410, the `CertPublisher Value=".NET"` rule is unnecessary. However, those older versions require specific file/hash rules to be allowlisted only on the Windows Admin Center host:

```xml
<FileRules>
  <!--Requirement from WAC to allow files from WiX-->
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll" Hash="AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll" Hash="BB22CC33DD44EE55FF66AA77BB88CC99DD00EE11" />
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll" Hash="AA77BB88CC99DD00EE11FF22AA33BB44CC55DD66" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll" Hash="BB22CC33DD44EE55FF66AA77BB88CC99DD00EE11" />
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="CC33DD44EE55FF66AA77BB88CC99DD00EE11FF22" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="DD44EE55FF66AA77BB88CC99DD00EE11FF22AA33" />
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="BB88CC99DD00EE11FF22AA33BB44CC55DD66EE77" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX wixca.dll 2" Hash="DD44EE55FF66AA77BB88CC99DD00EE11FF22AA33" />
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX firewall.dll" Hash="EE55FF66AA77BB88CC99DD00EE11FF22AA33BB44" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX firewall.dll" Hash="FF66AA77BB88CC99DD00EE11FF22AA33BB44CC55" />
  <Allow ID="ID_ALLOW_E_X_XXXX_X" FriendlyName="WiX firewall.dll" Hash="AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00" />
  <Allow ID="ID_ALLOW_E_X_XXXX_XXXX_X" FriendlyName="WiX firewall.dll" Hash="FF66AA77BB88CC99DD00EE11FF22AA33BB44CC55" />
</FileRules>
```

The policy creation tool or script should automatically populate `Signer ID` and `Allow ID` (such as `Signer ID="ID_SIGNER_S_XXXXX"`).

## PowerShell execution policy

The default PowerShell [execution policy](/powershell/module/microsoft.powershell.core/about/about_execution_policies) is sufficient for Windows Admin Center to manage a WDAC-enforced machine. Should the default policy be altered, set the `LocalMachine` scope to `RemoteSigned` to permit the loading and execution of signed scripts. Adjustments should be made only when essential and after careful consideration due to PowerShell’s security features.

## Known issues

- **Azure Kubernetes Service Deployment**: Currently, deploying Azure Kubernetes Service on Azure Local and Azure Arc resource bridge via Windows Admin Center isn't supported in WDAC-enforced environments.

- **Role-Based Access Control (RBAC)**: Utilizing role-based access control on a single server is presently unsupported when WDAC enforcement is in place.

- **Certificates Tool Operations**: Certain operations within the Certificates tool might be limited or unsupported under WDAC enforcement.

## Troubleshooting

If you get a "Module not found" or "failed to connect" error, perform one the following actions:

- **Verify module transfer**: To check whether Windows Admin Center successfully transferred files to your managed node, navigate to the `%PROGRAMFILES%\WindowsPowerShell\Modules` directory on the managed node. Confirm the presence of modules named `Microsoft.SME.*`. If these modules are absent, attempt to reconnect to your server or cluster through Windows Admin Center.

- **Port access verification**: Ensure that the machine hosting Windows Admin Center has access to TCP port 445 on the managed node. This port is essential for SMB communication, which Windows Admin Center relies on for file transfers and management tasks.

## Related content

- [WDAC design guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-design-guide)
- [WDAC deployment guide](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide)
- [AppLocker overview](/windows/security/threat-protection/windows-defender-application-control/applocker/applocker-overview)
- [Application control for Windows](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control)


---
title: Configure Network Policy Server Certificate Revocation List registry settings for Windows Server
description: This article provides information about configuring Certificate Revocation List registry settings for EAP-TLS authentication on a Network Policy Server in a Windows Server environment.
ms.topic: how-to
ms.assetid: 9624b301-d9f9-4d97-8651-39bf4bbae83e
ms.author: wscontent
author: marcussa
ms.date: 10/31/2023
ms.contributor: alalve
---

# Configure Network Policy Server Certificate Revocation List check registry settings

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

When using a Network Policy Server (NPS) to enforce certificate-based authentication for network access, it's important to configure Certificate Revocation Lists (CRLs) to ensure that only valid certificates are accepted. CRLs are used to check whether a digital certificate has been revoked by the Certificate Authority (CA) before its scheduled expiration date. In an NPS, CRLs can be configured to be checked during the authentication process to ensure that only valid certificates are used for network access. Configuring NPS CRLs is an important step in implementing a secure network access infrastructure.

## Prerequisites

The **Network Policy and Access Services** role is required to set up your device as an NPS server. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

## Understanding NPS CRL registry settings

The registry settings for the NPS can be configured in the following registry path and are entered as a **DWORD** entry with a value of **0** for **disabled**, or **1** for **enabled**:  

```registry
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13\
```

The following keys are set to **0** by default.

|Name|Description|
|-|-|
|IgnoreNoRevocationCheck | When **disabled**, an EAP-TLS client can't connect unless the server completes a revocation check of the certificate chain (including the root certificate) of the client and verifies that none of the certificates has been revoked. <br><br> When **enabled**, the NPS allows EAP-TLS clients to connect even when NPS doesn't perform or can't complete a revocation check of the certificate chain (excluding the root certificate) of the client. <br><br> You can use this entry to authenticate clients when the certificate doesn't include CRL distribution points, such as certificates issued by non-Microsoft CAs.  |
|IgnoreRevocationOffline | When **disabled**, the NPS doesn't allow clients to connect unless it can complete a revocation check of their certificate chain and verify that none of the certificates is revoked. When the NPS can't connect to a server that stores a revocation list, the certificate fails the revocation check and authentication fails. <br><br> When **enabled**, the NPS allows EAP-TLS clients to connect even when a server that stores a CRL isn't available on the network and prevents certificate validation failure due to poor network conditions. |
|NoRevocationCheck | When **disabled**, certificate revocation checking is enabled for the NPS CRL. When the client presents a certificate to the NPS server, the server checks to see if the certificate has been revoked by the issuing CA before allowing the client to connect to the network. If the certificate has been revoked, the client is denied access. <br><br> When **enabled**, the NPS prevents EAP-TLS from performing a revocation check of the certificate of the client. The revocation check verifies that the certificate of the client and the certificates in its certificate chain haven't been revoked. |
|NoRootRevocationCheck | When **disabled**, this entry only eliminates the revocation check of the root CA certificate of the client. A revocation check is still performed on the remainder of the certificate chain of the client. <br><br> When **enabled**, the NPS prevents EAP-TLS from performing a revocation check of the root CA certificate of the client. <br><br> This entry authenticates clients when the certificate doesn't include CRL distribution points. Also, this entry can prevent certification-related delays that occur when a certificate revocation list is offline or expired. |

## Editing NPS CRL registry settings

> [!WARNING]
> Incorrectly editing the registry can severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

Editing the registry can be performed using the registry editor (regedit.exe), the command prompt, or PowerShell. The following examples describe enabling the **NoRevocationCheck** registry setting and the same steps are applicable for enabling or disabling related CRL settings.

# [Registry Editor](#tab/registry-editor)

These steps allow you to enable **NoRevocationCheck** on your device:

1. On your desktop, select **Start**, type **Registry Editor**, right-click on **Registry Editor** and select **Run as administrator**.
1. In **Registry Editor**, navigate to **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13**.
1. In the top pane, select **Edit** > **New** > **DWORD** > type **NoRevocationCheck**, then press **Enter**.
1. Double-click on your new registry entry, change the value to **1**, then select **OK**.

To disable this entry, change the value from **1** to **0**.

# [Command Prompt](#tab/command-promt)

To enable **NoRevocationCheck** using the command prompt (CMD), run the following as admin:

```cmd
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13" /v "NoRevocationCheck" /t REG_DWORD /d 1 /f
```

To disable **NoRevocationCheck** using the command prompt (CMD), run the following as admin:

```cmd
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13" /v "NoRevocationCheck" /t REG_DWORD /d 0 /f
```

# [PowerShell](#tab/powershell)

To enable **NoRevocationCheck** using PowerShell, run the following as admin:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13" -Name "NoRevocationCheck" -Value 1
```

To disable **NoRevocationCheck** using PowerShell, run the following as admin:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13" -Name "NoRevocationCheck" -Value 0
```

---

To manually update the CRL on your NPS server, run these commands in the command prompt or PowerShell:

```
certutil -urlcache * delete
certutil -setreg chain\ChainCacheResyncFiletime @now
```

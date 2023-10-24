---
title: NPS Certificate Revocation List check registry settings for Windows Server
description: This article provides information about configuring Certificate Revocation List settings for EAP-TLS authentication on a Network Policy Server in a Windows Server environment.
ms.topic: article
ms.assetid: 
ms.author: wscontent
author: marcussa
ms.date: 10/24/2023
ms.contributor: alalve
---

# NPS CRL checks

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Certificate revocation checking can prevent client access due to the unavailability or expiration of certificate revocation lists (CRLs) for each certificate in the certificate chain, design your public key infrastructure (PKI) for high availability of CRLs in your Network Policy Server (NPS). For example, configure multiple CRL distribution points for each certification authority (CA) in the certificate hierarchy and configure publication schedules that ensure that the most current CRL is always available.

By default, the server running the NPS checks for certificate revocation for all of the certificates in the certificate chain sent by the client computer during the EAP-TLS and
PEAP-TLS authentication process. If certificate revocation fails for any of the certificates in the chain, the connection attempt isn't authenticated and is denied.

## NPS CRL registry settings

The registry settings for the NPS can be configured in the following registry path and are entered as a **DWORD** entry with a value of **0** for **disabled**, or **1** for **enabled**:  

```registry
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13\
```

The following keys are set to **0** by default.

|Name|Description|
|-|-|
|IgnoreNoRevocationCheck | When **disabled**, an EAP-TLS client can't connect unless the server completes a revocation check of the certificate chain (including the root certificate) of the client and verifies that none of the certificates has been revoked. <br><br> When **enabled**, the NPS allows EAP-TLS clients to connect even when NPS doesn't perform or can't complete a revocation check of the certificate chain (excluding the root certificate) of the client. <br><br> You can use this entry to authenticate clients when the certificate doesn't include CRL distribution points, such as certificates issued by non-Microsoft certification authorities (CAs).  |
|IgnoreRevocationOffline | When **disabled**, the NPS doesn't allow clients to connect unless it can complete a revocation check of their certificate chain and verify that none of the certificates is revoked. When the NPS can't connect to a server that stores a revocation list, the certificate fails the revocation check and authentication fails. <br><br> When **enabled**, the NPS allows EAP-TLS clients to connect even when a server that stores a CRL isn't available on the network and prevents certificate validation failure due to poor network conditions. |
|NoRevocationCheck | When **disabled**, certificate revocation checking is enabled for the NPS CRL. When the client presents a certificate to the NPS server, the server checks to see if the certificate has been revoked by the issuing CA before allowing the client to connect to the network. If the certificate has been revoked, the client is denied access. <br><br> When **enabled**, the NPS prevents EAP-TLS from performing a revocation check of the certificate of the client. The revocation check verifies that the certificate of the client and the certificates in its certificate chain haven't been revoked. |
|NoRootRevocationCheck | When **disabled**, this entry only eliminates the revocation check of the root CA certificate of the client. A revocation check is still performed on the remainder of the certificate chain of the client. <br><br> When **enabled**, the NPS prevents EAP-TLS from performing a revocation check of the root CA certificate of the client. <br><br> This entry authenticates clients when the certificate doesn't include CRL distribution points. Also, this entry can prevent certification-related delays that occur when a certificate revocation list is offline or expired. |

## Editing NPS CRL registry settings

> [!WARNING]
> Incorrectly editing the registry can severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

Editing the registry can be performed using the registry editor (regedit.exe), the command prompt, or PowerShell.

# [Registry Editor](#tab/registry-editor)

These steps allow you to enable **NoRevocationCheck** on your device:

1. On your desktop, select **Start**, type **Registry Editor**, right-click on **Registry Editor** and select **Run as administrator**.
1. In the **Registry Editor**, navigate to **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13**.
1. In the top pane, select **Edit** > **New** > **DWORD** > type **NoRevocationCheck**, then hit **Enter**.
1. Double-click on your new registry entry, change the value to **1**, then select **OK**.

To disable this entry, change the value from **1** to **0**.

# [Command Prompt](#tab/command-promt)

To enable **NoRevocationCheck** using the command prompt or Windows Terminal, run the following as admin:

```cmd
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13" /v "NoRevocationCheck" /t REG_DWORD /d 1 /f
```

To disable **NoRevocationCheck** using the command prompt or Windows Terminal, run the following as admin:

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

## See also

[Network Policy Server (NPS)](nps-top.md)

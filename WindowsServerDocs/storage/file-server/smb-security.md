---
title: SMB security enhancements
description: This topic explains the SMB security enhancements in Windows Server.
ms.topic: article
author: JasonGerend
ms.author: jgerend
ms.date: 07/26/2021
ms.prod: windows-server
ms.localizationpriority: medium
---
# SMB security enhancements

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains the SMB security enhancements in Windows Server.

## SMB Encryption

SMB Encryption provides end-to-end encryption of SMB data and protects data from eavesdropping occurrences on untrusted networks. You can deploy SMB Encryption with minimal effort, but it may require small additional costs for specialized hardware or software. It has no requirements for Internet Protocol security (IPsec) or WAN accelerators. SMB Encryption can be configured on a per share basis or for the entire file server, and it can be enabled for a variety of scenarios where data traverses untrusted networks.

>[!NOTE]
>SMB Encryption does not cover security at rest, which is typically handled by BitLocker Drive Encryption.

SMB Encryption should be considered for any scenario in which sensitive data needs to be protected from man-in-the-middle attacks. Possible scenarios include:

- An information worker's sensitive data is moved by using the SMB protocol. SMB Encryption offers an end-to-end privacy and integrity assurance between the file server and the client, regardless of the networks traversed, such as wide area network (WAN) connections that are maintained by non-Microsoft providers.
- SMB 3.0 enables file servers to provide continuously available storage for server applications, such as SQL Server or Hyper-V. Enabling SMB Encryption provides an opportunity to protect that information from snooping attacks. SMB Encryption is simpler to use than the dedicated hardware solutions that are required for most storage area networks (SANs).

Windows Server 2022 and Windows 11 introduce AES-256-GCM and AES-256-CCM cryptographic suites for SMB 3.1.1 encryption. Windows will automatically negotiate this more advanced cipher method when connecting to another computer that supports it, and can also be mandated through Group Policy. Windows still supports AES-128-GCM and AES-128-CCM. By default, AES-128-GCM is negotiated with SMB 3.1.1, bringing the best balance of security and performance.

Windows Server 2022 and Windows 11 SMB Direct now supports encryption. Previously, enabling SMB encryption disabled direct data placement, making RDMA performance as slow as TCP. Now data is encrypted before placement, leading to relatively minor performance degradation while adding AES-128 and AES-256 protected packet privacy. You can enable encryption using [Windows Admin Center](../../manage/windows-admin-center/overview.md), [Set-SmbServerConfiguration](/powershell/module/smbshare/set-smbserverconfiguration?view=windowsserver2022-ps&preserve-view=true), or [UNC Hardening group policy](https://support.microsoft.com/topic/ms15-011-vulnerability-in-group-policy-could-allow-remote-code-execution-february-10-2015-91b4bda2-945d-455b-ebbb-01d1ec191328). Furthermore, Windows Server failover clusters now support granular control of encrypting intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). This means that when using Storage Spaces Direct and SMB Direct, you can decide to encrypt east-west communications within the cluster itself for higher security.

>[!IMPORTANT]
>You should note that there is a notable performance operating cost with any end-to-end encryption protection when compared to non-encrypted.

## Enable SMB Encryption

You can enable SMB Encryption for the entire file server or only for specific file shares. Use one of the following procedures to enable SMB Encryption:

### Enable SMB Encryption with Windows Admin Center

1. Download and install [Windows Admin Center](../../manage/windows-admin-center/overview.md).
2. Connect to the file server.
3. Click **Files & file sharing**.
4. Click the **File shares** tab.
5. To require encryption on a share, click on the share name and select **Enable SMB encryption**.
6. To require encryption on the server, click the **File server settings* button, then under "SMB 3 encryption" select **Required from all clients (others are rejected)** and click **Save**.

### Enable SMB Encryption with UNC Hardening

UNC Hardening allows you to configure SMB clients to require encryption regardless of server encryption settings. This is useful to prevent interception attacks. To configure UNC Hardening, review [MS15-011: Vulnerability in Group Policy could allow remote code execution](https://support.microsoft.com/topic/ms15-011-vulnerability-in-group-policy-could-allow-remote-code-execution-february-10-2015-91b4bda2-945d-455b-ebbb-01d1ec191328). For more information on interception attack defenses, review [How to Defend Users from Interception Attacks via SMB Client Defense](https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-defend-users-from-interception-attacks-via-smb-client/ba-p/1494995).

### Enable SMB Encryption with Windows PowerShell

1. To enable SMB Encryption for an individual file share, type the following script on the server:

    ```PowerShell
    Set-SmbShare –Name <sharename> -EncryptData $true
    ```

2. To enable SMB Encryption for the entire file server, type the following script on the server:

    ```PowerShell
    Set-SmbServerConfiguration –EncryptData $true
    ```

3. To create a new SMB file share with SMB Encryption enabled, type the following script:

    ```PowerShell
    New-SmbShare –Name <sharename> -Path <pathname> –EncryptData $true
    ```

### Considerations for deploying SMB Encryption

By default, when SMB Encryption is enabled for a file share or server, only SMB 3.0, 3.02, and 3.1.1 clients are allowed to access the specified file shares. This enforces the administrator's intent of safeguarding the data for all clients that access the shares. However, in some circumstances, an administrator may want to allow unencrypted access for clients that do not support SMB 3.x (for example, during a transition period when mixed client operating system versions are being used). To allow unencrypted access for clients that do not support SMB 3.x, type the following script in Windows PowerShell:

```PowerShell
Set-SmbServerConfiguration –RejectUnencryptedAccess $false
```

>[!NOTE]
>
>- We do not recommend allowing unencrypted access when you have deployed encryption. Update the clients to support encryption instead.

The pre-authentication integrity capability described in the next section prevents an interception attack from downgrading a connection from SMB 3.1.1 to SMB 2.x (which would use unencrypted access). However, it does not prevent a downgrade to SMB 1.0, which would also result in unencrypted access. To guarantee that SMB 3.1.1 clients always use SMB Encryption to access encrypted shares, you must disable the SMB 1.0 server. For instructions, connect to the server with Windows Admin Center and open the **Files & File Sharing** extension then click the **File shares** tab to be prompted to uninstall or see [How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](../../storage/file-server/Troubleshoot/detect-enable-and-disable-smbv1-v2-v3.md). If the **–RejectUnencryptedAccess** setting is left at its default setting of **$true**, only encryption-capable SMB 3.x clients are allowed to access the file shares (SMB 1.0 clients will also be rejected).

>[!NOTE]
>
>- SMB Encryption uses the Advanced Encryption Standard (AES)-GCM and CCM algorithm to encrypt and decrypt the data. AES-CMAC and AES-GMAC also provide data integrity validation (signing) for encrypted file shares, regardless of the SMB signing settings. If you want to enable SMB signing without encryption, you can continue to do this. For more information, see [Configure SMB Signing with Confidence](https://aka.ms/smbsigning).
>- You may encounter issues when you attempt to access the file share or server if your organization uses wide area network (WAN) acceleration appliances.
>- With a default configuration (where there is no unencrypted access allowed to encrypted file shares), if clients that do not support SMB 3.x attempt to access an encrypted file share, Event ID 1003 is logged to the Microsoft-Windows-SmbServer/Operational event log, and the client will receive an **Access denied** error message.
>- SMB Encryption and the Encrypting File System (EFS) in the NTFS file system are unrelated, and SMB Encryption does not require or depend on using EFS.
>- SMB Encryption and the BitLocker Drive Encryption are unrelated, and SMB Encryption does not require or depend on using BitLocker Drive Encryption.

## Pre-authentication Integrity

SMB 3.1.1 is capable of detecting interception attacks that attempt to downgrade the protocol or the capabilities that the client and server negotiate by use of pre-authentication integrity. Pre-authentication integrity is a mandatory feature in SMB 3.1.1. It protects against any tampering with Negotiate and Session Setup messages by leveraging cryptographic hashing. The resulting hash is used as input to derive the session’s cryptographic keys, including its signing key. This enables the client and server to mutually trust the connection and session properties.When such an attack is detected by the client or the server, the connection is disconnected and event ID 1005 is logged in the Microsoft-Windows-SmbServer/Operational event log. Because of this, and to take advantage of the full capabilities of SMB Encryption, we strongly recommend that you disable the SMB 1.0 server. For instructions, connect to the server with Windows Admin Center and open the **Files & File Sharing** extension then click the **File shares** tab to be prompted to uninstall or see [How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](../../storage/file-server/Troubleshoot/detect-enable-and-disable-smbv1-v2-v3.md).

## New signing algorithm

SMB 3.0 and 3.02 use a more recent encryption algorithm for signing: Advanced Encryption Standard (AES)-cipher-based message authentication code (CMAC). SMB 2.0 used the older HMAC-SHA256 encryption algorithm. AES-CMAC and AES-CCM can significantly accelerate data encryption on most modern CPUs that have AES instruction support. For more information, see [Configure SMB Signing with Confidence](https://aka.ms/smbsigning).

Windows Server 2022 and Windows 11 introduce AES-256-GMAC and AES-256-CMAC for signing for SMB 3.1.1 signing. Windows will automatically negotiate this more advanced cipher method when connecting to another computer that supports it, and can also be mandated through Group Policy. Windows still supports AES-128-GCM and AES-128-CCM. By default, AES-128-GCM is negotiated with SMB 3.1.1, bringing the best balance of security and performance.

## Disabling SMB 1.0

SMB 1.0 is not installed by default starting in Windows Server version 1709 and Windows 10 version 1709. For instructions on removing SMB1, connect to the server with Windows Admin Center and open the **Files & File Sharing** extension then click the **File shares** tab to be prompted to uninstall or see [How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](../../storage/file-server/Troubleshoot/detect-enable-and-disable-smbv1-v2-v3.md) You should disable SMB1 immediately is still installed. For more information on detecting and disabling SMB 1.0 usage, review [Stop using SMB1](https://aka.ms/stopusingsmb1). For a clearinghouse of software that previously or current requires SMB 1.0, review [Still Needs SMB1](https://aka.ms/stillneedssmb1).

## More information

Here are some additional resources about SMB and related technologies in Windows Server 2012.

- [Server Message Block](file-server-smb-overview.md)
- [Storage in Windows Server](../storage.yml)
- [Scale-Out File Server for Application Data](../../failover-clustering/sofs-overview.md)

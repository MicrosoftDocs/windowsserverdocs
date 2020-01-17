---
title: SMB security enhancements
description: An explanation of the SMB Encryption feature in Windows Server 2012 R2, Windows Server 2012, and Windows Server 2016.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 07/09/2018
ms.localizationpriority: medium
---
# SMB security enhancements

>Applies to: Windows Server 2012 R2, Windows Server 2012, Windows Server 2016

This topic explains the SMB security enhancements in Windows Server 2012 R2, Windows Server 2012, and Windows Server 2016.

## SMB Encryption

SMB Encryption provides end-to-end encryption of SMB data and protects data from eavesdropping occurrences on untrusted networks. You can deploy SMB Encryption with minimal effort, but it may require small additional costs for specialized hardware or software. It has no requirements for Internet Protocol security (IPsec) or WAN accelerators. SMB Encryption can be configured on a per share basis or for the entire file server, and it can be enabled for a variety of scenarios where data traverses untrusted networks.

>[!NOTE]
>SMB Encryption does not cover security at rest, which is typically handled by BitLocker Drive Encryption.

SMB Encryption should be considered for any scenario in which sensitive data needs to be protected from man-in-the-middle attacks. Possible scenarios include:

- An information worker's sensitive data is moved by using the SMB protocol. SMB Encryption offers an end-to-end privacy and integrity assurance between the file server and the client, regardless of the networks traversed, such as wide area network (WAN) connections that are maintained by non-Microsoft providers.
- SMB 3.0 enables file servers to provide continuously available storage for server applications, such as SQL Server or Hyper-V. Enabling SMB Encryption provides an opportunity to protect that information from snooping attacks. SMB Encryption is simpler to use than the dedicated hardware solutions that are required for most storage area networks (SANs).

>[!IMPORTANT]
>You should note that there is a notable performance operating cost with any end-to-end encryption protection when compared to non-encrypted.

## Enable SMB Encryption

You can enable SMB Encryption for the entire file server or only for specific file shares. Use one of the following procedures to enable SMB Encryption:

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

### Enable SMB Encryption with Server Manager

1. In Server Manager, open **File and Storage Services**.
2. Select **Shares** to open the Shares management page.
3. Right-click the share on which you want to enable SMB Encryption, and then select **Properties**.
4. On the **Settings** page of the share, select **Encrypt data access**. Remote file access to this share is encrypted.

### Considerations for deploying SMB Encryption

By default, when SMB Encryption is enabled for a file share or server, only SMB 3.0 clients are allowed to access the specified file shares. This enforces the administrator's intent of safeguarding the data for all clients that access the shares. However, in some circumstances, an administrator may want to allow unencrypted access for clients that do not support SMB 3.0 (for example, during a transition period when mixed client operating system versions are being used). To allow unencrypted access for clients that do not support SMB 3.0, type the following script in Windows PowerShell:

```PowerShell
Set-SmbServerConfiguration –RejectUnencryptedAccess $false
```

The secure dialect negotiation capability described in the next section prevents a man-in-the-middle attack from downgrading a connection from SMB 3.0 to SMB 2.0 (which would use unencrypted access). However, it does not prevent a downgrade to SMB 1.0, which would also result in unencrypted access. To guarantee that SMB 3.0 clients always use SMB Encryption to access encrypted shares, you must disable the SMB 1.0 server. (For instructions, see the section [Disabling SMB 1.0](#disabling-smb-10).) If the **–RejectUnencryptedAccess** setting is left at its default setting of **$true**, only encryption-capable SMB 3.0 clients are allowed to access the file shares (SMB 1.0 clients will also be rejected).

>[!NOTE]
>* SMB Encryption uses the Advanced Encryption Standard (AES)-CCM algorithm to encrypt and decrypt the data. AES-CCM also provides data integrity validation (signing) for encrypted file shares, regardless of the SMB signing settings. If you want to enable SMB signing without encryption, you can continue to do this. For more information, see [The Basics of SMB Signing](https://blogs.technet.microsoft.com/josebda/2010/12/01/the-basics-of-smb-signing-covering-both-smb1-and-smb2/).
>* You may encounter issues when you attempt to access the file share or server if your organization uses wide area network (WAN) acceleration appliances.
>* With a default configuration (where there is no unencrypted access allowed to encrypted file shares), if clients that do not support SMB 3.0 attempt to access an encrypted file share, Event ID 1003 is logged to the Microsoft-Windows-SmbServer/Operational event log, and the client will receive an **Access denied** error message.
>* SMB Encryption and the Encrypting File System (EFS) in the NTFS file system are unrelated, and SMB Encryption does not require or depend on using EFS.
>* SMB Encryption and the BitLocker Drive Encryption are unrelated, and SMB Encryption does not require or depend on using BitLocker Drive Encryption.

## Secure dialect negotiation

SMB 3.0 is capable of detecting man-in-the-middle attacks that attempt to downgrade the SMB 2.0 or SMB 3.0 protocol or the capabilities that the client and server negotiate. When such an attack is detected by the client or the server, the connection is disconnected and event ID 1005 is logged in the Microsoft-Windows-SmbServer/Operational event log. Secure dialect negotiation cannot detect or prevent downgrades from SMB 2.0 or 3.0 to SMB 1.0. Because of this, and to take advantage of the full capabilities of SMB Encryption, we strongly recommend that you disable the SMB 1.0 server. For more information, see [Disabling SMB 1.0](#disabling-smb-10).

The secure dialect negotiation capability that is described in the next section prevents a man-in-the-middle attack from downgrading a connection from SMB 3 to SMB 2 (which would use unencrypted access); however, it does not prevent downgrades to SMB 1, which would also result in unencrypted access. For more information on potential issues with earlier non-Windows implementations of SMB, see the [Microsoft Knowledge Base](https://support.microsoft.com/kb/2686098).

## New signing algorithm

SMB 3.0 uses a more recent encryption algorithm for signing: Advanced Encryption Standard (AES)-cipher-based message authentication code (CMAC). SMB 2.0 used the older HMAC-SHA256 encryption algorithm. AES-CMAC and AES-CCM can significantly accelerate data encryption on most modern CPUs that have AES instruction support. For more information, see [The Basics of SMB Signing](https://blogs.technet.microsoft.com/josebda/2010/12/01/the-basics-of-smb-signing-covering-both-smb1-and-smb2/).

## Disabling SMB 1.0

The legacy computer browser service and Remote Administration Protocol features in SMB 1.0 are now separate, and they can be eliminated. These features are still enabled by default, but if you do not have older SMB clients, such as computers running Windows Server 2003 or Windows XP, you can remove the SMB 1.0 features to increase security and potentially reduce patching.

>[!NOTE]
>SMB 2.0 was introduced in Windows Server 2008 and Windows Vista. Older clients, such as computers running Windows Server 2003 or Windows XP, do not support SMB 2.0; and therefore, they will not be able to access file shares or print shares if the SMB 1.0 server is disabled. In addition, some non-Microsoft SMB clients may not be able to access SMB 2.0 file shares or print shares (for example, printers with “scan-to-share” functionality).

Before you start disabling SMB 1.0, you'll need to find out if your SMB clients are currently connected to the server running SMB 1.0. To do this, enter the following cmdlet in Windows PowerShell:

```PowerShell
Get-SmbSession | Select Dialect,ClientComputerName,ClientUserName | ? Dialect -lt 2
```

>[!NOTE]
>You should run this script repeatedly over the course of a week (multiple times each day) to build an audit trail. You could also run this as a scheduled task.

To disable SMB 1.0, enter the following script in Windows PowerShell:

```PowerShell
Set-SmbServerConfiguration –EnableSMB1Protocol $false
```

>[!NOTE]
>If an SMB client connection is denied because the server running SMB 1.0 has been disabled, event ID 1001 will be logged in the Microsoft-Windows-SmbServer/Operational event log.

## More information

Here are some additional resources about SMB and related technologies in Windows Server 2012.

- [Server Message Block](file-server-smb-overview.md)
- [Storage in Windows Server](../storage.md)
- [Scale-Out File Server for Application Data](../../failover-clustering/sofs-overview.md)
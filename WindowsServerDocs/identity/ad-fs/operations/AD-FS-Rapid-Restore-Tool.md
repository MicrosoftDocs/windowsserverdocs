---
title: Active Directory Federation Services Rapid Restore tool
description: "Learn about the Active Directory Federation Services (AD FS) Rapid Restore tool and restore AD FS data without a full backup or export an AD FS configuration."
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.custom: inhenkel
ms.assetid: 4deff06a-d0ef-4e5a-9701-5911ba667201
---

# Active Directory Federation Services Rapid Restore tool

Active Directory Federation Services (AD FS) is made highly available by setting up an AD FS farm. Some organizations prefer a single server AD FS deployment to eliminate the need for multiple AD FS servers and network load-balancing infrastructure. This approach helps to ensure quick restoration of service after resolving potential issues.

The AD FS Rapid Restore tool provides a way to restore AD FS data without requiring a full backup and restore of the operating system or system state. Use the tool to export an AD FS configuration to Azure or to an on-premises location. You can apply the exported data to a fresh AD FS installation and recreate or duplicate the AD FS environment.

## Use case scenarios

You can use the AD FS Rapid Restore tool in various scenarios:

- **Quickly restore AD FS functionality after issues**. Use the Rapid Restore tool to create a cold standby installation of AD FS that can be quickly deployed in place of the online AD FS server.

- **Deploy identical test and production environments**. Quickly create an accurate copy of the production AD FS in a test environment. You can also use the Rapid Restore tool to quickly deploy a validated test configuration to production.

- **Migrate SQL and Windows Integrated Database (WID) configurations**. Migrate your data with the Rapid Restore tool and move from a SQL-based farm configuration to WID or vice versa.

> [!NOTE]
> If you use SQL Merge Replication or Always on Availability Groups, the Rapid Restore tool isn't supported. We recommend SQL-based backups and a backup of the SSL certificate.

## Backup contents

The Rapid Restore tool backs up the following AD FS configuration:

- AD FS configuration database (SQL or WID)
- Configuration file (located in the AD FS folder)
- List of installed custom authentication providers, attribute stores, and local claims provider trusts
- Automatically generated token signing and decrypting certificates and private keys from the Active Directory Distributed Key Manager (DKM) container
- SSL certificate and any externally enrolled certificates (token signing, token decryption and service communication) and corresponding private keys

> [!NOTE]
> Private keys must be exportable. The user running the script must have permission to access the keys.

### Backup encryption

All backup data is encrypted before it's pushed to the cloud or stored in the file system.

Each document that's created as part of the backup is encrypted by using AES-256. The password provided to the Rapid Restore tool is used as a pass phrase to generate a new password via the `Rfc2898DeriveBytes` Class.

The `RngCryptoServiceProvider` Class generates the salt (binary blob) used by AES and the `Rfc2898DeriveBytes` Class.

## Get started

To get started with the AD FS Rapid Restore tool, first review the following system and tool requirements.

- The tool works for AD FS in Windows Server 2016 and later.
- The tool requires .NET framework 4.0 or later.
- If you use a WID, the tool must run on the primary AD FS server. Use the `Get-AdfsSyncProperties` cmdlet to check if your server is the primary server.
- A restore must run on an AD FS server of the same version as the backup server, and use the same Active Directory account as the AD FS service account.

Follow these steps to set up the tool:

1. [Download](https://go.microsoft.com/fwlink/?LinkId=825646) and install the MSI to your AD FS server.

1. After you install the tool, run the following command from a PowerShell prompt:

   ```powershell
   Import-Module 'C:\Program Files (x86)\ADFS Rapid Recreation Tool\ADFSRapidRecreationTool.dll'
   ```

## <a name="create-a-backup">Create backups: Backup-ADFS</a>

To create a backup, use the Backup-ADFS PowerShell cmdlet. The backup cmdlet backs up the AD FS configuration, database, SSL certificates, and so on.

Before you use the backup cmdlet, review the following access and permissions requirements. 

- **Run as local admin**. To run the backup cmdlet, the user must be at least a local admin.

- **Back up as domain admin**. To back up the Active Directory DKM container (which is required in the default AD FS configuration), the user privileges must satisfy one or more of the following criteria:

   - The user must be a domain admin.
   - The user must pass in the AD FS service account credentials.
   - The user must have access to the DKM container. 

- **Use gMSA account as domain admin**. For a Group Managed Service Account (gMSA), the user must be a domain admin or have permissions to the container. The user can't provide the gMSA credentials.

### Backup-ADFS cmdlet parameters

Each backup is named according to the pattern `adfsBackup_ID_Date-Time`. The name contains the version number, date, and time of the backup.

The following are the parameters for the Backup-ADFS cmdlet:

```powershell
Backup-ADFS 
  -StorageType {FileSystem | Azure} 
  -EncryptionPassword <string> 
  -AzureConnectionCredentials <pscredential> 
  -AzureStorageContainer <string> 
  [-BackupComment <string>] 
  [-ServiceAccountCredential <pscredential>]
  [-BackupDKM]
  [<CommonParameters>]
    
Backup-ADFS -StorageType {FileSystem | Azure} 
  -EncryptionPassword <string>
  -StoragePath <string> 
  [-BackupComment <string>]
  [-ServiceAccountCredential <pscredential>]
  [-BackupDKM]
  [<CommonParameters>]
```

The following list describes the parameter details for the Backup-ADFS cmdlet.

- `BackupDKM`: Backs up the Active Directory DKM container that contains the AD FS keys in the default configuration (automatically generated token signing and decrypting certificates). This approach uses the Microsoft Entra `ldifde` tool to export the Microsoft Entra container and all its subtrees.

- `StorageType <string>`: When the user performs the backup, they select the backup location:

   - **FileSystem** indicates the user wants to store the backup in a local folder or in the network. To store the backup in the file system, the user must satisfy the following requirements:

      - A storage path must be specified.
      
      In the path directory, a new directory is created for each backup. Each directory created contains the backed-up files.

   - **Azure** indicates the user wants to store the backup in the Azure Storage Container. To store the backup in the cloud, the user must satisfy the following requirements:
   
      - Azure Storage credentials should be passed to the cmdlet. The storage credentials contain the account name and key.
      - A container name must also be passed in. If the container doesn't exist, it's created during the backup.
   
- `EncryptionPassword <string>`: The password to use to encrypt all the backed-up files before they're stored.

- `AzureConnectionCredentials <pscredential>`: The account name and key for the Azure storage account.

- `AzureStorageContainer <string>`: The storage container for the backup in Azure.

- `StoragePath <string>`: The storage location for the backups.

- `ServiceAccountCredential <pscredential>`: The service account used for the current running AD FS Service. This parameter is needed only when the user wants to back up the DKM and they aren't a domain admin or can't access the container contents.

- `BackupComment <string[]>`: An informational string about the backup to display during the restore. This string is similar to the concept of Hyper-V checkpoint naming. The default is an empty string.

## Backup examples

The following PowerShell examples demonstrate backup options for an AD FS configuration with the AD FS Rapid Restore tool and the Backup-ADFS cmdlet.

### Back up to file system with DKM as domain admin

The following cmdlet backs up the AD FS configuration to the file system with the DKM by using the `-BackupDKM` parameter. This approach provides access to the DKM container contents as the domain admin or a user with delegated permissions.

```powershell
Backup-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -EncryptionPassword "password" -BackupComment "Clean Install of AD FS (FS)" -BackupDKM
```

### Back up to file system with DKM as local admin

The following cmdlet also backs up the AD FS configuration to the file system with the DKM, but uses a slightly different approach. In this option, you specify the service account credential by using the `-ServiceAccountCredential $cred` parameter, and run the operation as a local admin.

```powershell
Backup-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -EncryptionPassword "password" -BackupComment "Clean Install of AD FS (FS)" -BackupDKM -ServiceAccountCredential $cred
```

### Back up to Azure Storage container without DKM

The following cmdlet backs up the AD FS configuration to the Azure Storage container without using the DKM. Use the `-AzureStorageContainer "adfsbackups"` parameter to specify the container.

```powershell
Backup-ADFS -StorageType "Azure" -AzureConnectionCredentials $cred -AzureStorageContainer "adfsbackups"  -EncryptionPassword "password" -BackupComment "Clean Install of AD FS"
```

### Back up to file system without DKM 

The following cmdlet backs up the AD FS configuration to the file system without using the DKM. Notice the `-BackupDKM` parameter isn't specified.

```powershell
Backup-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -EncryptionPassword "password" -BackupComment "Clean Install of AD FS (FS)"
```

## Restore backups: Restore-ADFS

To apply a configuration created by using the Backup-ADFS cmdlet to a new AD FS installation, use the Restore-ADFS cmdlet. The restore cmdlet creates a new AD FS farm by using the `Install-AdfsFarm` cmdlet and restores the AD FS configuration, database, certificates, and so on.

The restore cmdlet checks the restore location for existing backups. The cmdlet prompts the user to choose an appropriate backup based on the date and time it was taken and any backup comment that the user might have attached to the backup. If there are multiple AD FS configurations with different federation service names, the user is first prompted to choose the appropriate AD FS configuration.

Before you use the restore cmdlet, review the following requirements. 

- If the AD FS role isn't installed on the server, the cmdlet installs the role. 
- The user has to be both a local and domain admin to run this cmdlet.

> [!IMPORTANT]
> Before you use the AD FS Rapid Restore tool to restore a backup, make sure the server is joined to the domain.

### Restore-ADFS cmdlet parameters

The following are the parameters for the Restore-ADFS cmdlet:

```powershell
Restore-ADFS 
  -StorageType {FileSystem | Azure} 
  -DecryptionPassword <string> 
  -AzureConnectionCredentials <pscredential>
  -AzureStorageContainer <string>
  [-ADFSName <string>]
  [-ServiceAccountCredential <pscredential>]
  [-GroupServiceAccountIdentifier <string>]
  [-DBConnectionString <string>]
  [-Force]
  [-RestoreDKM]  
  [<CommonParameters>]
    
Restore-ADFS 
  -StorageType {FileSystem | Azure} 
  -DecryptionPassword <string>
  -StoragePath <string>
  [-ADFSName <string>]
  [-ServiceAccountCredential <pscredential>]
  [-GroupServiceAccountIdentifier <string>]
  [-DBConnectionString <string>]
  [-Force]
  [-RestoreDKM]
  [<CommonParameters>]
```

The following list describes the parameter details for the Restore-ADFS cmdlet.

- `StorageType <string>`: The type of storage to use:

   - **FileSystem** stores the backup in a local folder or in the network.
   - **Azure** stores the backup in the Azure Storage Container.

- `DecryptionPassword <string>`: The password used to encrypt all the backed-up files.

- `AzureConnectionCredentials <pscredential>`: The account name and key for the Azure storage account.

- `AzureStorageContainer <string>`: The storage container to store the backup in Azure.

- `StoragePath <string>`: The storage location for the backup.

- `ADFSName <string>`: The name of the federation that was backed up and to now restore.

   - When a name isn't specified and only one federation service name exists, then that federation service name is used.
   - If more than one federation service is backed up to the location, the user is prompted to choose a backed-up federation service.

- `ServiceAccountCredential <pscredential>`: Specifies the service account to use for the new AD FS Service that's being restored.

- `GroupServiceAccountIdentifier <string>`: The gMSA that the user wants to use for the new AD FS Service that's being restored.

   - By default, if a value isn't provided, the backed-up account name is used, if the account is gMSA.
   - If a value isn't provided, and the account isn't gMSA, the user is prompted to specify a service account.

- `DBConnectionString <string>`: To use a different database for the restore, specify the SQL Connection String or enter "WID."

- `Force <bool>`: Skip any prompts from the tool after you select the backup process.

- `RestoreDKM <bool>`: Restore the DKM Container to the Active Directory. Set this option when restoring to a new Active Directory and the DKM was backed up initially.

## Restore examples

The following PowerShell examples demonstrate restore options for an AD FS configuration with the AD FS Rapid Restore tool and the Restore-ADFS cmdlet.

### Restore to file system with DKM as domain admin

The following cmdlet restores the AD FS configuration to the file system with the DKM by using the `-RestoreDKM` parameter.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password" -RestoreDKM
```

### Restore to file system without DKM 

The following cmdlet restores the AD FS configuration to the file system without using the DKM. Notice the `-RestoreDKM` parameter isn't specified.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password"
```

### Restore to Azure Storage container without DKM

The following cmdlet restores the AD FS configuration to the Azure Storage container without using the DKM. Use the `-AzureStorageContainer "adfsbackups"` parameter to specify the container.

```powershell
Restore-ADFS -StorageType "Azure" -AzureConnectionCredential $cred -DecryptionPassword "password" -AzureStorageContainer "adfsbackups"
```

### Restore to WID

The following cmdlet restores the AD FS configuration to WID. Notice the `WID` value passed to the `-DBConnectionString` parameter.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password" -DBConnectionString "WID"
```

### Restore to SQL

The following cmdlet restores the AD FS configuration to SQL. Notice the `Data Source` and `Integrated Security` values passed to the `-DBConnectionString` parameter.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password" -DBConnectionString "Data Source=TESTMACHINE\SQLEXPRESS; Integrated Security=True"
```

### Restores with specified gMSA account

The following cmdlet restores the AD FS configuration and uses a specified gMSA account. Notice the use of the `-GroupServiceAccountIdentifier` parameter.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password" -GroupServiceAccountIdentifier "mangupd1\adfsgmsa$"
```

### Restore with specified service account credentials

The following cmdlet restores the AD FS configuration and uses the specified service account credentials. Notice the use of the `-ServiceAccountCredential` parameter.

```powershell
Restore-ADFS -StorageType "FileSystem" -StoragePath "C:\Users\administrator\testExport\" -DecryptionPassword "password" -ServiceAccountCredential $cred
```

## Log files

A log file is created for every backup and restore operation. The log files can be found at **%LOCALAPPDATA%\ADFSRapidRecreationTool**.

> [!NOTE]
> When you do a restore, a **PostRestore_Instructions** file might be created. This file contains an overview of the additional data or services that must be installed manually before you start the AD FS service. The file specifies authentication providers, attribute stores, and local claims provider trusts.

## Version release history

The following sections identify version details for the AD FS Rapid Restore tool.

### Version 1.0.82.3

Release: April 2020

**Fixed issues:**

- Add support for CNG based certificates

### Version 1.0.82.0

Release: July 2019

**Fixed issues:**

- Bug fix for AD FS service account names that contain LDAP escape characters

### Version 1.0.81.0

Release: April 2019

**Fixed issues:**

- Bug fixes for certificate backup and restore
- Add more trace information to the log file

### Version 1.0.75.0

Release: August 2018

**Fixed issues:**

- Update the Backup-ADFS cmdlet for the -BackupDKM switch. The tool determines if the current context has access to the DKM container. When access is available, the tool doesn't require Domain Admin privileges or service account credentials. This update enables automated backups that don't the user to explicitly provide credentials or run the operation as a Domain Administrator account.

### Version 1.0.73.0

Release: August 2018

**Fixed issues:**

- Update the encryption algorithms to ensure application is FIPS compliant

    > [!IMPORTANT]
    > Previous backups won't work with the latest version of the tool, due to changes in encryption algorithms for FIPS compliance.

- Add support for SQL clusters that use merge replication

### Version 1.0.72.0

Release: July 2018

**Fixed issues:**

- Bug fix: Fix .MSI installer to support in-place upgrades

### Version 1.0.18.0

Release: July 2018

**Fixed issues:**

- Bug fix: Handle service account passwords with special characters (that is, '&')
- Bug fix: Resolve issues relation to restoration failure because Microsoft.IdentityServer.Servicehost.exe.config is in use by another process

### Version 1.0.0.0

Release: October 2016

**Initial release** of AD FS Rapid Restore Tool

---
title: cipher
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 78ef795e-0f87-4acd-8d15-192c972c0f41
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# cipher



Displays or alters the encryption of directories and files on NTFS volumes. If used without parameters, **cipher** displays the encryption state of the current directory and any files it contains.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
cipher [/e | /d | /c] [/s:<Directory>] [/b] [/h] [PathName [...]]
cipher /k
cipher /r:<FileName> [/smartcard]
cipher /u [/n]
cipher /w:<Directory>
cipher /x[:efsfile] [FileName]
cipher /y
cipher /adduser [/certhash:<Hash> | /certfile:<FileName>] [/s:Directory] [/b] [/h] [PathName [...]]
cipher /removeuser /certhash:<Hash> [/s:<Directory>] [/b] [/h] [<PathName> [...]]
cipher /rekey [PathName [...]]
```

## Parameters

|          Parameters           |                                                                                                                                                   Description                                                                                                                                                    |
|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|              /b               |                                                                                                    Aborts if an error is encountered. By default, **cipher** continues to run even if errors are encountered.                                                                                                    |
|              /c               |                                                                                                                                   Displays information on the encrypted file.                                                                                                                                    |
|              /d               |                                                                                                                                   Decrypts the specified files or directories.                                                                                                                                   |
|              /e               |                                                                                          Encrypts the specified files or directories. Directories are marked so that files that are added afterward will be encrypted.                                                                                           |
|              /h               |                                                                                                     Displays files with hidden or system attributes. By default, these files are not encrypted or decrypted.                                                                                                     |
|              /k               |                                                                            Creates a new certificate and key for use with Encrypting File System (EFS) files. If the **/k** parameter is specified, all other parameters are ignored.                                                                            |
|  /r:\<FileName> [/smartcard]  |   Generates an EFS recovery agent key and certificate, then writes them to a .pfx file (containing certificate and private key) and  a .cer file (containing only the certificate). If **/smartcard** is specified, it writes the recovery key and certificate to a smart card, and no .pfx file is generated.   |
|        /s:\<Directory>        |                                                                                                               Performs the specified operation on all subdirectories in the specified *Directory*.                                                                                                               |
|            /u [/n]            |  Finds all encrypted files on the local drive(s). If used with the **/n** parameter, no updates are made. If used without **/n**, **/u** compares the user's file encryption key or the recovery agent's key to the current ones, and updates them if they have changed. This parameter works only with **/n**.  |
|        /w:\<Directory>        | Removes data from available unused disk space on the entire volume. If you use the **/w** parameter, all other parameters are ignored. The directory specified can be located anywhere in a local volume. If it is a mount point or points to a directory in another volume, the data on that volume is removed. |
|  /x[:efsfile] [\<FileName>]   |                                 Backs up the EFS certificate and keys to the specified file name. If used with **:efsfile**, **/x** backs up the user's certificate(s) that were used to encrypt the file. Otherwise, the user's current EFS certificate and keys are backed up.                                 |
|              /y               |                                                                                                                      Displays your current EFS certificate thumbnail on the local computer.                                                                                                                      |
|  /adduser [/certhash:\<Hash>  |                                                                                                                                              /certfile:<FileName>]                                                                                                                                               |
|            /rekey             |                                                                                                                 Updates the specified encrypted file(s) to use the currently configured EFS key.                                                                                                                 |
| /removeuser /certhash:\<Hash> |                                                                                       Removes a user from the specified file(s). The *Hash* provided for **/certhash** must be the SHA1 hash of the certificate to remove.                                                                                       |
|              /?               |                                                                                                                                       Displays help at the command prompt.                                                                                                                                       |

## Remarks

-   If the parent directory is not encrypted, an encrypted file could become decrypted when it is modified. Therefore, when you encrypt a file, you should also encrypt the parent directory.
-   An administrator can add the contents of a .cer file to the EFS recovery policy to create the recovery agent for users, and then import the .pfx file to recover individual files.
-   You can use multiple directory names and wildcards.
-   You must put spaces between multiple parameters.

## <a name="BKMK_examples"></a>Examples

To display the encryption status of each of the files and subdirectories in the current directory, type:
```
cipher
```
Encrypted files and directories are marked with an **E**. Unencrypted files and directories are marked with a **U**. For example, the following output indicates that the current directory and all its contents are currently unencrypted:
```
Listing C:\Users\MainUser\Documents\
New files added to this directory will not be encrypted.
U Private
U hello.doc
U hello.txt
```
To enable encryption on the Private directory used in the previous example, type:
```
cipher /e private
```
The following output displays:
```
Encrypting files in C:\Users\MainUser\Documents\
Private             [OK]
1 file(s) [or directorie(s)] within 1 directorie(s) were encrypted.
```
The **cipher** command displays the following output:
```
Listing C:\Users\MainUser\Documents\
New files added to this directory will not be encrypted.
E Private
U hello.doc
U hello.txt
```
Note that the Private directory is marked as encrypted.

#### Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)
---
title: System key utility technical overview
description: Describes the system key utility (Syskey), which protects the Security Accounts Manager (SAM) database in Windows operating systems.
ms.topic: article
ms.assetid: 398fcb59-906c-4cbc-8a7d-a9750632477a
ms.author: jgerend
author: JasonGerend
manager: 
ms.date: 3/17/2021
---
# System key utility technical overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows 8.1, Windows Server 2012, Windows Server 2012 R2

This topic for the IT professional describes the system key utility (Syskey), which protects the Security Accounts Manager (SAM) database in Windows operating systems.

> [!NOTE]
> Syskey utility is no longer supported in Windows 10, version 1607, Windows Server 2016, and later versions.

## What is the system key utility?

Password information for user accounts is stored in the SAM database of the registry on workstations and member servers. On domain controllers, password information is stored in directory services. It is not unusual for password-cracking software to target the SAM database or directory services to access passwords for user accounts. The system key utility (Syskey) provides an extra line of defense against password-cracking software. It uses strong encryption techniques to secure account password information that is stored in the SAM database or in directory services. Cracking encrypted account passwords is more difficult and time consuming than cracking nonencrypted account passwords.

There are three system key options in the **Startup Key** dialog box that are designed to meet the needs of different environments, as described in the following table.

|System key option|Relative security level|Description|
|---|---|---|
|System Generated Password, Store Startup Key Locally|+|Uses a computer-generated random key as the system key and stores an encrypted version of the key on the local computer. This option provides strong encryption of password information in the registry, and it enables the user to restart the computer without the need for an administrator to enter a password or insert a disk|
|Administrator generated password, Password Startup|++|Uses a computer-generated random key as the system key and stores an encrypted version of the key on the local computer. The key is also protected by an administrator-chosen password. Users are prompted for the system key password when the computer is in the initial startup sequence. The system key password is not stored anywhere on the computer.|
|System Generated Password, Store Startup Key on Floppy Disk|+++|Uses a computer-generated random key and stores the key on a floppy disk. The floppy disk that contains the system key is required for the system to start, and it must be inserted at a prompt during the startup sequence. The system key is not stored anywhere on the computer.|

Use of the system key utility is optional. If the disk that contains the system key is lost, or if the password is forgotten, you cannot start the computer without restoring the registry to the state it was in before the system key was used.

## How the system key utility works

Each time a new user is added to a computer, the Windows Data Protection API (DPAPI) generates a master key that is used to protect all other private keys used by applications and services running in that user's context, such as Encrypting File System (EFS) keys and S/MIME keys. The computer also has its own master key that protects system keys such as IPsec keys, computer keys, and SSL keys. All these master keys are then protected by a computer's startup key. When you start a computer, the startup key decrypts the master keys. The startup key also protects the local SAM database on each computer, the computer's Local Security Authority (LSA) secrets, account information stored in Active Directory Domain Services (AD DS) on domain controllers, and the administrator account password used for system recovery in Safe Mode.

The Syskey utility lets you choose where that startup key is stored. By default, the computer generates a random key and scatters it throughout the registry; a complex obfuscation algorithm ensures that the scatter pattern is different on every Windows installation. You can change this to one of two other Syskey modes: you can continue to use a computer-generated key but store it on a floppy disk, or you can have the system prompt during startup for a password that is used to derive the master key. You can always change between the three options, but if you have enabled either **System Generated Password, Store Startup Key on Floppy Disk** or **Administrator generated password, Password Startup** and you have lost your floppy disk or forgotten your password, your only recovery option is to use a repair disk to restore the registry to the state it was in before you enabled the Syskey mode. You will lose any other changes made between then and now. To change your startup key, open a command prompt, and type *syskey* to run the Syskey utility.

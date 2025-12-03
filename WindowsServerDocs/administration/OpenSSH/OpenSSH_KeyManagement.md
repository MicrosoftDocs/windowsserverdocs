---
title: Key-Based Authentication in OpenSSH for Windows
description: Find out about OpenSSH Server key-based authentication, generation, and deployment for Windows. See how to use built-in Windows tools or PowerShell to manage keys.
ms.date: 10/03/2025
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
# customer intent: As an administrator, I want to become familiar with OpenSSH Server key-based authentication so that I can improve the security of cross-domain work.
---

# Key-based authentication in OpenSSH for Windows

Most authentication in Windows environments is done with a username/password pair, which works well for systems that share a common domain. When you work across domains, such as between on-premises and cloud-hosted systems, this type of authentication becomes vulnerable to brute force intrusions.

By comparison, Linux environments commonly use public/private key pairs to drive authentication that doesn't require the use of guessable passwords. OpenSSH includes tools to help support key-based authentication, specifically:

* __ssh-keygen__ for generating secure keys.
* __ssh-agent__ and __ssh-add__ for securely storing private keys.
* __scp__ and __sftp__ to securely copy public key files during initial use of a server.

This document provides an overview of how to use these tools on Windows to begin using key-based authentication with Secure Shell (SSH). If you're not familiar with SSH key management, we strongly recommend that you review [NIST document IR 7966](http://nvlpubs.nist.gov/nistpubs/ir/2015/NIST.IR.7966.pdf), titled _Security of Interactive and Automated Access Management Using Secure Shell (SSH)_.

Key-based authentication in OpenSSH for Windows works with local Windows accounts and Active Directory (domain) accounts. Microsoft Entra ID accounts don't support key-based authentication.

> [!NOTE]
> Windows OpenSSH doesn't support the `AuthorizedKeysCommand` and `AuthorizedKeysCommandUser` directives. Meaning you can't dynamically fetch SSH keys from Active Directory using these directives as you might on Linux system. For more information about the supported configuration options, see [OpenSSH Server configuration for Windows Server and Windows](openssh-server-configuration.md).

## Key pairs

Key pairs refer to the public and private key files that are used by certain authentication protocols.

SSH public key authentication uses asymmetric cryptographic algorithms to generate two key files—one _private_ and the other _public_. Each private key file is the equivalent of a password and should stay protected under all circumstances. If someone acquires your private key, they can sign in as you to any SSH server you have access to. The public key is what is placed on the SSH server and can be shared without compromising the private key.

The SSH server and client can use key-based authentication to compare the public key for a user name provided against the private key. If the server-side public key can't be validated against the client-side private key, authentication fails.

You can implement multifactor authentication with key pairs by entering a passphrase when you generate the key pair. For more information, see [User key generation](#user-key-generation). The user is prompted for the passphrase during authentication. The passphrase combined with the presence of the private key is used on the SSH client to authenticate the user.

> [!IMPORTANT]
> A remote session opened via key-based authentication doesn't have associated user credentials. As a result, the session isn't capable of outbound authentication as the user. This behavior is by design.

## Host key generation

Public keys have specific access control list (ACL) requirements that, on Windows, equate to only allowing access to administrators and the System user. The first time the `sshd` service is used, the key pair for the host is automatically generated.

> [!IMPORTANT]
> You need to install OpenSSH Server before you can run the commands in this article. For more information, see [Get started with OpenSSH for Windows](OpenSSH_Install_FirstUse.md).

By default, you need to start `sshd` manually. To configure it to start automatically each time the server is restarted, run the following commands from an elevated PowerShell prompt on your server:

```powershell
# Set the sshd service to be started automatically.
Get-Service -Name sshd | Set-Service -StartupType Automatic

# Start the sshd service.
Start-Service sshd
```

Because there's no user associated with the `sshd` service, the host keys are stored under _C:\ProgramData\ssh_.

## User key generation

To use key-based authentication, you first need to generate public/private key pairs for your client. You can use `ssh-keygen.exe` to generate key files. You can specify the following key-generation algorithms:

* Digital Signature Algorithm (DSA)
* Rivest–Shamir–Adleman (RSA)
* Elliptic Curve Digital Signature Algorithm (ECDSA)
* Ed25519

If you don't specify an algorithm, Ed25519 is used. A strong algorithm and key length should be used, such as ECDSA in this example.

To generate key files by using the ECDSA algorithm, run the following command in a PowerShell or Command Prompt window on your client:

```powershell
ssh-keygen -t ecdsa
```

The output from the command should look like the following lines, except that `username` is replaced with your username:

```Output
Generating public/private ecdsa key pair.
Enter file in which to save the key (C:\Users\username/.ssh/id_ecdsa):
```

At the prompt, you can select __Enter__ to accept the default file path, or you can specify a path or file name for your generated keys.

Next, you're prompted to use a passphrase to encrypt your private key files. In general, we don't recommend using an empty passphrase, because the passphrase works with the key file to provide two-factor authentication. But for this example, you can leave the passphrase empty.

```Output
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\username/.ssh/id_ecdsa.
Your public key has been saved in C:\Users\username/.ssh/id_ecdsa.pub.
The key fingerprint is:
SHA256:OIzc1yE7joL2Bzy8!gS0j8eGK7bYaH1FmF3sDuMeSj8 username@LOCAL-HOSTNAME

The key's randomart image is:
+--[ECDSA 256]--+
|        .        |
|         o       |
|    . + + .      |
|   o B * = .     |
|   o= B S .      |
|   .=B O o       |
|  + =+% o        |
| *oo.O.E         |
|+.o+=o. .        |
+----[SHA256]-----+
```

Now you have a public/private ECDSA key pair in the specified location. The .pub file is the public key, and the file without an extension is the private key:

```Output
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/3/2021   2:55 PM            464 id_ecdsa
-a----         6/3/2021   2:55 PM            103 id_ecdsa.pub
```

A private key file is the equivalent of a password and should be protected the same way you protect your password.
You can use `ssh-agent` to securely store your private keys within a Windows security context that's associated with your Windows account. To configure the `ssh-agent` service to start automatically each time your computer is restarted, and to use `ssh-add` to store the private key, run the following commands at an elevated PowerShell prompt on your server:

```powershell
# By default, the ssh-agent service is disabled. Configure it to start automatically.
# Run the following command as an administrator.
Get-Service ssh-agent | Set-Service -StartupType Automatic

# Start the service.
Start-Service ssh-agent

# The following command should return a status of Running.
Get-Service ssh-agent

# Load your key files into ssh-agent.
ssh-add $env:USERPROFILE\.ssh\id_ecdsa
```

After you add the key to the `ssh-agent` service on your client, the `ssh-agent` service automatically retrieves the local private key and passes it to your SSH client.

> [!IMPORTANT]
> We recommend that you back up your private key to a secure location and then delete it
> from the local system _after_ you add it to the `ssh-agent` service. The private key can't be retrieved from
> the agent when a strong algorithm, such as ECDSA in this example, is used. If you lose
> access to the private key, you have to create a new key pair and update the public key on all
> systems you interact with.

## Deploy the public key

To use the user key that you created previously, you need to place the contents of your public key (_\\.ssh\id\_ecdsa.pub_) on the server into a text file. The name and location of the file depend on whether the user account is a member of the local administrator group or a standard user account. The following sections cover both standard and administrative users.

### Standard user

You need to place the contents of your public key (_\\.ssh\id\_ecdsa.pub_) on the server into a text file called `authorized_keys` in _C:\Users\username\\.ssh\\_. You can copy your public key by using the OpenSSH `scp` secure file-transfer utility, or by using PowerShell to write the key to the file.

You can use the following code to copy the public key to the server. In the last line, replace `username` with your username. Initially, you're prompted to enter a password for the user account for the server.

```powershell
# Get the public key file generated previously on your client.
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\id_ecdsa.pub

# Generate the PowerShell command to run remotely that copies the public key file generated previously on your client to the authorized_keys file on your server.
$remotePowershell = "powershell New-Item -Force -ItemType Directory -Path $env:USERPROFILE\.ssh; Add-Content -Force -Path $env:USERPROFILE\.ssh\authorized_keys -Value '$authorizedKey'"

# Connect to your server and run the PowerShell command by using the $remotePowerShell variable.
ssh username@domain1@contoso.com $remotePowershell
```

### Administrative user

You need to place the contents of your public key (_\\.ssh\id\_ecdsa.pub_) on the server into a text file called `administrators_authorized_keys` in _C:\ProgramData\ssh\\_. You can copy your public key by using the OpenSSH `scp` secure file-transfer utility, or by using PowerShell to write the key to the file. The ACL on this file needs to be configured to only allow access to administrators and the System user.

You can use the following code to copy the public key to the server and configure the ACL. In the last line, replace `username` with your username. Initially, you're prompted to enter a password for the user account for the server.

> [!NOTE]
> This example shows the steps for creating the `administrators_authorized_keys` file. This file only applies to administrator accounts. You must use it instead of the user-specific file within the user's profile location.

```powershell
# Get the public key file generated previously on your client.
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\id_ecdsa.pub

# Generate the PowerShell command to run remotely that copies the public key file generated previously on your client to the authorized_keys file on your server.
$remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '''$authorizedKey''';icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""

# Connect to your server and run the PowerShell command by using the $remotePowerShell variable.
ssh username@domain1@contoso.com $remotePowershell
```

For non-English localized versions of the operating system, the script needs to be modified to reflect group names accordingly. To prevent errors that can occur when you grant permissions to group names, you can use the security identifier (SID) in place of the group name. You can retrieve the SID by running `Get-LocalGroup | Select-Object Name, SID`. When you use the SID in place of the group name, it must be preceded by an asterisk (__\*__). In the following example, the __Administrators__ group uses the SID `S-1-5-32-544`:

```powershell
$remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '''$authorizedKey''';icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""*S-1-5-32-544:F"" /grant ""SYSTEM:F"""
```

These steps complete the configuration required to use key-based authentication with OpenSSH on Windows.
After you run these PowerShell commands, you can connect to the `sshd` host from any client that has the private key.

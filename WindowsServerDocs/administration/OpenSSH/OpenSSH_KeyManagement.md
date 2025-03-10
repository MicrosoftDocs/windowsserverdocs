---
title: Key-based authentication in OpenSSH for Windows
description: Learn about OpenSSH Server key-based authentication, generation, and deployment for Windows using built-in Windows tools or PowerShell.
ms.date: 02/14/2025
ms.topic: conceptual
ms.author: roharwoo
author: maertendmsft
---

# Key-based authentication in OpenSSH for Windows

Most authentication in Windows environments is done with a username-password pair, which works well for systems that share a common domain. When you work across domains, such as between on-premises and cloud-hosted systems, it becomes vulnerable to brute force intrusions.

By comparison, Linux environments commonly use public-key/private-key pairs to drive authentication that doesn't require the use of guessable passwords. OpenSSH includes tools to help support key based authentication, specifically:

* __ssh-keygen__ for generating secure keys
* __ssh-agent__ and __ssh-add__ for securely storing private keys
* __scp__ and __sftp__ to securely copy public key files during initial use of a server

This document provides an overview of how to use these tools on Windows to begin using key-based authentication with SSH.
If you're unfamiliar with SSH key management, we strongly recommend you review [NIST document IR 7966](http://nvlpubs.nist.gov/nistpubs/ir/2015/NIST.IR.7966.pdf) titled _Security of Interactive and Automated Access Management Using Secure Shell (SSH)_.

## About key pairs

Key pairs refer to the public and private key files that are used by certain authentication protocols.

SSH public key authentication uses asymmetric cryptographic algorithms to generate two key files – one "private" and the other "public". The private key files are the equivalent of a password, and should stay protected under all circumstances. If someone acquires your private key, they can sign in as you to any SSH server you have access to. The public key is what is placed on the SSH server, and might be shared without compromising the private key.

Key based authentication enables the SSH server and client to compare the public key for a user name provided against the private key. If the server-side public key can't be validated against the client-side private key, authentication fails.

Multifactor authentication might be implemented with key pairs by entering a passphrase when the key pair is generated. To learn more, see [user key generation](#user-key-generation). The user is prompted for the passphrase during authentication. The passphrase combined with the presence of the private key is used on the SSH client to authenticate the user.

> [!IMPORTANT]
> A remote session opened via key based authentication doesn't have associated user credentials and
> hence isn't capable of outbound authentication as the user, this is by design.

## Host key generation

Public keys have specific ACL requirements that, on Windows, equate to only allowing access to administrators and System. On first use of sshd, the key pair for the host is automatically generated.

> [!IMPORTANT]
> You need to have OpenSSH Server installed first. To learn more, see [Getting started with OpenSSH](OpenSSH_Install_FirstUse.md).

By default the sshd service is set to start manually. To start it each time the server is rebooted, run the following commands from an elevated PowerShell prompt on your server:

```powershell
# Set the sshd service to be started automatically
Get-Service -Name sshd | Set-Service -StartupType Automatic

# Now start the sshd service
Start-Service sshd
```

Since there's no user associated with the sshd service, the host keys are stored under C:\ProgramData\ssh.

## User key generation

To use key-based authentication, you first need to generate public/private key pairs for your client. ssh-keygen.exe is used to generate key files and the algorithms DSA, RSA, ECDSA, or Ed25519 can be specified. If no algorithm is specified, Ed25519 is used. A strong algorithm and key length should be used, such as ECDSA in this example.

To generate key files using the ECDSA algorithm, run the following command from a PowerShell or cmd prompt on your client:

```powershell
ssh-keygen -t ecdsa
```

The output from the command should display the following output, replacing "username" with your username:

```Output
Generating public/private ecdsa key pair.
Enter file in which to save the key (C:\Users\username/.ssh/id_ecdsa):
```

You can press Enter to accept the default, or specify a path and/or filename where you would like your keys to be generated.
At this point, you're prompted to use a passphrase to encrypt your private key files. It's not recommended to use an empty passphrase.
The passphrase works with the key file to provide two-factor authentication. For this example, we're leaving the passphrase empty.

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

Now you have a public/private ECDSA key pair in the location specified. The .pub files are public keys, and files without an extension are private keys:

```Output
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/3/2021   2:55 PM            464 id_ecdsa
-a----         6/3/2021   2:55 PM            103 id_ecdsa.pub
```

Remember that private key files are the equivalent of a password should be protected the same way you protect your password.
Use ssh-agent to securely store the private keys within a Windows security context, associated with your Windows account. To start the ssh-agent service each time your computer is rebooted, and use ssh-add to store the private key run the following commands from an elevated PowerShell prompt on your server:

```powershell
# By default the ssh-agent service is disabled. Configure it to start automatically.
# Make sure you're running as an Administrator.
Get-Service ssh-agent | Set-Service -StartupType Automatic

# Start the service
Start-Service ssh-agent

# This should return a status of Running
Get-Service ssh-agent

# Now load your key files into ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ecdsa
```

Once you add the key to the ssh-agent on your client, the ssh-agent automatically retrieves the local private key and pass it to your SSH client.

> [!IMPORTANT]
> It's recommended that you back up your private key to a secure location, then delete it
> from the local system, _after_ adding it to ssh-agent. The private key can't be retrieved from
> the agent providing a strong algorithm is used, such as ECDSA in this example. If you lose
> access to the private key, you have to create a new key pair and update the public key on all
> systems you interact with.

## Deploying the public key

To use the user key that was created previous, the contents of your public key (_\\.ssh\id\_ecdsa.pub_) needs to be placed on the server into a text file. The name and location of the file depends on whether the user account is a member of the local administrator group or a standard user account. The following sections cover both standard and administrative users.

### Standard user

The contents of your public key (_\\.ssh\id\_ecdsa.pub_) needs to be placed on the server into a text file called `authorized_keys` in _C:\Users\username\\.ssh\\_. You can copy your public key using the OpenSSH scp secure file-transfer utility, or using a PowerShell to write the key to the file.

The example below copies the public key to the server, replace "username" with your username. You need to use the password for the user account for the server initially.

```powershell
# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\id_ecdsa.pub

# Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
$remotePowershell = "powershell New-Item -Force -ItemType Directory -Path $env:USERPROFILE\.ssh; Add-Content -Force -Path $env:USERPROFILE\.ssh\authorized_keys -Value '$authorizedKey' -Encoding UTF8" 

# Connect to your server and run the PowerShell using the $remotePowerShell variable
ssh username@domain1@contoso.com $remotePowershell
```

### Administrative user

The contents of your public key (_\\.ssh\id\_ecdsa.pub_) needs to be placed on the server into a text file called `administrators_authorized_keys` in _C:\ProgramData\ssh\\_. You can copy your public key using the OpenSSH scp secure file-transfer utility, or using a PowerShell to write the key to the file. The ACL on this file needs to be configured to only allow access to administrators and System.

The example below copies the public key to the server and configures the ACL. Replace "username" with your user name. You need to use the password for the user account for the server
initially.

> [!NOTE]
> This example shows the steps for creating the `administrators_authorized_keys` file. This file only
> applies to administrator accounts and must be used instead of the per user file within the user's
> profile location.

```powershell
# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\id_ecdsa.pub

# Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
$remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '''$authorizedKey''' -Encoding UTF8;icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""

# Connect to your server and run the PowerShell using the $remotePowerShell variable
ssh username@domain1@contoso.com $remotePowershell
```

For non-English localized versions of the operating system, the script needs to be modified to reflect group names accordingly. To prevent errors when granting permissions to group names, the Security Identifier (SID) can be used in its place. The SID can be retrieved by running `Get-LocalGroup | Select-Object Name, SID`. When you use the SID in place of the group name, it must be preceded by an asterisk (**\***). In the following example, the **Administrators** group uses the SID `S-1-5-32-544`:

```powershell
$remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '''$authorizedKey''' -Encoding UTF8;icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""*S-1-5-32-544:F"" /grant ""SYSTEM:F"""
```

These steps complete the configuration required to use key-based authentication with OpenSSH on Windows.
Once the example PowerShell commands have been run, the user can connect to the sshd host from any client that has the private key.

## Troubleshooting
### User is unable to authenticate with a valid key
- Confirm that  `authorized_keys` or `administrator_authorized_keys` is saved with UTF-8 encoding. By default, the encoding is set to UTF-16 LE and OpenSSH server is unable to parse it, resulting in failed authentication. Open the file in Notepad and re-save it with UTF-8 encoding.


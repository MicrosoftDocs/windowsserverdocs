---
title: OpenSSH key management for Windows
description: OpenSSH Server key management for Windows using the Windows tools or PowerShell.
ms.date: 06/03/2021
ms.topic: conceptual
ms.author: damaerte
author: maertendmsft
---

# OpenSSH key management

>Applies to Windows Server 2019, Windows 10: Windows Server 2022,

Most authentication in Windows environments is done with a username-password pair, which works well for systems that share a common domain. When working across domains, such as between on-premises and cloud-hosted systems, it becomes vulnerable to brute force intrusions.

By comparison, Linux environments commonly use public-key/private-key pairs to drive authentication which doesn't require the use of guessable passwords. OpenSSH includes tools to help support this, specifically:

* __ssh-keygen__ for generating secure keys
* __ssh-agent__ and __ssh-add__ for securely storing private keys
* __scp__ and __sftp__ to securely copy public key files during initial use of a server

This document provides an overview of how to use these tools on Windows to begin using key-based authentication with SSH.
If you are unfamiliar with SSH key management, we strongly recommend you review [NIST document IR 7966](http://nvlpubs.nist.gov/nistpubs/ir/2015/NIST.IR.7966.pdf) titled "Security of Interactive and Automated Access Management Using Secure Shell (SSH)".

## About key pairs

Key pairs refer to the public and private key files that are used by certain authentication protocols.

SSH public key authentication uses asymmetric cryptographic algorithms to generate two key files – one "private" and the other "public". The private key files are the equivalent of a password, and should stay protected under all circumstances. If someone acquires your private key, they can log in as you to any SSH server you have access to. The public key is what is placed on the SSH server, and may be shared without compromising the private key.

When using key authentication with an SSH server, the SSH server and client compare the public key for a user name provided against the private key. If the server-side public key cannot be validated against the client-side private key, authentication fails.

Multi-factor authentication may be implemented with key pairs by entering a passphrase when the key pair is generated (see [user key generation](#user-key-generation) below). During authentication the user is prompted for the passphrase, which is used along with the presence of the private key on the SSH client to authenticate the user.

## Host key generation

Public keys have specific ACL requirements that, on Windows, equate to only allowing access to administrators and System. On first use of sshd, the key pair for the host will be automatically generated.

> [!IMPORTANT]
> You need to have OpenSSH Server installed first. Please see [Getting started with OpenSSH](OpenSSH_Install_FirstUse.md).

By default the sshd service is set to start manually. To start it each time the server is rebooted, run the following commands from an elevated PowerShell prompt on your server:

```powershell
# Set the sshd service to be started automatically
Get-Service -Name sshd | Set-Service -StartupType Automatic

# Now start the sshd service
Start-Service sshd
```

Since there is no user associated with the sshd service, the host keys are stored under C:\ProgramData\ssh.

## User key generation

To use key-based authentication, you first need to generate public/private key pairs for your client. ssh-keygen.exe is used to generate key files and the algorithms DSA, RSA, ECDSA, or Ed25519 can be specified. If no algorithm is specified, RSA is used. A strong algorithm and key length should be used, such as Ed25519 in this example.

To generate key files using the Ed25519 algorithm, run the following from a PowerShell or cmd prompt on your client:

```powershell
ssh-keygen -t ed25519
```

This should display the following (where "username" is replaced by your user name):

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\username\.ssh\id_ed25519):
```

You can press Enter to accept the default, or specify a path and/or filename where you would like your keys to be generated.
At this point, you'll be prompted to use a passphrase to encrypt your private key files. This can be empty but is not recommended.
The passphrase works with the key file to provide two-factor authentication. For this example, we are leaving the passphrase empty.

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\username\.ssh\id_ed25519.
Your public key has been saved in C:\Users\username\.ssh\id_ed25519.pub.
The key fingerprint is:
SHA256:OIzc1yE7joL2Bzy8!gS0j8eGK7bYaH1FmF3sDuMeSj8 username@server@LOCAL-HOSTNAME

The key's randomart image is:
+--[ED25519 256]--+
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

Now you have a public/private Ed25519 key pair in the location specified. The .pub files are public keys, and files without an extension are private keys:

```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/3/2021   2:55 PM            464 ed25519
-a----         6/3/2021   2:55 PM            103 ed25519.pub
```

Remember that private key files are the equivalent of a password should be protected the same way you protect your password.
To help with that, use ssh-agent to securely store the private keys within a Windows security context, associated with your Windows login. To do that, start the ssh-agent service as Administrator and use ssh-add to store the private key.

```powershell
# By default the ssh-agent service is disabled. Allow it to be manually started for the next step to work.
# Make sure you're running as an Administrator.
Get-Service ssh-agent | Set-Service -StartupType Manual

# Start the service
Start-Service ssh-agent

# This should return a status of Running
Get-Service ssh-agent

# Now load your key files into ssh-agent
ssh-add ~\.ssh\id_ed25519
```

After completing these steps, whenever a private key is needed for authentication from this client, ssh-agent will automatically retrieve the local private key and pass it to your SSH client.

> [!IMPORTANT]
> It is strongly recommended that you back up your private key to a secure location,
> then delete it from the local system, *after* adding it to ssh-agent.
> The private key cannot be retrieved from the agent providing a strong algorithm has been used, such as Ed25519 in this example.
> If you lose access to the private key, you will have to create a new key pair
> and update the public key on all systems you interact with.

## Deploying the public key

To use the user key that was created above, the contents of your public key (~\\.ssh\id_ed25519.pub) needs to be placed on the server into a text file, the name and location of which depends on whether the user account is a member of the local administrators group or a standard user account.

### Standard user

The contents of your public key (~\\.ssh\id_ed25519.pub) needs to be placed on the server into a text file called `authorized_keys` in C:\Users\username\\.ssh\\. The OpenSSH client includes scp, which is a secure file-transfer utility, to help with this.

The example below copies the public key to the server (where "username" is replaced by your user name). You will need to use the password for the user account for the server initially.

```powershell
# Make sure that the .ssh directory exists in your server's user account home folder
ssh username@domain1@contoso.com mkdir C:\Users\username\.ssh\

# Use scp to copy the public key file generated previously on your client to the authorized_keys file on your server
scp C:\Users\username\.ssh\id_ed25519.pub user1@domain1@contoso.com:C:\Users\username\.ssh\authorized_keys
```

### Administrative user

The contents of your public key (~\\.ssh\id_ed25519.pub) needs to be placed on the server into a text file called `administrators_authorized_keys` in C:\ProgramData\ssh\\. The OpenSSH client includes scp, which is a secure file-transfer utility, to help with this. The ACL on this file needs to be configured to only allow access to administrators and System.

The example below copies the public key to the server and configures the ACL (where "username" is replaced by your user name). You will need to use the password for the user account for the server initially.

> [!NOTE]
> This example shows the steps for creating the `administrators_authorized_keys file`. If it is run multiple times, it will overwrite this file each time. To add the public key for multiple administrative users, you need to append this file with each public key.

```powershell
# Make sure that the .ssh directory exists in your server's user account home folder
ssh user1@domain1@contoso.com mkdir C:\ProgramData\ssh\

# Use scp to copy the public key file generated previously on your client to the authorized_keys file on your server
scp C:\Users\username\.ssh\id_ed25519.pub user1@domain1@contoso.com:C:\ProgramData\ssh\administrators_authorized_keys

# Appropriately ACL the authorized_keys file on your server
ssh --% user1@domain1@contoso.com icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"
```

These steps complete the configuration required to use key-based authentication with OpenSSH on Windows.
After this, the user can connect to the sshd host from any client that has the private key.

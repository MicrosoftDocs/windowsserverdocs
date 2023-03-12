---
ms.date: 09/27/2018
ms.topic: conceptual
keywords: OpenSSH, SSH, SSHD, install, setup
contributor: maertendMSFT
author: maertendMSFT
title: OpenSSH Server Configuration for Windows
ms.product: w10
---

# OpenSSH Key Management

Most authentication in Windows environments is done with a username-password pair.
This works well for systems that share a common domain. 
When working across domains, such as between on-premise and cloud-hosted systems, it becomes more difficult.

By comparison, Linux environments commonly use public-key/private-key pairs to drive authentication.
OpenSSH includes tools to help support this, specifically:

* __ssh-keygen__ for generating secure keys
* __ssh-agent__ and __ssh-add__ for securely storing private keys
* __scp__ and __sftp__ to securely copy public key files during initial use of a server

This document provides an overview of how to use these tools on Windows to begin using key authentication with SSH. 
If you are unfamiliar with SSH key management, we strongly recommend you review [NIST document IR 7966](http://nvlpubs.nist.gov/nistpubs/ir/2015/NIST.IR.7966.pdf) titled “Security of Interactive and Automated Access Management Using Secure Shell (SSH).”

## About key pairs

Key pairs refer to the public and private key files that are used by certain authentication protocols. 

SSH public-key authentication uses asymmetric cryptographic algorithms to generate two key files – one "private" and the other "public". The private key files are the equivalent of a password, and should protected under all circumstances. If someone acquires your private key, they can log in as you to any SSH server you have access to. The public key is what is placed on the SSH server, and may be shared without compromising the private key.

When using key authentication with an SSH server, the SSH server and client compare the public key for username  provided against the private key. If the public key cannot be validated against the client-side private key, authentication fails. 

Multi-factor authentication may be implemented with key pairs by requiring that a passphrase be supplied when the key pair is generated (see key generation below). 
During authentication the user is prompted for the passphrase, which is used along with the presence of the private key on the SSH client to authenticate the user. 

## Host key generation

Public keys have specific ACL requirements that, on Windows, equate to only allowing access to administrators and System. 
To make this easier, 

* The OpenSSHUtils PowerShell module has been created to set the key ACLs properly, and should be installed on the server
* On first use of sshd, the key pair for the host will be automatically generated. If ssh-agent is running, the keys will be automatically added to the local store. 

To make key authentication easy with an SSH server, run the following commands from an elevated PowerShell prompt:

```powershell

# Install the OpenSSHUtils module to the server. This will be valuable when deploying user keys.
Install-Module -Force OpenSSHUtils -Scope AllUsers

# Start the ssh-agent service to preserve the server keys
Start-Service ssh-agent

# Now start the sshd service
Start-Service sshd
```

Since there is no user associated with the sshd service, the host keys are stored under \ProgramData\ssh.


## User key generation

To use key-based authentication, you first need to generate some public/private key pairs for your client. 
From PowerShell or cmd, use ssh-keygen to generate some key files.

```powershell
cd ~\.ssh\
ssh-keygen
```

This should display something like the following (where "username" is replaced by your user name)

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\username\.ssh\id_ed25519):
```

You can hit Enter to accept the default, or specify a path where you’d like your keys to be generated. 
At this point, you’ll be prompted to use a passphrase to encrypt your private key files.
The passphrase works with the key file to provide 2-factor authentication. 
For this example, we are leaving the passphrase empty. 

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

Now you have a public/private ED25519 key pair
(the .pub files are public keys and the rest are private keys):

```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/28/2018  11:09 AM           1679 id_ed25519
-a----        9/28/2018  11:09 AM            414 id_ed25519.pub
```

Remember that private key files are the equivalent of a password should be protected the same way you protect your password.
To help with that, use ssh-agent to securely store the private keys within a Windows security context, associated with your Windows login. 
To do that, start the ssh-agent service as Administrator and use ssh-add to store the private key. 

```powershell
# Make sure you're running as an Administrator
Start-Service ssh-agent

# This should return a status of Running
Get-Service ssh-agent

# Now load your key files into ssh-agent
ssh-add ~\.ssh\id_ed25519

```

After completing these steps, whenever a private key is needed for authentication from this client, ssh-agent will automatically retrieve the local private key and pass it to your SSH client.

> [!NOTE]
> It is strongly recommended that you back up your private key to a secure location,
> then delete it from the local system, *after* adding it to ssh-agent.
> The private key cannot be retrieved from the agent.
> If you lose access to the private key, you would have to create a new key pair
> and update the public key on all systems you interact with.

## Deploying the public key

To use the user key that was created above, the public key needs to be placed on the server into a text file called *authorized_keys* under users\username\ssh. 
The OpenSSH tools include scp, which is a secure file-transfer utility, to help with this.

To move the contents of your public key (~\.ssh\id_ed25519.pub) into a text file called authorized_keys in ~\.ssh\ on your server/host.

This example uses the Repair-AuthorizedKeyPermissions function in the OpenSSHUtils module which was previously installed on the host in the instructions above.

```powershell
# Make sure that the .ssh directory exists in your server's home folder
ssh user1@domain1@contoso.com mkdir C:\users\user1\.ssh\

# Use scp to opy the public key file generated previously to authorized_keys on your server
scp C:\Users\user1\.ssh\id_ed25519.pub user1@domain1@contoso.com:C:\Users\user1\.ssh\authorized_keys

# Appropriately ACL the authorized_keys file on your server  
ssh --% user1@domain1@contoso.com powershell -c $ConfirmPreference = 'None'; Repair-AuthorizedKeyPermission C:\Users\user1\.ssh\authorized_keys
```

These steps complete the configuration required to use key-based authentication with SSH on Windows.
After this, the user can connect to the sshd host from any client that has the private key.


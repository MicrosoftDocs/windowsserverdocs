---
ms.date:  01/07/2019
contributor:  damaerteMSFT
author: maertendMSFT
keywords:  OpenSSH, SSH, Win32-OpenSSH
title:  OpenSSH in Windows
ms.product: w10
---
# OpenSSH in Windows

OpenSSH is the open-source version of the Secure Shell (SSH) tools used by administrators of Linux and other non-Windows for cross-platform management of remote systems. 
OpenSSH has been added to Windows as of autumn 2018, and is included in Windows 10 and Windows Server 2019. 

SSH is based on a client-server architecture where the system the user is working on is the client and the remote system being managed is the server. 
OpenSSH includes a range of components and tools designed to provide a secure and straightforward approach to remote system administration, including:

* sshd.exe, which is the SSH server component that must be running on the system being managed remotely 
* ssh.exe, which is the SSH client component that runs on the user's local system
* ssh-keygen.exe generates, manages and converts authentication keys for SSH 
* ssh-agent.exe stores private keys used for public key authentication
* ssh-add.exe adds private keys to the list allowed by the server
* ssh-keyscan.exe aids in collecting the public SSH host keys from a number of hosts
* sftp.exe is the service that provides the Secure File Transfer Protocol, and runs over SSH
* scp.exe is a file copy utility that runs on SSH

Documentation in this section focuses on how OpenSSH is used on Windows, including installation, and Windows-specific configuration and use cases. Here are the topics:
* Installing and Uninstalling OpenSSH For Windows Server 2019 and Windows 10

Additional detailed documentation for common OpenSSH features is available online at [OpenSSH.com](https://www.openssh.com/manual.html). 

The master [OpenSSH open source project](https://www.openssh.com) is managed by developers at the OpenBSD Project. 
The Microsoft fork of this project is in [GitHub](https://github.com/PowerShell/openssh-portable).
Feedback on Windows OpenSSH is welcomed and can be provided by creating GitHub issues in our [OpenSSH GitHub repo](https://github.com/PowerShell/openssh-portable). 

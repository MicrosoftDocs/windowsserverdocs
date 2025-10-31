---
title: OpenSSH for Windows overview
description: Overview of the OpenSSH tools used by Windows administrators for cross-platform management of remote systems.
ms.date: 02/20/2025
ms.author: roharwoo
author: robinharwood
ms.topic: overview
---

# OpenSSH for Windows overview

OpenSSH is the open-source version of the Secure Shell (SSH) tools used by administrators of Linux and other non-Windows for cross-platform management of remote systems. Beginning with Windows 10 build 1809 and Windows Server 2019, OpenSSH is available as a feature on demand.

SSH is based on a client-server architecture where the system the user is working on is the client and the remote system being managed is the server. OpenSSH includes a range of components and tools designed to provide a secure and straightforward approach to remote system administration.

The following table lists the default install state of OpenSSH for Windows on different Windows releases.

| Windows release | SSH install state |
|----------|----------|
|Windows Server 2019|Not installed, install and enable using optional features|
|Windows Server 2022|Not installed, install and enable using optional features|
|Windows Server 2025|Installed but not enabled|
|Windows 10 build 1809 +|Not installed, install and enable using optional features|

OpenSSH for Windows has the following commands built in.

- `ssh` is the SSH client component that runs on the user's local system
- `sshd` is the SSH server component that must be running on the system being managed remotely
- `ssh-keygen` generates, manages and converts authentication keys for SSH
- `ssh-agent` stores private keys used for public key authentication
- `ssh-add` adds private keys to the list allowed by the server
- `ssh-keyscan` aids in collecting the public SSH host keys from hosts
- `sftp` is the service that provides the Secure File Transfer Protocol, and runs over SSH
- `scp` is a file copy utility that runs on SSH

> [!TIP]
> The documentation focuses on how OpenSSH is used on Windows, including installation, and
> Windows-specific configuration, commands, and use cases. Additional detailed documentation for
> common OpenSSH features is available online at
> [OpenSSH.com](https://www.openssh.com/manual.html).

Feedback on Windows OpenSSH is welcomed and can be provided by creating GitHub issues in our [OpenSSH GitHub repo](https://github.com/PowerShell/openssh-portable). The [OpenSSH open source project](https://www.openssh.com) is managed by developers at the OpenBSD Project. The Microsoft fork of this project is in [GitHub](https://github.com/PowerShell/openssh-portable).

## Next steps

- [Get started with OpenSSH](OpenSSH_Install_FirstUse.md)

---
title: OpenSSH Server configuration for Windows
description: Learn about the Windows-specific configuration options for OpenSSH Server on Windows Server and Windows.
ms.date: 07/12/2022
ms.topic: conceptual
ms.author: damaerte
author: maertendmsft
---

# OpenSSH Server configuration for Windows Server and Windows

>Applies to Windows Server 2022, Windows Server 2019, Windows 10 (build 1809 and later)

This article covers the Windows-specific configuration for OpenSSH Server (sshd).

OpenSSH maintains detailed documentation for configuration options online at [OpenSSH.com](https://www.openssh.com/manual.html), which isn't duplicated in this documentation set.

## OpenSSH configuration files

OpenSSH has configuration files for both server and client settings. OpenSSH is open-source and is
added to Windows Server and Windows Client operating systems, starting with Windows Server 2019 and
Windows 10 (build 1809). As a result, open-source documentation for OpenSSH configuration files
isn't repeated here. Client configuration files and can be found on the
[ssh_config manual page](https://man.openbsd.org/ssh_config) and for OpenSSH Server configuration
files can be found on the [sshd_config manual page](https://man.openbsd.org/sshd_config).

Open SSH Server (sshd) reads configuration data from _%programdata%\ssh\sshd\_config_ by default, or
a different configuration file may be specified by launching `sshd.exe` with the `-f` parameter. If
the file is absent, sshd generates one with the default configuration when the service is started.

In Windows, the OpenSSH Client (ssh) reads configuration data from a configuration file in the
following order:

1. By launching ssh.exe with the -F parameter, specifying a path to a configuration file and an
   entry name from that file.
2. A user's configuration file at _%userprofile%\\.ssh\config_.
3. The system-wide configuration file at _%programdata%\ssh\ssh\_config_.

## Configuring the default shell for OpenSSH in Windows

The default command shell provides the experience a user sees when connecting to the server using SSH.
The initial default Windows is the Windows Command shell (cmd.exe).
Windows also includes PowerShell, and third-party command shells are also available for Windows and may be configured as the default shell for a server.

To set the default command shell, first confirm that the OpenSSH installation folder is on the system path.
For Windows, the default installation folder is _%systemdrive%\Windows\System32\openssh_.
The following command shows the current path setting, and adds the default OpenSSH installation folder to it.

Command shell | Command to use
------------- | --------------
Command | `path`
PowerShell | `$env:path`

Configuring the default ssh shell is done in the Windows registry by adding the full path to the shell executable to `HKEY_LOCAL_MACHINE\SOFTWARE\OpenSSH` in the string value `DefaultShell`.

As an example, the following elevated PowerShell command sets the default shell to be powershell.exe:

```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```

## Windows Configurations in sshd_config

In Windows, sshd reads configuration data from _%programdata%\ssh\sshd\_config_ by default, or a different configuration file may be specified by launching `sshd.exe` with the `-f` parameter.
If the file is absent, sshd generates one with the default configuration when the service is started.

The elements listed below provide Windows-specific configuration possible through entries in sshd_config.
There are other configuration settings possible that aren't listed here, as they're covered in detail in the online [Win32 OpenSSH documentation](https://github.com/powershell/win32-openssh/wiki).

> [!TIP]
> The OpenSSH Server (sshd) reads the configuration file when the service starts. Any changes to the
> configuration file requires the service to be restarted.

### AllowGroups, AllowUsers, DenyGroups, DenyUsers

Controlling which users and groups can connect to the server is done using the AllowGroups, AllowUsers, DenyGroups, and DenyUsers directives.
The allow/deny directives are processed in the following order: DenyUsers, AllowUsers, DenyGroups, and finally AllowGroups.
All account names must be specified in lower case.
For more information about PATTERNS and wildcard in the ssh_config, see the [sshd_config OpenBSD manual page](https://man.openbsd.org/ssh_config#PATTERNS).

When configuring user/group based rules with a domain user or group, use the following format: `user?domain*`.
Windows allows multiple formats for specifying domain principals, but many conflict with standard Linux patterns.
For that reason, * is added to cover FQDNs.
Also, this approach uses "?", instead of @, to avoid conflicts with the username@host format.

Work group users/groups and internet-connected accounts are always resolved to their local account name (no domain part, similar to standard Unix names).
Domain users and groups are strictly resolved to [NameSamCompatible](/windows/desktop/api/secext/ne-secext-extended_name_format) format - domain_short_name\user_name.
All user/group based configuration rules need to adhere to this format.

The following example denies contoso\admin from the host 192.168.2.23, and blocks all users from contoso domain. It also allows users who are a member of the contoso\sshusers and contoso\serveroperators groups.

```sshd_config
DenyUsers contoso\admin@192.168.2.23
DenyUsers contoso\*
AllowGroups contoso\sshusers contoso\serveroperators
```

The example below allow the user localusers to sign-in from the host 192.168.2.23 and allows members of the group sshusers.

```sshd_config
AllowUsers localuser@192.168.2.23
AllowGroups sshusers
```

### AuthenticationMethods

For Windows OpenSSH, the only available authentication methods are `password` and `publickey`.

> [!IMPORTANT]
> Authentication using a Microsoft Entra account is not currently supported.

### AuthorizedKeysFile

The default is `.ssh/authorized_keys`. If the path isn't absolute, it's taken relative to user's
home directory (or profile image path), for example, _C:\Users\username_. If the user belongs to
the administrator group, _%programdata%/ssh/administrators\_authorized\_keys_ is used instead.

> [!TIP]
> The _administrators_authorized_keys_ file must only have permission entries for the NT
> Authority\SYSTEM account and BUILTIN\Administrators security group. The NT Authority\SYSTEM
> account must be granted full control. The BUILTIN\Administrators security group is required for
> administrators to manage the authorized keys, you can choose the required access. To grant
> permissions you can open an elevated PowerShell prompt, and running the command
> `icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"`.

### ChrootDirectory (Support added in v7.7.0.0)

This directive is only supported with sftp sessions. A remote session into cmd.exe wouldn't honor
the `ChrootDirectory`. To set up a sftp-only chroot server, set ForceCommand to internal-sftp. You may also set up
scp with chroot, by implementing a custom shell that would only allow scp and sftp.

### GSSAPIAuthentication

The `GSSAPIAuthentication` configuration argument specifies whether GSSAPI based user authentication is allowed. The
default for `GSSAPIAuthentication` is no.

GSSAPI authentication also requires the use of the `-K` switch specifying the hostname when using
the OpenSSH client. Alternatively, you can create a corresponding entry in the SSH client
configuration. In Windows, the OpenSSH client reads configuration data from
_%userprofile%\.ssh\config_ by default.

You can see an example GSSAPI OpenSSH client configuration below.

```config
# Specify a set of configuration arguments for a host matching the pattern SERVER01.contoso.com
# Patterns are case sensitive
Host SERVER01.contoso.com
    # Enables GSSAPI authentication
    GSSAPIAuthentication yes
    # Forward (delegate) credentials to the server.
    GSSAPIDelegateCredentials yes
```

> [!IMPORTANT]
> GSSAPI is only available starting in Windows Server 2022, Windows 11, and Windows 10 xxxx.

### HostKey

The defaults are:

```sshd_config
#HostKey __PROGRAMDATA__/ssh/ssh_host_rsa_key
#HostKey __PROGRAMDATA__/ssh/ssh_host_dsa_key
#HostKey __PROGRAMDATA__/ssh/ssh_host_ecdsa_key
#HostKey __PROGRAMDATA__/ssh/ssh_host_ed25519_key
```

If the defaults aren't present, sshd automatically generates them on a service start.

### Match

Matches conditions using one or more criteria. Upon a match, the subsequent configuration arguments are applied. Matches uses the pattern rules covered in the [AllowGroups, AllowUsers, DenyGroups, DenyUsers](#allowgroups-allowusers-denygroups-denyusers) section. User and group names should be in lower case.

### PermitRootLogin

Not applicable in Windows. To prevent administrators signing in, use Administrators with DenyGroups
directive.

### SyslogFacility

If you need file based logging, use LOCAL0. Logs are generated under _%programdata%\ssh\logs_. For
any other value, including the default value, AUTH directs logging to ETW. For more info, see
[Logging Facilities in Windows](https://github.com/PowerShell/Win32-OpenSSH/wiki/Logging-Facilities).

### Configuration arguments

The following configuration argument is available starting in Windows Server 2022, Windows 11, and
Windows 10 xxxx:

* GSSAPIAuthentication

The following configuration arguments aren't available in the OpenSSH version that ships in Windows
Server and the Windows client:

* AcceptEnv
* AllowStreamLocalForwarding
* AuthorizedKeysCommand
* AuthorizedKeysCommandUser
* AuthorizedPrincipalsCommand
* AuthorizedPrincipalsCommandUser
* Compression
* ExposeAuthInfo
* GSSAPICleanupCredentials
* GSSAPIStrictAcceptorCheck
* HostbasedAcceptedKeyTypes
* HostbasedAuthentication
* HostbasedUsesNameFromPacketOnly
* IgnoreRhosts
* IgnoreUserKnownHosts
* KbdInteractiveAuthentication
* KerberosAuthentication
* KerberosGetAFSToken
* KerberosOrLocalPasswd
* KerberosTicketCleanup
* PermitTunnel
* PermitUserEnvironment
* PermitUserRC
* PidFile
* PrintLastLog
* PrintMotd
* RDomain
* StreamLocalBindMask
* StreamLocalBindUnlink
* StrictModes
* X11DisplayOffset
* X11Forwarding
* X11UseLocalhost
* XAuthLocation

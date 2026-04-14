---
title: OpenSSH Server Configuration for Windows
description: Learn about the Windows-specific configuration options for OpenSSH Server on Windows Server and Windows.
#customer intent: As a system administrator, I want to configure OpenSSH Server on Windows so that I can manage SSH connections securely.
ms.date: 08/05/2025
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
---

# OpenSSH Server configuration for Windows Server and Windows

This article covers the Windows-specific configuration for OpenSSH Server (sshd).

OpenSSH maintains detailed documentation for configuration options online at [OpenSSH.com](https://www.openssh.com/manual.html). This documentation isn't duplicated in this documentation set.

## OpenSSH configuration files

OpenSSH has configuration files for both server and client settings. OpenSSH is open-source and was
added to Windows Server and Windows client operating systems starting with Windows Server 2019 and
Windows 10 (build 1809). Open-source documentation for OpenSSH configuration files
isn't repeated here. Client configuration files can be found on the
[ssh_config manual page](https://man.openbsd.org/ssh_config). OpenSSH server configuration
files can be found on the [sshd_config manual page](https://man.openbsd.org/sshd_config).

OpenSSH Server reads configuration data from `%programdata%\ssh\sshd_config` by default. You can specify a different configuration file by running `sshd.exe` with the `-f` parameter. If
the file is missing, sshd generates one with the default configuration when the service is started.

In Windows, the OpenSSH Client (ssh) reads configuration data from a configuration file in the
following order:

1. Via `ssh.exe` started with the `-F` parameter, with a path to a configuration file and an
   entry name from that file specified.
1. Via a user's configuration file at `%userprofile%\.ssh\config`.
1. Via the system-wide configuration file at `%programdata%\ssh\ssh_config`.

## Configuring the default shell for OpenSSH in Windows

The default command shell provides the experience a user sees when connecting to the server by using SSH.
The initial default in Windows is the Windows command prompt (cmd.exe).
Windows also includes PowerShell, and non-Microsoft command shells are also available for Windows and might be configured as the default shell for a server.

To set the default command shell, first confirm that the OpenSSH installation folder is on the system path.
For Windows, the default installation folder is `%systemdrive%\Windows\System32\openssh`.
The following command shows the current path setting and adds the default OpenSSH installation folder to it.

| Command shell | Command to use |
|------------- | --------------|
| Command | `path` |
| PowerShell | `$env:path` |

You can configure the default ssh shell in the Windows registry by adding the full path to the shell executable to `HKEY_LOCAL_MACHINE\SOFTWARE\OpenSSH` in the string value `DefaultShell`.

The following example elevated PowerShell command sets the default shell to be `powershell.exe` for OpenSSH Server. (Setting this path doesn't apply to OpenSSH Client.)

```powershell
$NewItemPropertyParams = @{
    Path         = "HKLM:\SOFTWARE\OpenSSH"
    Name         = "DefaultShell"
    Value        = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    PropertyType = "String"
    Force        = $true
}
New-ItemProperty @NewItemPropertyParams
```

## Windows configurations in sshd_config

In Windows, sshd reads configuration data from `%programdata%\ssh\sshd_config` by default. You can specify a different configuration file by running `sshd.exe` with the `-f` parameter.
If the file is missing, sshd generates one with the default configuration when the service is started.

The following sections describe Windows-specific configuration settings that are possible via entries in sshd_config.
There are other configuration settings possible that aren't listed here. They're covered in detail in the [Win32 OpenSSH documentation](https://github.com/powershell/win32-openssh/wiki).

> [!TIP]
> OpenSSH Server (sshd) reads the configuration file when the service starts. Any changes to the
> configuration file require the service to be restarted.

### AllowGroups, AllowUsers, DenyGroups, DenyUsers

You can control which users and groups can connect to the server by using the `AllowGroups`, `AllowUsers`, `DenyGroups`, and `DenyUsers` directives.
The allow and deny directives are processed in the following order: `DenyUsers`, `AllowUsers`, `DenyGroups`, and finally `AllowGroups`.

All account names must be specified in lower case.

For more information about patterns and wildcards in ssh_config, see the [sshd_config OpenBSD manual page](https://man.openbsd.org/ssh_config#PATTERNS).

When configuring user/group-based rules with a domain user or group, use the following format: `user?domain*`.

Windows allows multiple formats for specifying domain principals, but might conflict with standard Linux patterns. For that reason, `*` is used to cover Fully Qualified Domain Names (FQDNs). Also, this approach uses `?`, instead of `@`, to avoid conflicts with the `username@host` format.

Work group users, groups, and internet-connected accounts are always resolved to their local account name (no domain part, similar to standard Unix names). Domain users and groups are strictly resolved to [NameSamCompatible](/windows/desktop/api/secext/ne-secext-extended_name_format) format `domain_short_name\user_name`.

All user and group-based configuration rules need to adhere to this format.

The following example denies `contoso\admin` from the host 192.168.2.23 and blocks all users from the Contoso domain. It also allows users who are members of the `contoso\sshusers` and `contoso\serveroperators` groups.

```sshd_config
DenyUsers contoso\admin@192.168.2.23
DenyUsers contoso\*
AllowGroups contoso\sshusers contoso\serveroperators
```

The following example allows the user `localuser` to sign in from the host 192.168.2.23 and allows members of the group `sshusers`.

```sshd_config
AllowUsers localuser@192.168.2.23
AllowGroups sshusers
```

### AuthenticationMethods

For Windows OpenSSH, the only available authentication methods are `password` and `publickey`.

> [!IMPORTANT]
> Authentication via a Microsoft Entra account isn't currently supported.

### AuthorizedKeysFile

The default is `.ssh/authorized_keys`. If you don't specify an absolute path, OpenSSH looks for the
file relative to your home directory, such as `C:\Users\username`. If the user belongs to
the administrator group, `%programdata%/ssh/administrators_authorized_keys` is used instead.

> [!TIP]
> The _administrators_authorized_keys_ file must only have permission entries for the
> `NT Authority\SYSTEM` account and `BUILTIN\Administrators` security group. The NT Authority\SYSTEM
> account must be granted full control. The `BUILTIN\Administrators` security group is required to
> enable administrators to manage the authorized keys. You can choose the required access. To grant
> permissions, you can open an elevated PowerShell prompt and run the command
> `icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"`.

### ChrootDirectory (support added in v7.7.0.0)

This directive is only supported with SFTP sessions. A remote session into `cmd.exe` doesn't honor
`ChrootDirectory`. To set up a sftp-only chroot server, set `ForceCommand` to internal-sftp. You can also set up
SCP with chroot by implementing a custom shell that allows only SCP and SFTP.

### GSSAPIAuthentication

The `GSSAPIAuthentication` configuration argument specifies whether GSSAPI (Kerberos) based user authentication is allowed. The
default for `GSSAPIAuthentication` is no.

GSSAPI authentication also requires the use of the `-K` switch specifying the hostname when you use
the OpenSSH Client. Alternatively, you can create a corresponding entry in the SSH client
configuration. In Windows, the OpenSSH Client reads configuration data from
`%userprofile%\.ssh\config` by default.

Here's an example GSSAPI OpenSSH Client configuration:

```config
# Specify a set of configuration arguments for a host matching the
# pattern SERVER01.contoso.com.
#
# Patterns are case sensitive.
Host SERVER01.contoso.com
    # Enables GSSAPI authentication.
    GSSAPIAuthentication yes
    # Forward (delegate) credentials to the server.
    GSSAPIDelegateCredentials yes
```

> [!IMPORTANT]
> GSSAPI is only available starting in Windows Server 2022, Windows 11, and Windows 10 ([May 2021 Update](https://support.microsoft.com/help/5003173)).

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

Matches conditions using one or more criteria. Upon a match, the subsequent configuration arguments are applied. Match uses the pattern rules covered in the [AllowGroups, AllowUsers, DenyGroups, DenyUsers](#allowgroups-allowusers-denygroups-denyusers) section. User and group names should be in lowercase.

### PermitRootLogin

Not applicable in Windows. To prevent administrators from signing in, use Administrators with the `DenyGroups`
directive.

### SyslogFacility

If you need file-based logging, use `LOCAL0`. Logs are generated under `%programdata%\ssh\logs`. For
any other value, including the default value, AUTH directs logging to ETW. For more info, see
[Logging Facilities in Windows](https://github.com/PowerShell/Win32-OpenSSH/wiki/Logging-Facilities).

### Configuration arguments

The following configuration argument is available starting in Windows Server 2022, Windows 11, and
Windows 10 ([May 2021 Update](https://support.microsoft.com/help/5003173)):

- `GSSAPIAuthentication`

The following configuration arguments aren't available in the OpenSSH version that ships in Windows
Server and Windows:

- `AcceptEnv`
- `AllowStreamLocalForwarding`
- `AuthorizedKeysCommand`
- `AuthorizedKeysCommandUser`
- `AuthorizedPrincipalsCommand`
- `AuthorizedPrincipalsCommandUser`
- `ExposeAuthInfo`
- `GSSAPICleanupCredentials`
- `GSSAPIStrictAcceptorCheck`
- `HostbasedAcceptedKeyTypes`
- `HostbasedAuthentication`
- `HostbasedUsesNameFromPacketOnly`
- `IgnoreRhosts`
- `IgnoreUserKnownHosts`
- `KbdInteractiveAuthentication`
- `KerberosAuthentication`
- `KerberosGetAFSToken`
- `KerberosOrLocalPasswd`
- `KerberosTicketCleanup`
- `PermitTunnel`
- `PermitUserEnvironment`
- `PermitUserRC`
- `PidFile`
- `PrintLastLog`
- `PrintMotd`
- `RDomain`
- `StreamLocalBindMask`
- `StreamLocalBindUnlink`
- `StrictModes`
- `X11DisplayOffset`
- `X11Forwarding`
- `X11UseLocalhost`
- `XAuthLocation`

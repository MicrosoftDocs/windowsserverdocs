---
ms.date: 09/27/2018
ms.topic: conceptual
keywords: OpenSSH, SSH, SSHD, install, setup
contributor: maertendMSFT
ms.product: w10
author: maertendMSFT
title: OpenSSH Server Configuration for Windows
---

# OpenSSH Server Configuration for Windows 10 1809 and Server 2019#

This topic covers the Windows-specific configuration for OpenSSH Server (sshd). 

OpenSSH maintains detailed documentation for configuration options online at [OpenSSH.com](https://www.openssh.com/manual.html), which is not be duplicated in this documentation set. 

## Configuring the default shell for OpenSSH in Windows

The default command shell provides the experience a user sees when connecting to the server using SSH. 
The initial default Windows is the Windows Command shell (cmd.exe). 
Windows also includes PowerShell and Bash, and third party command shells are also available for Windows and may be configured as the default shell for a server.

To set the default command shell, first confirm that the OpenSSH installation folder is on the system path. 
For Windows, the default installation folder is SystemDrive:WindowsDirectory\System32\openssh. 
The following commands shows the current path setting, and add the default OpenSSH installation folder to it. 

Command shell | Command to use
------------- | -------------- 
Command | path
PowerShell | $env:path

Configuring the default ssh shell is done in the Windows registry by adding the full path to the shell executable to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\OpenSSH in the string value DefaultShell. 

As an example, the following Powershell command sets the default shell to be PowerShell.exe:

```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```

## Windows Configurations in sshd_config 

In Windows, sshd reads configuration data from %programdata%\ssh\sshd_config by default, or a different configuration file may be specified by launching sshd.exe with the -f parameter.
If the file is absent, sshd generates one with the default configuration when the service is started.

The elements listed below provide Windows-specific configuration possible through entries in sshd_config. 
There are other configuration settings possible in that are not listed here, as they are covered in detail in the online [Win32 OpenSSH documentation](https://github.com/powershell/win32-openssh/wiki). 


### AllowGroups, AllowUsers, DenyGroups, DenyUsers 

Controlling which users and groups can connect to the server is done using the AllowGroups, AllowUsers, DenyGroups and DenyUsers directives. 
The allow/deny directives are processed in the following order: DenyUsers, AllowUsers, DenyGroups, and finally AllowGroups. 
All account names must be specified in lower case. 
See PATTERNS in ssh_config for more information on patterns for wildcards.

When configuring user/group based rules with a domain user or group, use the following format: ``` user?domain* ```.
Windows allows multiple of formats for specifying domain principals, but many conflict with standard Linux patterns. 
For that reason, * is added to cover FQDNs. 
Also, this approach uses "?", instead of @, to avoid conflicts with the username@host format. 

Work group users/groups and internet-connected accounts are always resolved to their local account name (no domain part, similar to standard Unix names). 
Domain users and groups are strictly resolved to [NameSamCompatible](https://docs.microsoft.com/windows/desktop/api/secext/ne-secext-extended_name_format) format - domain_short_name\user_name. 
All user/group based configuration rules need to adhere to this format.

Examples for domain users and groups 

```
DenyUsers contoso\admin@192.168.2.23 : blocks contoso\admin from 192.168.2.23
DenyUsers contoso\* : blocks all users from contoso domain
AllowGroups contoso\sshusers : only allow users from contoso\sshusers group
```

Examples for local users and groups 

```
AllowUsers localuser@192.168.2.23
AllowGroups sshusers
```

### AuthenticationMethods 

For Windows OpenSSH, the only available authentication methods are "password" and "publickey".

### AuthorizedKeysFile 

The default is “.ssh/authorized_keys .ssh/authorized_keys2”. If the path is not absolute, it is taken relative to user's home directory (or profile image path). Ex. c:\users\user.

### ChrootDirectory (Support added in v7.7.0.0)

This directive is only supported with sftp sessions. A remote session into cmd.exe wouldn't honor this. To setup a sftp-only chroot server, set ForceCommand to internal-sftp. You may also set up scp with chroot, by implementing a custom shell that would only allow scp and sftp.

### HostKey

The defaults are %programdata%/ssh/ssh_host_ecdsa_key, %programdata%/ssh/ssh_host_ed25519_key and %programdata%/ssh/ssh_host_rsa_key. If the defaults are not present, sshd automatically generates these on a service start.

### Match

Note that pattern rules in this section. User and group names should be in lower case.

### PermitRootLogin

Not applicable in Windows. To prevent administrator login, use Administrators with DenyGroups directive.

### SyslogFacility

If you need file based logging, use LOCAL0. Logs are generated under %programdata%\ssh\logs.
Any other value, including the default value AUTH directs logging to ETW. For more info see Logging Facilities in Windows.

### Not supported 

The following configuration options are not available in the OpenSSH version that ships in Windows Server 2019 and Windows 10 1809:

* AcceptEnv
* AllowStreamLocalForwarding
* AuthorizedKeysCommand
* AuthorizedKeysCommandUser
* AuthorizedPrincipalsCommand
* AuthorizedPrincipalsCommandUser
* Compression
* ExposeAuthInfo
* GSSAPIAuthentication
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
* RDomain
* StreamLocalBindMask
* StreamLocalBindUnlink
* StrictModes
* X11DisplayOffset
* X11Forwarding
* X11UseLocalhost
* XAuthLocation


---
title: Configuring Kerberos for IP Address
description: "Kerberos support for IP-based SPNs"
---

# Kerberos clients allow IPv4 and IPv6 address hostnames in Service Principal Names (SPNs)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Beginning with Windows 10 version 1507 and Windows Server 2016, Kerberos clients can be configured to support IPv4 and IPv6 hostnames in SPNs.

By default Windows will not attempt Kerberos authentication for a host if the hostname is an IP address. It will fall back to legacy authentication protocols like NTLM if enabled. However, applications are sometimes hardcoded to always use IP addresses which means the application will always fall back to NTLM. This can cause compatibility issues if NTLM is disabled.

This capability is enabled on the client through a registry key value.

Registry path:
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters
```

To configure support for IP address hostnames in SPNs, create a TryIPSPN entry. This entry does not exist in the registry by default. After you have created the entry, change the DWORD value to 1. This registry value will need to be set on each client machine that needs to access Kerberos-protected resources by IP address.

## Configuring a Service Principal Name as IP Address

A Service Principal Name is a unique identifier used during Kerberos authentication to identify a service on the network. An SPN is composed of a service, hostname, and optionally a port in form of `service/hostname[:port]` such as `host/fs.contoso.com`. Windows will register multiple SPNs to a computer object when a machine is joined to Active Directory.

IP addresses are not normally used in place of hostnames because IP addresses are often temporary. This can lead to conflicts and authentication failures as address leases expire and renew. Therefore registering an IP address-based SPN is a manual process and should only be used when it's impossible to switch to a DNS-based hostname.

The recommended approach is to use the [Setspn.exe](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) tool. Note that an SPN can only be registered to a single account in Active Directory at a time so it is recommended that IP addresses have static leases if DHCP is used.

```
Setspn -s <service>/ip.address> <domain-user-account>  
```

Example:

```
Setspn -s host/192.168.1.1 server01
```

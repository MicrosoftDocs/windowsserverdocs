---
title: netsh dnsclient
description: The netsh dnsclient command configures and manages DNS client settings in Windows.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/28/2025
---

# netsh dnsclient

The `netsh dnsclient` command is used to configure and manage Domain Name System (DNS) client settings on a Windows computer. It allows administrators to add, delete, set, and display DNS server addresses, encryption settings, and global DNS client options. This command is useful for automating DNS configuration, troubleshooting name resolution issues, and managing advanced DNS features such as DNS-over-HTTPS (DoH) and DNS-over-TLS (DoT).

## Syntax

```
netsh dnsclient [add | delete | dump | help | set | show | ?]
```

```
netsh dnsclient add dnsserver [name=]<string> [address=]<IP address> [[index=]<integer>] [[validate=]yes|no]
netsh dnsclient add encryption [server=]<IP address> [dohtemplate=]<string> [dothost=]<hostname>:<port> [[autoupgrade=]yes|no] [[udpfallback=]yes|no]
netsh dnsclient add global [[doh=]yes|no|auto] [[dot=]yes|no] [[ddr=]yes|no]
netsh dnsclient add interface [name=]<string> [[ddr=]yes|no] [[ddrfallback=]yes|no]
```

```
netsh dnsclient delete dnsserver [name=]<string> [address=]<IP address> [[index=]<integer>] [[validate=]yes|no]
netsh dnsclient delete encryption [server=]<IP address> [[protocol=]doh|dot]
netsh dnsclient delete global [global=](doh|dot|ddr|all)
netsh dnsclient delete interface [name=]<string> [setting=](ddr|all)
```

```
netsh dnsclient <dump>
```

```
netsh dnsclient set dnsserver [name=]<string> [source=]dhcp|static [[address=]<IP address>|none] [[register=]none|primary|both] [[validate=]yes|no]
netsh dnsclient set encryption [server=]<IP address> [dohtemplate=]<string> [dothost=]<hostname>:<port> [[autoupgrade=]yes|no] [[udpfallback=]yes|no]
netsh dnsclient set global [[doh=]yes|no|auto] [[dot=]yes|no] [[ddr=]yes|no]
netsh dnsclient set interface [name=]<string> [[ddr=]yes|no] [[ddrfallback=]yes|no]
```

```
netsh dnsclient show encryption [[server=]<IP address>]
netsh dnsclient show [global | state]
```

## Parameters

| Parameter | Description |
|--|--|
| add dnsserver `name=<string>` `address=<IP address>` `index=<integer>` `validate=<yes|no>` | Adds a new DNS server IP address to the statically configured list. By default, the DNS server is appended to the end of the list. If an index is specified, the server is inserted at that position, shifting other entries as needed. If DNS servers were previously assigned via DHCP, the new address replaces the existing list. When the validate option is set to `yes`, the newly added DNS server is validated. <br><br> **name** - The name or index of the network interface to which the DNS server is added. <br> **address** - The IP address of the DNS server to add. <br> **index** - Sets the order of preference for the DNS server address. <br> **validate** - Determines whether the DNS server address should be validated. Defaults to `yes`. |
| add encryption `server=<IP address>` `dohtemplate=<string>` `dothost=<hostname>:<port>` `autoupgrade=<yes|no>` `udpfallback=<yes|no>` | Adds a new encrypted DNS server to the list of statically configured secure resolvers. <br><br> **server** - Specifies the IP address of the encrypted DNS server to add. <br> **dohtemplate** - Defines the DoH template to use for the server. <br> **dothost** - Sets the DoT host for the server. Format: `hostname:port`. Use `:` for the default configuration. <br> **autoupgrade** - Indicates whether queries to this server should automatically upgrade to DoH or DoT. <br> **udpfallback** - Determines if UDP/TCP should be used for this server if DoH queries fail. |
| add global `doh=<yes|no|auto>` `dot=<yes|no>` `ddr=<yes|no>` | Adds a global DNS configuration <br><br> **doh** - Configures the global DoH settings. `No` disables DoH for the DNS client.`Yes` enables DoH usage according to interface, server, or other configurations. `Auto` forces all recognized DoH servers to use only DoH. <br> **dot** - Configures the global DoT settings. `No` - disables DoT for the DNS client. `Yes` enables DoT usage according to interface, server, or other configurations. <br> **ddr** - Configures the global Discovery of Designated Resolvers (DDR) settings. `No` disables DDR for the DNS client. `Yes` enables DDR usage according to interface, server, or other configurations. |
| add interface `name=<string>` `ddr=<yes|no>` `ddrfallback=<yes|no>` | Adds or configures DNS client settings for a specific network interface.<br><br> **name** - The name or index of the network interface to configure.<br> **ddr** - Enables or disables DDR for unencrypted DNS servers on the specified adapter. `Yes` performs DDR on all unencrypted servers configured for the adapter. `No` doesn't perform DDR by default on unencrypted servers for the adapter. <br> **ddrfallback** - Specifies whether to allow fallback to unencrypted name resolution if secure resolution using DDR fails. `Yes` enables fallback to unencrypted name resolution. `No` disables fallback to unencrypted name resolution (default: disabled). |
| delete dnsserver `name=<string>` `address=<IP address>` `index=<integer>` `validate=<yes|no>` | Removes statically configured DNS server IP addresses from a specified interface. If the `validate` option is set to `yes`, the remaining DNS servers are validated after deletion. <br><br> **name** - Specifies the name or index of the network interface from which DNS servers are deleted. <br> **address** - Indicates which DNS server addresses to remove. You can specify a particular IP address to delete a single DNS server, or use `all` to remove all configured DNS server addresses from the interface. <br> **validate** - Determines whether the DNS server settings should be validated after deletion. By default, validation is enabled (`yes`). |
| delete encryption `server=<IP address>` `protocol=<doh|dot>` | Deletes encrypted DNS server configurations from the list of statically configured secure resolvers. <br><br> **server** - Specifies the IP address for the encrypted DNS server removal. <br> **protocol** - Specifies the encryption protocol removal from the server. |
| delete global `global=<doh|dot|ddr|all>` | Restores the DNS settings to default values. <br><br> **all** - Restores all settings to their default values. <br> **doh** - Restores the default DoH global setting. <br> **dot** - Restores the default DoT global setting. <br> **ddr** - Restores the default DDR global setting. |
| delete interface `name=<string>` `setting=<ddr|all>` | Restores the interface DNS settings to default values. <br><br> **name** - Specifies the name or index of the network interface whose DNS settings you want to restore to default. <br> **setting** - Indicates which DNS setting on the interface should be reset. Use `all` to restore all settings to their default values, or `ddr` to restore only the DDR setting to its default. |
| dump | Outputs a configuration script containing the current DNS client settings. |
| set dnsserver `name=<string>` `source=<dhcp|static>` `address=<IP address>|none` `register=<none|primary|both>` `validate=<yes|no>` | Configures the DNS server settings to use either DHCP or a static list of DNS server IP addresses for the specified interface. The `address` option is available only when the source is set to `static`. If the `validate` option is set to `yes`, the newly configured DNS server is validated. <br><br> **name** - Specifies the name or index of the network interface. <br> **source** - Determines how DNS servers are configured for the interface. Use `dhcp` to obtain DNS servers automatically via DHCP, or `static` to specify DNS servers manually. <br> **address** - Sets the DNS server IP address. Provide an IP address to add a DNS server, or use `none` to clear the list of DNS servers. <br> **register** - Controls Dynamic DNS registration. Use `none` to disable registration, `primary` to register only under the primary DNS suffix, or `both` to register under both the primary and connection-specific suffixes. <br> **validate** - Indicates whether the DNS server setting should be validated. Default value is `yes`. |
| set encryption `server=<IP address>` `dohtemplate=<string>` `dothost=<hostname>:<port>` `autoupgrade=<yes|no>` `udpfallback=<yes|no>` | Configures the encrypted DNS server settings in the list of statically defined secure resolvers. <br><br> **server** - Specifies the IP address of the encrypted DNS server to modify. <br> **dohtemplate** - Defines the DoH template to use for the server. <br> **dothost** - Sets the DoT host for the server. Provide as `hostname:port`. Use `:` for the default configuration. <br> **autoupgrade** - Indicates whether queries to this server should automatically upgrade to DoH or DoT. <br> **udpfallback** - Determines if UDP/TCP should be used for this server if DoH queries fail. |
| set global `doh=<yes|no|auto>` `dot=<yes|no>` `ddr=<yes|no>` | Configures the global DNS configuration. <br><br> **doh** - Is the global DoH setting. `No` forbids the use of DoH by the DNS client. `Yes` allows DoH use based on interface, server, or other configurations. `Auto` forces all well-known DoH servers to use only DoH. <br> **dot** - Is the global DoT setting. `No` forbids the use of DoT by the DNS client. `Yes` allows DoT use based on interface, server, or other configurations. <br> **ddr** - Is the global DDR setting. `No` disables the use of DDR by the DNS client. `Yes` enables DDR use based on interface, server, or other configurations. |
| set interface `name=<string>` `ddr=<yes|no>` `ddrfallback=<yes|no>` | Configures interface specific DNS settings. <br><br> **name** - Specifies the name or index of the interface to be configured. <br> **ddr** - Specifies the interface-specific DDR settings. `Yes` performs DDR on all unencrypted servers configured on the specified adapter. `No` doesn't perform DDR by default on unencrypted servers configured on the specified adapter. <br> **ddrfallback** - Specifies if servers should fall back to unencrypted name resolution if secure resolution using DDR-retrieved settings fails, provided per-adapter DDR is enabled. Fallback is disabled by default. `Yes` enables fallback to unencrypted name resolution. `No` disables fallback to unencrypted name resolution. |
| show encryption `server=<IP address>` | Displays the encrypted DNS server settings from the list of statically configured secure resolvers. If no server is specified, information for all encrypted DNS servers is shown. <br><br> **server** - Specifies the encrypted DNS server by IP address. |
| show `<global>` | Displays all configured DNS global settings. |
| show `<state>` | Displays the current configuration and status of the DNS client. |
| help or ? | Provides help for the list of commands available in the `netsh dnsclient` context. |

## Examples

To add a DNS configuration or setting (for example, a specific DNS server address), run the following command:

```cmd
netsh dnsclient add dnsserver Ethernet=192.168.10.1
```

To delete a DNS configuration or setting (such as a specific DNS server address), run the following command:

```cmd
netsh dnsclient delete dnsserver Ethernet=192.168.10.1
```

To set a static DNS server address for a specific network interface, run the following command:

```cmd
netsh dnsclient set dnsserver name=Ethernet source=static address=192.168.10.1 register=primary validate=yes
```

To show globally configured DNS settings, run the following command:

```cmd
netsh dnsclient show global
```

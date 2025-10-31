---
title: netsh rpc
description: The netsh rpc command configures and manages Remote Procedure Call (RPC) service settings in Windows.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 08/20/2025
---

# netsh rpc

The `netsh rpc` command enables administrators to configure, manage, and troubleshoot Remote Procedure Call (RPC) service settings, including selective binding, firewall filtering, and access control for RPC traffic.

## Syntax

```
netsh rpc [add | delete | dump | filter | help | reset | show | ?]
```

```
netsh rpc add <subnet>
```

```
netsh rpc delete <subnet>
```

```
netsh rpc dump
```

```
netsh rpc filter add condition [field=]<string> [matchtype=]<string> [data=]<string>
netsh rpc filter add filter
netsh rpc filter add rule [layer=]<string> [actiontype=]<string> [[filterkey=]<string>]
                          [persistence=]volatile [audit=]enable [auditparameters=]enable
```

```
netsh rpc reset
```

```
netsh rpc show
```

## Parameters

| Command | Description |
|--|--|
| rpc `add` | Adds one or more subnets (IP address) to an "add" list managed by the RPC service. |
| rpc `delete` | Adds one or more subnets (IP address) to a "delete" list, implying these subnets are to be removed from existing configurations. |
| rpc `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| rpc `filter add condition` | Creates precise firewall rules to control RPC traffic based on specific conditions. <br><br> `field=<string>` - Specifies the aspect of the RPC communication where the condition applies. For `um` (User Mode), acceptable values are: <li> `if_uuid` - Interface UUID <li> `if_version` - Interface version <li> `if_flag` - Interface flag <li> `dcom_app_id` - DCOM Application ID <li> `image_name` - The executable image involved in the RPC call <li> `protocol` - Protocol used (like TCP) <li> `auth_type` - Type of authentication used <li> `auth_level` - Level of authentication enforced <li> `sec_encrypt_alg` - Security encryption algorithm <li> `sec_key_size` - Size of the security key <li> `remote_user_token` - Token for remote user authentication <li> `local_addr_v4` - Local IPv4 address <li> `local_addr_v6` - Local IPv6 address <li> `remote_addr_v4` - Remote IPv4 address <li> `remote_addr_v6` - Remote IPv6 address <li> `local_port` - Local communication port <li> `pipe` - Named pipe used in the connection <li> `opnum` - Operation number </li><br> For `epmap` (Endpoint Mapper), acceptable values are: <li>   Similar values as user mode but without `opnum`. <br> For `ep_add` (Endpoint Address), acceptable values are: <li> `process_with_if_uuid` - Process associated with the interface UUID <li> `protocol`: Protocol used <li> `ep_value` - Endpoint value <li> `ep_flags` - Flags related to the endpoint. </li><br> For `proxy_conn` (Proxy Connection), acceptable values are: `server_name`: Name of the server involved <li> `server_port` - Port on the server <li> `proxy_auth_type` - Type of proxy authentication <li> `client_token` - Token for client authentication <li>  `client_cert_key_name` - Name of the client's certificate key <li> `client_cert_oid` - OID of the client's certificate </li><br> For `proxy_if` (Proxy Interface), acceptable values are: <li> Similar to `proxy_conn`, with some overlapping fields. <br><br> `matchtype=<string>` - Determines the type of comparison or match conducted on the field's value. Acceptable values are: <li> `equal` - Exact match <li> `greater` - Greater than a specified value <li> `less` - Less than a specified value <li> `greater_or_equal` - Greater than or equal to a specified value <li> `less_or_equal` - Less than or equal to a specified value <li> `range` - Within a specified range <li> `all_set` - Bitwise matching commonly used for flags or settings that use bit fields <li> `any_set` - Bitwise matching commonly used for flags or settings that use bit fields <li> `none_set` - Bitwise matching commonly used for flags or settings that use bit fields </li><br> `data=<string>` - The actual value used in the condition that corresponds to the specified field. |
| rpc `filter add filter` | Adds an RPC firewall filter. Before you can add a filter, you must first define at least one rule and one or more conditions. |
| rpc `filter add rule` | Adds an RPC firewall filter rule. <br><br> `layer=<string>` - Specifies the layer where the filter is applied. Acceptable values are: <li> `um` - User Mode <li> `epmap` - Endpoint Mapper <li> `ep_add` - Endpoint Address <li> `proxy_conn` - Proxy Connection <li> `proxy_if` - Proxy Interface </li><br> `actiontype=<string>` - Defines the action to take when the filter matches. Acceptable values are: <li> `block` - Blocks the RPC traffic <li> `permit` - Allows the RPC traffic. <li> `continue` - Continues to the next filter for evaluation. </li><br> `filterkey=<string>` - Specifies a unique UUID that identifies the RPC firewall filter. Useful for managing or referencing specific filters. <br> `persistence` - Determines whether the filter remains after a reboot. By default, filters are persistent. <br> `audit` - Enables auditing for this filter. Only filters with the "permit" action type can have auditing enabled. Auditing isn't supported at the `ep_add` layer. <br> `auditparameters` - Enables auditing of RPC call parameter buffers for this filter. Requires `audit` to be enabled. Auditing of parameters is only supported at the `um` layer. |
| rpc `reset` | Resets the selective binding configuration so that the system listens on all network interfaces (no subnets are restricted). |
| rpc `show` | Displays the current selective binding configuration, listing each subnet and its binding state on the system. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To add the specified subnet `192.168.1.0` to the RPC "add list", run the following command:

```cmd
netsh rpc add 192.168.1.0
```

To add a filter condition that applies to RPC traffic where the local IPv4 address is exactly `192.168.1.10`, run the following command:

```cmd
netsh rpc filter add condition field=local_addr_v4 matchtype=equal data=192.168.1.10
```

To apply a rule to the Endpoint Mapper layer permitting traffic for a specific UUID, along with persistence after a reboot and logged for auditing,  run the following command:

```cmd
netsh rpc filter add rule layer=epmap actiontype=permit filterkey={Your-UUID} persistence=yes audit=yes
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

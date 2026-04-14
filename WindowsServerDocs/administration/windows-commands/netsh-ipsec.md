---
title: netsh ipsec
description: The netsh ipsec command is a suite of commands that configures and manages Internet Protocol Security (IPsec) policies and settings in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/04/2025
---

# netsh ipsec

The `netsh ipsec` command is used to configure and manage Internet Protocol Security (IPsec) policies and settings. IPsec is a comprehensive protocol suite that secures network communications by authenticating and encrypting each IP packet within a communication session, ensuring the confidentiality, integrity, and authenticity of the data being transmitted.

## Syntax

```
netsh ipsec [dump | dynamic | help | static | ?]
```

```
netsh ipsec dynamic add mmpolicy [name=]<string> [qmpermm=]<integer> [mmlifetime=]<integer> [softsaexpirationtime=]<integer> [mmsecmethods=](sec#1 sec#2 ... sec#n)
netsh ipsec dynamic add qmpolicy [name=]<string> [soft=](yes|no) [pfsgroup=](GRP1|GRP2|GRP3|GRPMM|NOPFS) [qmsecmethods=](neg#1 neg#2 ... neg#n)
netsh ipsec dynamic add rule [srcaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server) [dstaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server)
                             [mmpolicy=]<string> [qmpolicy=]<string> [protocol=](ANY|ICMP|TCP|UDP|RAW|<integer>) [srcport=]<port> [dstport=]<port>
                             [mirrored=](yes|no) [conntype=](lan|dialup|all) [actioninbound=](permit | block | negotiate) [actionoutbound=](permit|block|negotiate)
                             [srcmask=](mask|prefix) [dstmask=](mask|prefix) [tunneldstaddress=](ip|dns) [kerberos=](yes|no) [psk=]<preshared key>
                             [rootca=]"<certificate> certmap:(yes|no) excludecaname:(yes|no)"
```

```
netsh ipsec dynamic delete <all> [[mmpolicy|qmpolicy [name=]<string>|all]
netsh ipsec dynamic delete rule [srcaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server) [dstaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server)
                                [protocol=](ANY|ICMP|TCP|UDP|RAW|<integer>) [srcport=]<port> [dstport=]<port> [mirrored=](yes|no)
                                [conntype=](lan|dialup|all) [srcmask=](mask|prefix) [dstmask=](mask|prefix) [tunneldstaddress=](ip|dns)
```

```
netsh ipsec <dump>
```

```
netsh ipsec static add filter [filterlist=]<string> [srcaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server)
                              [dstaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server)
                              [description=]<string> [protocol=](ANY|ICMP|TCP|UDP|RAW|<integer>)
                              [mirrored=](yes|no) [srcmask=](mask|prefix) [dstmask=](mask|prefix) [srcport=]<port> [dstport=]<port>
```

```
netsh ipsec static add filteraction [name=]<string> [description=]<string> [qmpfs=](yes|no) [inpass=](yes|no)
                                    [soft=](yes|no) [action=](permit|block|negotiate) [qmsecmethods=](neg#1 neg#2 ... neg#n)
```

```
netsh ipsec static add filterlist [name=]<string> [description=]<string>
```

```
netsh ipsec static add policy [name=]<string> [description=]<string> [mmpfs=](yes|no) [qmpermm=]<integer> [mmlifetime=]<integer>
                              [activatedefaultrule=](yes|no) [pollinginterval=]<integer> [assign=](yes|no) [mmsecmethods=](sec#1 sec#2 ... sec#n)
```

```
netsh ipsec static add rule [name=]<string> [policy=]<string> [filterlist=]<string> [filteraction=]<string> [tunnel=](ip|dns)
                            [conntype=](lan|dialup|all) [activate=](yes|no) [description=]<string> [kerberos=](yes|no)
                            [psk=]<preshared key> [rootca=]"<certificate> certmap:(yes|no) excludecaname:(yes|no)"
```

```
netsh ipsec static delete filter [filterlist=]<string> [srcaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server)
                                 [dstaddr=](ipv4|ipv6|ipv4-ipv4|ipv6-ipv6|dns|server) [protocol=](ANY|ICMP|TCP|UDP|RAW|<integer>)
                                 [mirrored=](yes|no) [srcmask=](mask|prefix) [dstmask=](mask|prefix) [srcport=]<port> [dstport=]<port>
```

```
netsh ipsec static delete [filteraction | filterlist | policy] [name=]<string>
netsh ipsec static delete all
```

```
netsh ipsec static delete rule [name=]<string> [id=]<integer> [all] [policy=]<string>
```

```
netsh ipsec static [exportpolicy | importpolicy] [file=]<string>
```

```
netsh ipsec static set batch [mode=](enable|disable)
```

```
netsh ipsec static set defaultrule [policy=]<string> [qmpfs=](yes|no) [activate=](yes|no) [qmsecmethods=](neg#1 neg#2 ... neg#n)
                                   [kerberos=](yes|no) [psk=]<preshared key> [rootca=]"<certificate> certmap:(yes|no) excludecaname:(yes|no)"
```

```
netsh ipsec static set filteraction [name=]<string> [guid=]<guid> [newname=]<string> [description=]<string> [qmpfs=](yes|no)
                                    [inpass=](yes|no) [soft=](yes|no) [action=](permit|block|negotiate) [qmsecmethods=](neg#1 neg#2 ... neg#n)
```

```
netsh ipsec static set filterlist [name=]<string> [guid=]<guid> [newname=]<string> [description=]<string>
```

```
netsh ipsec static set policy [name=]<string> [guid=]<guid> [newname=]<string> [description=]<string> [mmpfs=](yes|no) [qmpermm=]<integer>
                              [mmlifetime=]<integer> [activatedefaultrule=](yes|no) [pollinginterval=]<integer> [assign=](yes|no)
                              [gponame=]<string> [mmsecmethods=](sec#1 sec#2 ... sec#n)
```

```
netsh ipsec static set rule [name=]<string> [id=]<integer> [policy=]<string> [newname=]<string> [description=]<string> [filterlist=]<string>
                            [filteraction=]<string> [tunnel=](ip|dns) [conntype=](lan|dialup|all) [activate=](yes|no) [kerberos=](yes|no)
                            [psk=]<preshared key> [rootca=]"<certificate> certmap:(yes|no) excludecaname:(yes|no)"
```

```
netsh ipsec static set store [location=](local|domain) [domain=]<string>
```

```
netsh ipsec static show all [format=](list|table) [wide=](yes|no)
```

```
netsh ipsec static show filteraction [name=]<string> [rule=]<string> [all] [level=](verbose|normal)
                                     [format=](list|table) [wide=](yes|no)
```

```
netsh ipsec static show filterlist [name=]<string> [rule=]<string> [all] [level=](verbose|normal)
                                   [format=](list|table) [resolvedns=](yes|no) [wide=](yes|no)
```

```
netsh ipsec static show gpoassignedpolicy [name=]<string>
```

```
netsh ipsec static show policy [name=]<string> [all] [level=](verbose|normal) [format=](list|table) [wide=](yes|no)
```

```
netsh ipsec static show rule [name=]<string> [id=]<integer> [all] [default] [policy=]<string> [type=](tunnel|tranport)
                             [level=](verbose|normal) [format=](list|table) [wide=](yes|no)
```

```
netsh ipsec static show <store>
```

## Parameters

| Command | Description |
|--|--|
| ipsec `dynamic add mmpolicy` | Adds a Main Mode policy to the Security Policy Database (SPD). <br><br> `softsaexpirationtime` - Specifies the time, in *seconds*, before a soft expiration of the security association. <br><br> Other subparameters: <li> `name` <li> `qmpermm` <li> `mmlifetime` <li> `mmsecmethods` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `dynamic add qmpolicy` | Adds a Quick Mode policy to the SPD. <br><br> `pfsgroup` - Specifies the Perfect Forward Secrecy (PFS) group for key exchange. Options are: <li> `GRP1`, `GRP2`, `GRP3` - Specifies different Diffie-Hellman groups (security levels). <li> `GRPMM` - Specifies the Main Mode group. <li> `NOPFS` - Specifies no PFS (default setting). <br><br> Other subparameters: <li> `name` <li> `soft` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `dynamic add rule` | Adds a new IPsec rule to the dynamic policy configuration. Unlike static policies, dynamic policies are typically temporary and can be used for testing, troubleshooting, or temporarily modifying security configurations without changing the permanent static policy settings. <br><br> `actioninbound` -  Specifies the action to be taken on inbound traffic. <br> `actionoutbound` - Specifies the action to be taken on outbound traffic. <br><br> Options are: <li> `permit`: Allows the matching traffic to pass through without any IPsec protection. <li> `block`: Prevents the matching traffic from passing through. <li> `negotiate`: Requires that the matching traffic performs IPsec negotiation to establish a secure connection. <br><br> Other subparameters: <li> `srcaddr` <li> `dstaddr` <li> `mmpolicy` <li> `qmpolicy` <li> `protocol` <li> `srcport` <li> `dstport` <li> `mirrored` <li> `conntype` <li> `srcmask` <li> `dstmask` <li> `tunneldstaddress` <li> `kerberos` <li> `psk` <li> `rootca` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `dynamic delete all` | Removes *all* dynamic IPsec rules from the current policy configuration. <br><br> Other subparameters: <li> `mmpolicy` <li> `qmpolicy` <li> `name` <li> `all` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `dynamic delete rule` | Removes a specific IPsec rule from the dynamic policy configuration. When you execute this command, you're instructing the system to delete a rule that was dynamically added to the IPsec policy engine. This action affects how network traffic is treated in terms of security policies. <br><br> Other subparameters: <li> `srcaddr` <li> `dstaddr` <li> `protocol` <li> `srcport` <li> `dstport` <li> `mirrored` <li> `conntype` <li> `srcmask` <li> `dstmask` <li> `tunneldstaddress` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `dump` | Exports the current IPsec configuration settings to a text file. |
| ipsec `static add filter` | Adds a specific traffic filter to an existing IPsec policy. This filter defines which network traffic (based on criteria like IP addresses, protocols, and ports) is subject to the security rules and actions specified by the IPsec policy. <br><br> Other subparameters: <li> `filterlist` <li> `srcaddr` <li> `dstaddr` <li> `description`  <li> `protocol` <li> `mirrored` <li> `srcmask` <li> `dstmask` <li> `srcport` <li> `dstport` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static add filteraction` | Adds a filter action within an IPsec policy. A filter action specifies the actions that should be taken on traffic that matches the criteria of an IPsec filter. These actions determine how matching traffic is handled, such as whether it should be allowed, blocked, or secured. <br><br> Other subparameters: <li> `name` <li> `description` <li> `qmpfs` <li> `inpass` <li> `soft` <li> `action` <li> `qmsecmethods` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static add filterlist` | A new filter list in an IPsec policy configuration in Windows. A filter list is essentially a collection of one or more filters, each defining specific criteria for network traffic, such as source and destination IP addresses, ports, and protocols. <br><br> Other subparameters: <li> `name` <li> `description` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static add policy` | Adds a new IPsec policy. This command doesn't apply any specific rules or filters by itself, rather, it serves as the starting point for defining how you want to manage or secure network traffic on the device. <br><br> Other subparameters: <li> `name` <li> `description` <li> `mmpfs` <li> `qmpermm` <li> `mmlifetime` <li> `activatedefaultrule` <li> `pollinginterval` <li> `assign` <li> `mmsecmethods` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static add rule` | Adds a rule to an existing IPsec policy. Once you've created an IPsec policy, you'll typically need to define specific rules that dictate how traffic matching certain criteria should be handled. <br><br> Other subparameters: <li> `name` <li> `policy` <li> `filterlist` <li> `filteraction` <li> `tunnel` <li> `conntype` <li> `activate` <li> `description` <li> `kerberos` <li> `psk` <li> `rootca` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static delete filter` | Removes a specified filter from the IPsec configuration. Filters in IPsec are used to define criteria for matching network traffic, such as specifying particular IP addresses, protocols, or port numbers to which certain rules or actions should apply. <br><br> Other subparameters: <li> `filterlist` <li> `srcaddr` <li> `dstaddr` <li> `protocol` <li> `mirrored` <li> `srcmask` <li> `dstmask` <li> `srcport` <li> `dstport` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static delete all` <br><br> netsh `ipsec static delete` [`filteraction` \| `filterlist` \| `policy`] | Removes `all` IPsec policies, rules, filters, filter actions, and associated components from the system. This command can also remove *specific* components or from the IPsec configuration. <br><br> Other subparameters: <li> `name` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static delete rule` | Removes a specific rule from an existing IPsec policy. <br><br> Other subparameters: <li> `name` <li> `id` <li> `all` <li> `policy` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static` [`exportpolicy` \| `importpolicy`] `file=<string>` | This command is used to manage the export and import of IPsec policies, allowing you to save or load IPsec configurations to or from a file. This can be useful for backing up configurations or applying the same configuration to multiple systems. <br><br><li> `exportpolicy` - Exports the current IPsec policy configuration to a specified file. <li>  `importpolicy` - Imports an IPsec policy configuration from a specified file. <li> `file` - Specifies the path and name of the file you wish to use for exporting or importing the policy. |
| ipsec `static set batch` `mode=(enable|disable)` | Executes multiple IPsec commands in a group, reducing the chances of policy inconsistencies during changes. When you enable batch mode, you can enter multiple IPsec commands, and they're queued up. Once you complete entering the commands and exit batch mode, the policy changes are applied all at once. <br><br> When you **enable** batch mode, it allows multiple IPsec policy commands to be processed as a batch, which means they can be applied together to minimize the time during which policy changes might be inconsistent or incomplete. When you **disable** batch mode, each command is executed independently as you enter them. |
| ipsec `static set defaultrule` | Configures the default IPsec rule that is applied in the absence of more specific rules. <br><br> Other subparameters: <li> `policy` <li> `qmpfs` <li> `activate` <li> `qmsecmethods` <li> `kerberos` <li> `psk` <li> `rootca` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static set filteraction` | Modifies the action associated with a specific IPsec filter. Filter actions determine how traffic is handled, such as permitting or blocking it. <br><br> Other subparameters: <li> `name` <li> `guid` <li> `newname` <li> `description` <li> `qmpfs` <li> `inpass` <li> `soft` <li> `action` <li> `qmsecmethods` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static set filterlist` | Updates an existing filter list, which consists of filters defining which traffic is affected by IPsec policies. <br><br> Other subparameters: <li> `name` <li> `guid` <li> `newname` <li> `description` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static set policy` | Alters the rules and settings for secure communication, including filter lists and actions set in the IPsec policy. <br><br> `gponame` - Specifies the name of the Group Policy Object (GPO) where the IPsec policy is set. <br><br> Other subparameters: <li> `name` <li> `guid` <li> `newname` <li> `description` <li> `mmpfs` <li> `qmpermm` <li> `mmlifetime` <li> `activatedefaultrule` <li> `pollinginterval` <li> `assign` <li> `mmsecmethods` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static set rule` | Modifies a specific IPsec rule within a policy. <br><br> Other subparameters: <li> `name` <li> `id` <li> `policy` <li> `newname` <li> `description` <li> `filterlist` <li> `filteraction` <li> `tunnel` <li> `conntype` <li> `activate` <li> `kerberos` <li> `psk` <li> `rootca` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static set store` | Specifies which configuration store, either the local policy store or the Active Directory-based store, that the IPsec commands apply to when you configure or view IPsec settings. <br><br> `location` - Specifies where the IPsec policies are stored. Options are: <br> `local`: Indicates that the policies are stored on the local computer. <br> `domain`: Indicates that the policies are stored in a domain-level policy, which is managed through Active Directory (AD). <br><br> `domain=` : Designates the domain name when the `location` is set to `domain`. Replace `<string>` with the actual domain name you're using. This is applicable only if the location is specified as `domain`, and it determines which domain's policies are being accessed or altered. |
| ipsec `static show all` | Displays all *currently* configured IPsec policies, rules, filter lists, and actions. <br><br> Other subparameters: <li> `format` <li> `wide` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show filteraction` | Displays details about the filter actions configured in the system. <br><br> `resolvedns` - Specifies whether to resolve and display the Domain Name System (DNS) names for the IP addresses in the filter list. Options are: <br> `yes`: The command attempts to resolve the IP addresses to their corresponding DNS names. <br> `no`: The command displays the raw IP addresses without attempting DNS resolution. <br><br> Other subparameters: <li> `name` <li> `rule` <li> `all` <li> `level` <li> `format` <li> `wide` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show filterlist` | Displays the filter lists defined in the system, which helps identify how traffic is matched against policy rules. <br><br> Other subparameters: <li> `name` <li> `rule` <li> `all` <li> `level` <li> `format` <li> `wide` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show gpoassignedpolicy` | Displays the IPsec policies assigned through GPO. <br><br> Other subparameters: <li> `name` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show policy` | Displays detailed information about *specific* IPsec policies, including rules, filters, and actions. <br><br> Other subparameters: <li> `name` <li> `all` <li> `level` <li> `format` <li> `wide` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show rule` | Displays information for a specified IPsec rule. <br><br> Other subparameters: <li> `name` <li> `id` <li> `all` <li> `policy` <li> `type` <li> `level` <li> `format` <li> `wide` </li><br> See [Remarks](#remarks) for description details. |
| ipsec `static show store` | Displays the current store context that is being used for IPsec commands. It shows whether the commands are targeting the local policy store or the Active Directory-based store. |

## Remarks

- **name**: This is the *name* you set for the mmpolicy, qmpolicy, filteraction, filterlist, policy, rule, or gpoassignedpolicy.

- **qmpermm**: Specifies the *number* of Quick Mode sessions allowed per Main Mode session in Internet Key Exchange (IKE) .

- **mmlifetime**: Specifies the duration, in *minutes*, before the Main Mode security association is renegotiated in IKE.

- **mmsecmethods**: Specifies one or more security methods, separated by spaces, using the format *"ConfAlg-HashAlg-GroupNum"*.

  - **ConfAlg**: Encryption algorithm, such as `DES` or `3DES`.

  - **HashAlg**: Hash algorithm, such as `MD5` or `SHA1`.

  - **GroupNum**: Diffie-Hellman group number, where `1` = Low, `2` = Medium, `3` = DH2048.

  The use of DES and MD5 isn't recommended. These cryptographic algorithms are provided for backward compatibility only.

- **soft**: Specifies whether to permit unsecured communication with computers that don't support IPsec using `yes` or `no` values.

- **qmsecmethods**: Specifies the IPsec security offer using one of the following formats:

  - *ESP[ConfAlg,AuthAlg]:k/s*

  - *AH[HashAlg]:k/s*

  - *AH[HashAlg]+ESP[ConfAlg,AuthAlg]:k/s*

    Where:

    - **ConfAlg**: Encryption algorithm (`DES`, `3DES`, or `None`)

    - **AuthAlg**: Authentication algorithm (`MD5`, `SHA1`, or `None`)

    - **HashAlg**: Hash algorithm (`MD5` or `SHA1`)

    - **k**: Lifetime in kilobytes

    - **s**: Lifetime in seconds

- **srcaddr** / **dstaddr**: Specifies the source address (starting point of the network traffic) and destination address (endpoint of the network traffic) respectively. Options are:

  - `ipv4`: Designates an IPv4 address.

  - `ipv6`: Designates an IPv6 address.

  - `ipv4-ipv4`: Represents an IPv4 range.

  - `ipv6-ipv6`: Represents an IPv6 range.

  - `dns`: Uses a DNS name to specify the source *or* the destination.

  - `server`: Refers to a server address.

- **mmpolicy**: Refers to the Main Mode policy to be used for the rule. Main Mode policies define the security settings for establishing secure, authenticated communications.

- **qmpolicy**: Indicates the Quick Mode policy to be used, which defines the security settings for maintaining secured traffic after the initial connection is established.

- **protocol**: This parameter allows you to match the rule to target specific IP protocols. Options are:

  - `ANY`: Allows all protocols.

  - `ICMP`: Also represented by the protocol *number* `1`.

  - `TCP`: Also represented by the protocol *number* `6`.

  - `UDP`: Also represented by the protocol *number* `17`.

  - `RAW`: Represents raw socket access, which allows applications to have direct access to lower-level protocols. This can be useful for applications that need to construct their own packet headers or work outside the standard transport protocols.

- **srcport**: Defines the source *port number* for the traffic. This parameter specifies the port from which traffic originates.

- **dstport**: Defines the destination *port number* for the traffic. This parameter specifies the port to which traffic is sent.

- **mirrored**: Indicates whether the rule should automatically be applied in both directions. Values are `yes` or `no`.

- **conntype**: Specifies the type of connection. This determines the network interface to which the rule applies. Options include:

  - `lan`: Specifies that the rule addition or removal applies only to a Local Area Network (LAN) or wireless connection.

  - `dialup`: Specifies that the rule addition or removal applies only to dial-up (phone line) connection.

  - `all`:  Specifies that the rule addition or removal applies to all types of network connections.

- **srcmask**: Defines the *source* address mask or prefix to be used. This parameter allows for subnet or prefix-based matching of source addresses.

- **dstmask**: Defines the *destination* address mask or prefix to be used. This parameter allows for subnet or prefix-based matching of destination addresses.

- **tunneldstaddress**: Specifies the tunnel destination address, which can be an `ip` address or `dns` name. This is used when setting up tunnel mode IPsec rules.

- **kerberos**: Indicates whether Kerberos authentication is used. Options are `yes` or `no`.

- **psk**: Refers to the pre-shared key used in authentication. Specifying this parameter is necessary if the authentication method you're configuring relies on it. If you're using a different type of authentication, such as certificates, then the `psk` parameter isn't used.

- **rootca**: Provides options for root certificate authorities. The `certmap` option determines whether certificates are mapped (`yes` or `no`), and `excludecaname` determines if CA names are excluded (`yes` or `no`).

- **description**: Specifies a *description* you give to a filter, filteraction, filterlist, policy, or rule.

- **qmpfs**: Specifies whether Quick Mode Perfect Forward Secrecy (PFS) is required. PFS ensures that session keys aren't compromised even if the server's private key is compromised. Options are `yes` or `no`.

- **inpass**: Specifies whether inbound traffic should be permitted to pass through unprotected. Options are `yes` or `no`.

- **guid**: Specifies the GUID corresponding to a filteraction, filterlist, or policy.

- **newname**: Specifies a new name that you want to assign to an existing filteraction, filterlist, policy, or rule.

- **mmpfs**: Specifies whether Main Mode Perfect Forward Secrecy (PFS) should be used. PFS ensures that if one session's keys are compromised, it doesn't affect the security of subsequent sessions. Options are `yes` or `no`.

- **id**: Specifies the unique ID of the rule you wish to delete, configure, or display.

- **all**: Specifies one of the following actions:

  - Deletes all dynamic or static IPsec configurations or rules.

  - Displays all static, filteraction, filterlist, policies, or rules for the IPsec settings.

- **policy**: Specifies a particular IPsec policy by its name. The `<string>` value should be replaced with the actual name of the IPsec policy you wish to target.

- **pollinginterval**: Specifies the interval, in *seconds*, which the system checks for changes in the IPsec policy.

- **assign**: Specifies whether the newly created or modified IPsec policy should be set as the active policy. Options are `yes` or  `no`.

- **action**: This parameter specifies the type of action that should be taken when a packet matches a particular IPsec filter. Options are:

  - `permit`: Allows the matching traffic to pass through without any IPsec protection.

  - `block`: Prevents the matching traffic from passing through.

  - `negotiate`: Requires that the matching traffic performs IPsec negotiation to establish a secure connection.

- **filterlist**: Specifies the *name* (the `<string>` value) of the filter list you created or wish to reference.

- **filteraction**: Specifies the *name* (the `<string>` value) of the action you created within the IPsec policy. Options are:

  - `permit`: Allows the matching traffic to pass through without any IPsec protection.

  - `block`: Prevents the matching traffic from passing through.

  - `negotiate`: Requires that the matching traffic performs IPsec negotiation to establish a secure connection.

- **activate**: Specifies to activate (`yes`) or deactivate (`no`) a specific rule within a filter list, or the default rule for IPsec policies. The default rule typically applies to traffic that doesn't match any specific filters or rules.

- **activatedefaultrule**: Specifies whether the default rule within that policy should be active (`yes`) or inactive (`no`) from the start. This command is also used to modify (set) an existing IPsec policy to change the activation state of the default rule.

- **tunnel**: Specifies an addition or modification of how traffic is tunneled through a rule. Options are:

  - `ip`: This option specifies that the rule uses an IP address for the tunnel. You typically provide the tunnel's start and end IP addresses if you're configuring an IPsec tunnel mode.

  - `dns`: This option specifies that the rule uses DNS names to define the endpoints of the tunnel. This is useful when you want to set up tunnels using domain names rather than static IP addresses.

- **wide**: Shows detailed information in a more verbose format. Options are `yes` or  `no`.

- **level**: Specifies the amount of detail to dump in an output. Options are:

  - `verbose`: Provides a detailed, in-depth view, which can be useful for troubleshooting or comprehensive analysis.

  - `normal`: Displays standard information, offering a more general output.

- **format**: Specifies the presentation style of the output. Options are:

  - `list`: Displays the information in a list format, which is often easier to read for detailed inspection of individual entries.

  - `table`: Displays the information in a table format, which can be more compact and provide a quick comparison of multiple entries at a glance.

## Examples

To add a Main Mode IPsec policy named "MyMM-Policy" with 100 Quick Mode sessions, a 4800-minute lifetime, 1800-second soft expiration, and 3DES/SHA1 security, run the following command:

```cmd
netsh ipsec dynamic add mmpolicy name="MyMM-Policy" qmpermm=100 mmlifetime=4800 softsaexpirationtime=1800 mmsecmethods="3DES-SHA1"
```

To add a Quick Mode IPsec policy named "MyQM-Policy" with unsecured communication fallback enabled, set to group 2 PFS, and two security methods for ESP: 3DES/SHA1 and AES128/SHA256, run the following command:

```cmd
netsh ipsec dynamic add qmpolicy name="MyQM-Policy" soft=yes pfsgroup=GRP2 qmsecmethods="ESP:3DES-SHA1 ESP:AES128-SHA256"
```

To create a security rule that permits TCP traffic on port 80 between the source IP `192.168.1.10` and destination IP `192.168.1.20` over a LAN connection, using the 'MainModePolicy' and 'QuickModePolicy', run the following command:

```cmd
netsh ipsec dynamic add rule srcaddr=192.168.1.10 dstaddr=192.168.1.20 mmpolicy="MainModePolicy" qmpolicy="QuickModePolicy" protocol=TCP srcport=80 dstport=80 mirrored=no conntype=lan actioninbound=permit actionoutbound=permit
```

To delete all IPsec dynamic policies, including both main mode and quick mode policies, run the following command:

```cmd
netsh ipsec dynamic delete all
```

To delete a specific quick mode policy named "QuickModePolicy", run the following command:

```cmd
netsh ipsec dynamic delete qmpolicy name="QuickModePolicy"
```

To delete a specific IPsec rule that permits TCP traffic on port 80 between the source IP `192.168.1.10` and destination IP `192.168.1.20` over a LAN connection, run the following command:

```cmd
netsh ipsec dynamic delete rule srcaddr=192.168.1.10 dstaddr=192.168.1.20 protocol=TCP srcport=80 dstport=80 conntype=lan
```

To export the current IPsec configuration to a script file that can be used to reconfigure the system or another system with the same settings, run the following command:

```cmd
netsh ipsec dump > C:\Users\Admin\MyFolder\ipsec_settings.txt
```

To add an IPsec filter that permits TCP traffic on port `80` from source IP `192.168.1.10` to destination IP `192.168.1.20` with mirrored configuration, run the following command:

```cmd
netsh ipsec static add filter filterlist=MyWebTraffic srcaddr=192.168.1.10 dstaddr=192.168.1.20 protocol=TCP srcport=80 dstport=80 description="Allow web traffic" mirrored=yes
```

To create a filter action that allows traffic to pass without engaging in IPsec negotiation or encryption, run the following command:

```cmd
netsh ipsec static add filteraction name=AllowTraffic description="Permit traffic without negotiation" qmpfs=no inpass=yes soft=no action=permit
```

To create a new IPsec filter list for grouping related IPsec filters, run the following command:

```cmd
netsh ipsec static add filterlist name=WebTrafficFilters description="Filters for managing web traffic"
```

To create an IPsec policy named "SecurePolicy" that uses specific encryption methods and settings to protect sensitive network traffic, run the following command:

```cmd
netsh ipsec static add policy name=SecurePolicy description="Policy for securing sensitive traffic" mmpfs=yes qmpermm=50 mmlifetime=28800 activatedefaultrule=no pollinginterval=600 assign=yes mmsecmethods="3DES-SHA1 DHGroup2;AES128-SHA256 DHGroup14"
```

To add an IPsec rule named "WebServerRule" that implements security measures for LAN connections to a web server by using specified filter lists and actions with authentication, run the following command:

```cmd
netsh ipsec static add rule name=WebServerRule policy=SecurePolicy filterlist=WebTrafficFilters filteraction=AllowTraffic tunnel=no conntype=lan activate=yes description="Secures web server traffic with specified filters and Kerberos authentication" kerberos=yes
```

To delete a specific IPsec filter that manages TCP traffic between source IP `192.168.1.10` and destination IP `192.168.1.20` within the filter list "MyFilterList," run the following command:

```cmd
netsh ipsec static delete filter filterlist=MyFilterList srcaddr=192.168.1.10 dstaddr=192.168.1.20 protocol=TCP mirrored=yes srcport=80 dstport=80
```

To delete an IPsec rule named "WebServerRule" from the policy "SecurePolicy," run the following command:

```cmd
netsh ipsec static delete rule name=WebServerRule policy=SecurePolicy
```

To export all IPsec policies to a file named "MyPolicy.txt" for backup or transfer to another system, run the following command:

```cmd
netsh ipsec static exportpolicy file=C:\Policies\MyPolicy.txt
```

To enable batch mode for IPsec commands, which allows multiple IPsec operations to be executed as a single batch for efficiency, run the following command:

```cmd
netsh ipsec static set batch mode=enable
```

To set a default IPsec rule in the "SecurePolicy" policy with specific security methods and authentication settings, run the following command:

```cmd
netsh ipsec static set defaultrule policy=SecurePolicy qmpfs=yes activate=yes qmsecmethods="3DES-SHA1;AES128-SHA256" kerberos=yes psk=yourPreSharedKey
```

To modify an existing IPsec filter action named "OldActionName" by renaming it to "NewActionName" and setting specific security behaviors, run the following command:

```cmd
netsh ipsec static set filteraction name=OldActionName newname=NewActionName description="Updated filter action" qmpfs=yes inpass=no soft=no action=negotiate qmsecmethods="AES256-SHA1;AES128-SHA256"
```

To modify an existing IPsec filter list named "OldListName" by renaming it to "NewListName" and updating its description, run the following command:

```cmd
netsh ipsec static set filterlist name=OldListName newname=NewListName description="Updated filter list for enhanced security"
```

To update an existing IPsec policy named "OldPolicyName" by renaming it to "NewPolicyName" with reduced reauthentication frequency, and enhanced security settings, run the following command:

```cmd
netsh ipsec static set policy name=OldPolicyName newname=NewPolicyName description="Updated policy for enhanced security measures" mmpfs=yes qmpermm=100 mmlifetime=36000 activatedefaultrule=yes pollinginterval=1200 assign=no mmsecmethods="AES256-SHA1 DHGroup14;AES128-SHA256 DHGroup2"
```

To update an existing IPsec rule named "OldRuleName" by renaming it to "NewRuleName" within the policy "SecurePolicy," tunneling the LAN traffic by IP and incorporating specific security configurations, run the following command:

```cmd
netsh ipsec static set rule name=OldRuleName policy=SecurePolicy newname=NewRuleName description="Updated rule for enhanced server protection" filterlist=WebTrafficFilters filteraction=NegotiateSecurity tunnel=ip conntype=lan activate=yes kerberos=yes psk=mySecureKey
```

To store an IPsec policy in a domain location, run the following command:

```
netsh ipsec static set store location=domain domain=MyDomain.com
```

To display all IPsec policies in a list format with concise details, run the following command:

```
netsh ipsec static show all format=list wide=no
```

To display detailed information about a specific IPsec filter action with verbose output in a table format, run the following command:

```
netsh ipsec static show filteraction name="ExampleFilterAction" level=verbose format=table wide=yes
```

To display information about all IPsec filter lists with verbose output in a list format where DNS names aren't resolved to IPs, run the following command:

```
netsh ipsec static show filterlist all level=verbose format=list resolvedns=no wide=yes
```

To display the IPsec policy assigned to a GPO with the name "MyGPO," run the following command:

```
netsh ipsec static show gpoassignedpolicy name=MyGPO
```

To display detailed information about a specific IPsec policy called "MyPolicy," in a verbose, list format and without limiting the output width, run the following command:

```
netsh ipsec static show policy name=MyPolicy all level=verbose format=list wide=yes
```

To display detailed information about the IPsec rule named "MyRule" with an ID of `123` associated with the policy "MyPolicy," in verbose mode and formatted as a table without width restriction, run the following command:

```
netsh ipsec static show rule name=MyRule id=123 all policy=MyPolicy type=tunnel level=verbose format=table wide=yes
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

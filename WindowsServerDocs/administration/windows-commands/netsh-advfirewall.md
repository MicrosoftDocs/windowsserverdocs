---
title: netsh advfirewall
description: Reference article for the netsh command, which is a command-line scripting utility that allows you to display or modify the network configuration of a currently running computer locally or remotely.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/24/2025
---

# netsh advfirewall

The `netsh advfirewall` command configures and manages the Windows Firewall with Advanced Security utility. This tool allows administrators to configure firewall rules, security policies, and monitor various aspects of the firewall's behavior.

## Syntax

The `netsh advfirewall` command provides various subcommands and contexts based on the specific operation you want to perform.

```
netsh advfirewall consec | dump | export | firewall | help | import | mainmode | monitor | reset | set | show | ?
```

```
netsh advfirewall [consec | firewall | mainmode] <add> <delete> <dump> <help> <set> <show> <?>
```

```
netsh advfirewall [monitor] <delete> <dump> <help> <show> <?>
```

```
netsh advfirewall export <path\filename>
netsh advfirewall import <path\filename>
netsh advfirewall reset [export <path\filename>]
```

```
netsh advfirewall set [allprofiles | currentprofile | domainprofile | privateprofile | publicprofile] state <on> <off> <notconfigured>
netsh advfirewall set firewallpolicy <blockinbound> <blockinboundalways> <allowinbound> <allowoutbound> <blockoutbound> <notconfigured>
netsh advfirewall set settings <localfirewallrules> <localconsecrules> <inboundusernotification> <remotemanagement> <unicastresponsetomulticast>
netsh advfirewall set logging <allowedconnections> <droppedconnections> <filename> <maxfilesize>
netsh advfirewall set global [statefulftp | statefulpptp] <enable> <disable> <notconfigured>
netsh advfirewall set global ipsec [strongcrlcheck <value>] [saidletimemin <value>] [defaultexemptions <value>] [ipsecthroughnat <value>] [authzcomputergrp <value>] [authzusergrp <value>]
netsh advfirewall set global mainmode [mmkeylifetime <value>] [mmsecmethods <value>] [mmforcedh <value>]
```

```
netsh advfirewall show [allprofiles | currentprofile | domainprofile | privateprofile | publicprofile] <state> <firewallpolicy> <settings> <logging>
netsh advfirewall show global <ipsec> <statefulftp> <statefulpptp> <mainmode> <categories>
netsh advfirewall show <store>
```

## Parameters

| Command | Description |
|--|--|
| consec `<add>` `<delete>` `<help>` `<set>` `<show>` rule name=`<string>` <br><br> consec `<dump>` | Switches to the `netsh advfirewall consec` context to configure connection security rules. <br><br><li> add - Adds a new connection security rule. <li> delete - Deletes all matching connection security rules. <li> dump - Displays a configuration script. <li> help - Displays a list of commands. <li> set - Sets new values for properties of an existing rule. <li> show - Displays a specified connection security rule. </li> |
| dump | Displays a configuration script that can be used to restore the current configuration. |
| export `<path\filename>` | Exports the current firewall policy settings to a specified file. |
| firewall `<add>` `<delete>` `<help>` `<set>` `<show>` rule name=`<string>` <br><br> firewall `<dump>` | Switches to the `netsh advfirewall firewall` context to configure firewall rules. <br><br><li> add - Adds a new inbound or outbound firewall rule. <li> delete - Deletes all matching firewall rules. <li> dump - Displays a configuration script. <li> help - Displays a list of commands. <li> set - Sets new values for properties of an existing rule. <li> show - Displays a specified firewall rule. </li> |
| help *or* ? | Displays a list of commands and their descriptions in the current context. |
| import `<path\filename>` | Imports firewall policy settings from a specified file into the current policy store. |
| mainmode `<add>` `<delete>` `<help>` `<set>` `<show>` rule name=`<string>` <br><br> mainmode `<dump>` | Switches to the `netsh advfirewall mainmode` context to configure main mode settings. <br><br><li> add - Adds a new mainmode rule. <li> delete - Deletes all matching mainmode rules. <li> dump - Displays a configuration script. <li> help - Displays a list of commands. <li> set - Sets new values for properties of an existing rule. <li> show - Displays a specified mainmode rule. </li> |
| monitor delete `mmsa \| qmsa` `<source destination \| all>` <br><br> monitor `<help>` <br><br> monitor show `<consec>` `<currentprofile>` `<firewall>` `<mainmode>` `<mmsa>` `<qmsa>` <br><br> monitor `<dump>` | Switches to the `netsh advfirewall monitor` context to display monitoring information. <br><br><li> delete - Deletes all matching security associations. The source destination is one or more IP addresses. `All` specifies that the operation should apply to all entries. <li> dump - Displays a configuration script. <li> help - Displays a list of commands. <li> show - Shows the runtime Firewall policy settings: <br> - `consec` displays current consec state information. <br> - `currentprofile` displays the currently active profiles. <br> - `firewall` displays current firewall state information. <br> - `mainmode` displays current mainmode state information. <br> - `mmsa` displays the main mode SAs. <br> - `qmsa` displays the quick mode SAs. </li> |
| reset `<export path\filename>` | Resets the Windows Defender Firewall with Advanced Security policies to the default settings. The current active policy can be optionally exported to a specified file. <br><br> In a Group Policy object, this command returns all settings to `notconfigured` and deletes all connection security and firewall rules. |
| set allprofiles \| currentprofile \| domainprofile \| privateprofile \| publicprofile \| `parameter` `<value>` | Configures per-profile or global settings for the firewall. <br><br><li> allprofiles - Sets properties in all profiles. <li> currentprofile - Sets properties in the active profile. <li> domainprofile - Sets properties in the domain profile. <li> global - Sets the global properties. <li> privateprofile - Sets properties in the private profile. <li> publicprofile - Sets properties in the public profile. </li><br> The `notconfigured` value is valid only for a Group Policy store. <br><br> The available `parameter` and `<value>` are as follows: <br><br> `state` - Configures the firewall state. <br><li>`<on>` -  Enables the firewall. When the firewall is on, it actively filters network traffic based on the configured rules. <li> `<off>` - Disables the firewall. No filtering or protection is applied, and all network traffic is allowed. <li> `<notconfigured>` - sets the firewall state to its default configuration as per the system policy or administrative template settings. </li><br> `firewallpolicy` - Configures the default *inbound* and *outbound* behavior. <li> `<blockinbound>` - Blocks inbound connections that don't match an inbound rule. <li> `<blockinboundalways>` - Blocks all inbound connections even if the connection matches a rule. <li> `<allowinbound>` - Allows inbound connections that don't match a rule. <li> `<allowoutbound>` - Allows outbound connections that don't match a rule. <li> `<blockoutbound>` - Blocks outbound connections that don't match a rule. <li> `<notconfigured>` - Returns the value to its unconfigured state. </li><br> `settings` - Configures the firewall settings. <br><li> `localfirewallrules` - Merge local firewall rules with Group Policy rules. Valid when configuring a Group Policy store. <li> `localconsecrules` - Merge local connection security rules with Group Policy rules. Valid when configuring a Group Policy store. <li> `inboundusernotification` - Notify user when a program listens for inbound connections. <li> `remotemanagement` - Allow remote management of Windows Firewall. <li> `unicastresponsetomulticast` - Control stateful unicast response to multicast. <li> `<enable>` - Turns on the specified setting. <li> `<disable>` - Turns off the specified setting. <li> `<notconfigured>` - Restores the setting to the systems default configuration. </li><br> `logging` - Configures logging settings. <li> `allowedconnections` - Determines whether successful inbound and outbound connections are recorded in the logs. <br> `<on>` - Logs successful connections. <br> `<off>` - Doesn't log connections. <br> `<notconfigured>` - Reverts to the system's default behavior for logging successful connections. </li> <br><li> `droppedconnections` - Specifies whether connections blocked by the firewall are logged. <br> `<on>` - Logs all blocked connections. <br> `<off>` - Don't log blocked connections. <br> `<notconfigured>` - Reverts to the system's default behavior for logging blocked connections. </li> <br><li> `filename` - Sets the name and location for storing the log file. <br> `<string>` - The file path and file name designated for the log file, such as `C:\Logs\firewall.log`. <br> `<notconfigured>` - Uses the default file path and name provided by the system. </li><br><li> `maxfilesize` - Sets the maximum size of the log file in kilobytes (KB). If the file exceeds this size, the oldest entries are overwritten. Acceptable file size is between 1 KB and 32,767 KB. <br> `<notconfigured>` - Adopts the system's default maximum file size. </li> |
| set global [statefulftp \| statefulpptp] `<enable>` `<disable>` `<notconfigured>` | Configures the global settings including advanced IPsec options. The use of DES, MD5, and DHGroup1 isn't recommended. These cryptographic algorithms are provided for backward compatibility only. <br><br> The mmsecmethods keyword default sets the policy to dhgroup2-aes128-sha1,dhgroup2-3des-sha1 <br><br> `statefulftp` - This option controls the firewall's behavior regarding FTP (File Transfer Protocol) traffic. <br> `statefulpptp` - This option manages the handling of PPTP (Point-to-Point Tunneling Protocol) traffic. <br><br> `<enable>` - Activates stateful inspection for the selected protocol. This ensures that the firewall can dynamically adjust rules to correctly handle corresponding traffic. <br> `<disable>` - Deactivates stateful inspection for the selected protocol. This might lead to issues with correctly handling protocol-specific traffic as the firewall doesn't dynamically adjust its rules. <br> `<notconfigured>` - Resets the setting to the default behavior as determined by the system's policy or configuration. This allows the system to apply its default rules without user-specified changes. |
| set global ipsec `parameter` `<value>` | `strongcrlcheck` - Configures the enforcement level of Certificate Revocation List (CRL) checking. <br> `<0>` - Disables CRL checking (default setting). <br> `<1>` - Fails the connection if the certificate is revoked. <br> `<2>` - Fails the connection on any CRL-related error. <br> `<notconfigured>` - Resets the value to the not configured state. <br><br> `saidletimemin` - Sets the idle time in minutes for a Security Association (SA) before it's considered inactive. Acceptable values range from `5` to `60` minutes. <br> `<notconfigured>` - Defaults to `5` minutes. <br><br> `defaultexemptions` - Manages default protocols exempted from IPsec protection. The default is to exempt IPv6 neighbordiscovery protocol and DHCP from IPsec. Acceptable values include: <br> `<none>` <br> `<neighbordiscovery>` <br> `<icmp>` <br> `<dhcp>` <br> `<notconfigured>` <br><br> `ipsecthroughnat` - Configures the conditions under which IPsec can establish security associations with devices behind a Network Address Translator (NAT). Acceptable values include: <br> `<never>` - Associations aren't permitted (default). <br> `<serverbehindnat>` - Only if the server is behind a NAT. <br> `<serverandclientbehindnat>` - If both the server and client are behind a NAT. <br> `<notconfigured>` - Defaults to `<never>`. <br><br> `authzcomputergrp` - Specifies computer groups authorized to establish tunnel mode connections. <br> `<none>` - No specific computer group is authorized to establish tunnel mode connections. <br> `<SDDL string>` - Specifies a Security Descriptor Definition Language (SDDL) string that defines the group of computers authorized to establish connections. <br> `<notconfigured>` - Specifies default settings. <br><br> `authzusergrp` - Specifies user groups authorized to establish tunnel mode connections. <br> `<none>` - No specific user group is authorized to establish tunnel mode connections. <br> `<SDDL string>` - Defines the specific user groups authorized to establish connections. <br> `<notconfigured>` - Specifies default settings. |
| set global mainmode `parameter` `<value>` \| `<notconfigured>` | `mmkeylifetime` - Sets the duration for which the keys in Main Mode are valid. Key lifetime is defined by time in minutes [\<num> min], number of sessions [\<num> sess], or both. <br> The minimum *lifetime* of the keys in minutes range from `1` minute and maximum of `2880` minutes. <br> The minimum number of *sessions* for which the keys are valid range from `0` sessions to a maximum of `2,147,483,647` sessions. <br><br> `mmsecmethods` - Configures the list of security proposals for the Main Mode IPsec negotiations, which includes key exchange, encryption, and integrity algorithms. You can use a comma-separated list of proposals in the format `keyexch:enc-integrity`. Each proposal consists of a set of algorithms from each category. <br><li> **keyexch**: Specifies the Diffie-Hellman (DH) or Elliptic Curve Diffie-Hellman groups used for the key exchange. Acceptable values are: <br>  `<dhgroup1>` <br> `<dhgroup2>` <br> `<dhgroup14>` <br> `<dhgroup24>` <br> `<ecdhp256>` <br> `<ecdhp384>` <br><li>  **enc**: Specifies the encryption algorithm used for securing the data. Acceptable values are: <br> `<3des>` <br> `<des>` <br> `<aes128>` <br> `<aes192>` <br> `<aes256>` <br><li> **integrity**: Specifies the algorithm used to ensure the data integrity. Acceptable values are: <br> `<md5>` <br> `<sha1>` <br> `<sha256>` <br> `<sha384>` <br><br> `mmforcedh` - Enforces the use of DH for key exchanges during IPsec main mode negotiations. <br> `<yes>` - Forces the use of DH for key exchange. <br> `<no>` - Doesn't force the use of DH for key exchange (default setting). |
| show allprofiles \| currentprofile \| domainprofile \| privateprofile \| publicprofile \| `parameter` | Displays the current profile or global properties for the firewall. <br><br><li> allprofiles - Displays the properties for all profiles. <li> currentprofile - Displays the properties for the active profile. <li> domainprofile - Displays the properties in the domain profile. <li> global - Displays the global properties. <li> privateprofile - Displays the properties for the private profile. <li> publicprofile - Displays the properties for the public profile. <li> store - Displays the current policy store. </li><br> If a parameter isn't specified for the profiles, all properties are displayed. <br><br> The available parameters are as follows: <br><br> `state`: Displays whether the Windows Defender Firewall with Advanced Security is currently enabled or disabled for each profile. <br> `firewallpolicy`: Shows the default actions for inbound and outbound connections, indicating whether such connections are allowed or blocked by default for each profile. <br> `settings`: Provides detailed properties of the firewall, including configuration settings for each profile. <br> `logging`: Shows the current logging configuration, including log file location, size, and logging options for dropped packets and successful connections. |
| show global `parameter` | Displays the global settings for Windows Defender Firewall with Advanced Security. If no parameter is specified, all properties are displayed. <br><br> The available parameters are as follows: <br><br> `ipsec`: Displays the specific IPsec settings. <br> `statefulftp`: Displays the configuration for Stateful FTP support. <br> `statefulpptp`: Shows the configuration for Stateful PPTP support. <br> `mainmode`: Displays the configuration for Main Mode, a phase in the IPsec negotiation process where both parties authenticate each other and establish a secure channel for further communication. <br> `categories`: Displays the configuration related to Firewall Categories. |

## Remarks

### Consec parameter remarks

# [add](#tab/consecadd)

```
- The rule name should be unique and can't be "all".
- When mode=tunnel, tunnel endpoints must be specified unless the action is "noauthentication". If specific IP addresses are used, they must belong to the same IP version.
  - For dynamic tunnels, tunnel endpoints can be set to "any".
  - Local tunnel endpoints aren't required for Client policies, for example, "any".
  - Remote tunnel endpoints aren't required for Gateway policies, for example, "any". Additionally, the action must be one of the following: requireinrequireout, requireinclearout, or noauthentication.
- requireinclearout isn't valid when mode=Transport.
- At least one authentication must be specified.
- Auth1 and auth2 can be comma-separated lists of options.
- Computerpsk and computerntlm methods can't be specified together for auth1.
- Computercert can't be specified with user credentials for auth2.
- Certsigning options ecdsap256 and ecdsap384 are only supported on Windows Vista SP1 and later.
- Qmsecmethods can be a list of proposals separated by a ",".
- For qmsecmethods, integrity=md5|sha1|sha256|aesgmac128|aesgmac192|aesgmac256|aesgcm128|aesgcm192|aesgcm256 and encryption=3des|des|aes128|aes192|aes256|aesgcm128|aesgcm192|aesgcm256.
- If aesgcm128, aesgcm192, or aesgcm256 is specified, it must be used for both ESP integrity and encryption.
- Aesgmac128, aesgmac192, aesgmac256, aesgcm128, aesgcm192, aesgcm256, sha256 are only supported on Windows Vista SP1 and later.
- Qmpfs=mainmode uses the main mode key exchange setting for PFS.
- The use of DES, MD5, and DHGroup1 isn't recommended. These cryptographic algorithms are provided for backward compatibility only.
- The default value for certmapping and excludecaname is "no".
- The " characters within CA name must be replaced with \'
- For auth1ca and auth2ca, the CA name must be prefixed by "CN=".
- catype can be used to specify the Certification authority type "catype=root/intermediate".
- authnoencap is supported on Windows 7 and later.
- authnoencap means that the computers will only use authentication, and won't use any per packet encapsulation or encryption algorithms to protect subsequent network packets exchanged as part of this connection.
- QMPFS and authnoencap can't be used together on the same rule.
- AuthNoEncap must be accompanied by at least one AH or ESP integrity suite.
- applyauthz can only be specified for tunnel mode rules.
- exemptipsecprotectedconnections can only be specified for tunnel mode rules. By setting this flag to "Yes", ESP traffic is exempted from the tunnel. AH only traffic won't be exempted from the tunnel.
- Valuemin, when specified, for a qmsecmethod should be between 5 to 2880 minutes. Valuekb, when specified, for a qmsecmethod should be between 20480 KB to 2147483647 KB.
- Certhash specifies the thumbprint, or hash of the certificate.
- Followrenewal specifies whether to automatically follow renewal links in certificates. Only applicable for certificate section (requires certhash).
- Certeku specifies the comma separated list of EKU OIDs to match in the certificate.
- Certname specifies the string to match for certificate name (requires certnametype).
- Certnametype specifies the certificate field for the certname to be matched against (requires certname).
- Certcriteriatype specifies whether to take the action with the certificate when selecting the local certificate, validating the peer certificate, or both.
- Within a computercert authentication mapping, multiple certificates can be referenced by separating each entry by using the "|" character.
```

# [delete](#tab/consecdelete)

```
- Deletes a rule identified by name and optionally by profiles, endpoints, ports, protocol, and type.
- If multiple matches are found, all matching rules are deleted.
```

# [set](#tab/consecset)

```
- Sets a new parameter value on an identified rule. The command fails if the rule does not exist. To create a rule, use the "add" command.
- Values after the new keyword are updated in the rule. If there are no values, or keyword new is missing, no changes are made.
- A group of rules can only be enabled or disabled.
- If multiple rules match the criteria, all matching rules will be updated.
- Rule name should be unique and can't be "all".
- Auth1 and auth2 can be comma-separated lists of options.
- Computerpsk and computerntlm methods can't be specified together for auth1.
- Computercert can't be specified with user credentials for auth2.
- Certsigning options ecdsap256 and ecdsap384 are only supported on Windows Vista SP1 and later.
- Qmsecmethods can be a list of proposals separated by a ",".
- For qmsecmethods, integrity=md5|sha1|sha256|aesgmac128|aesgmac192|aesgmac256|aesgcm128|aesgcm192|aesgcm256 and encryption=3des|des|aes128|aes192|aes256|aesgcm128|aesgcm192|aesgcm256.
- If aesgcm128, aesgcm192, or aesgcm256 is specified, it must be used for both ESP integrity and encryption.
- Aesgmac128, aesgmac192, aesgmac256, aesgcm128, aesgcm192, aesgcm256, sha256 are only supported on Windows Vista SP1 and later.
- If qmsemethods are set to default, qmpfs will be set to default as well.
- Qmpfs=mainmode uses the main mode key exchange setting for PFS.
- The use of DES, MD5 and DHGroup1 is not recommended. These cryptographic algorithms are provided for backward compatibility only.
- The " characters within CA name must be replaced with \'
- For auth1ca and auth2ca, the CA name must be prefixed by "CN=".
- catype can be used to specify the Certification authority type "catype=root/intermediate".
- authnoencap is supported on Windows 7 and later.
- authnoencap means that the computers will only use authentication, and will not use any per packet encapsulation or encryption algorithms to protect subsequent network packets exchanged as part of this connection.
- QMPFS and authnoencap can't be used together on the same rule.
- AuthNoEncap must be accompanied by at least one AH or ESP integrity suite.
- When mode=tunnel action must be requireinrequireout, requireinclearout or noauthentication.
- requireinclearout is not valid when mode=Transport.
- applyauthz can only be specified for tunnel mode rules.
- exemptipsecprotectedconnections can only be specified for tunnel mode rules. By setting this flag to "Yes", ESP traffic will be exempted from the tunnel. AH only traffic will NOT be exempted from the tunnel.
- Port1, Port2 and Protocol can only be specified when mode=transport.
- Valuemin, when specified, for a qmsecmethod should be between 5 to 2880 minutes. Valuekb, when specified, for a qmsecmethod should be between 20480 KB to 2147483647 KB.
- Certhash specifies the thumbprint, or hash of the certificate.
- Followrenewal specifies whether to automatically follow renewal links in certificates. Only applicable for certificate section (requires certhash).
- Certeku specifies the comma separated list of EKU OIDs to match in the certificate.
- Certname specifies the string to match for certificate name (requires certnametype).
- Certnametype specifies the certificate field for the certname to be matched against (requires certname).
- Certcriteriatype specifies whether to take the action with the certificate when selecting the local certificate, validating the peer certificate, or both.
```

---

### Firewall parameter remarks

# [add](#tab/firewalladd)

```
- Add a new inbound or outbound rule to the firewall policy.
- Rule name should be unique and can't be "all".
- If a remote computer or user group is specified, security must be: authenticate, authenc, authdynenc, or authnoencap.
- Setting security to authdynenc allows systems to dynamically negotiate the use of encryption for traffic that matches a given Windows Defender Firewall rule. Encryption is negotiated based on existing connection security rule properties. This option enables the ability of a machine to accept the first TCP or UDP packet of an inbound IPsec connection as long as it's secured, but not encrypted, using IPsec. Once the first packet is processed, the server renegotiates the connection and upgrade it so that all subsequent communications are fully encrypted.
- If action=bypass, the remote computer group must be specified when dir=in.
- If service=any, the rule applies only to services.
- ICMP type or code can be "any".
- Edge can only be specified for inbound rules.
- AuthEnc and authnoencap can't be used together.
- Authdynenc is valid only when dir=in.
- When authnoencap is set, the security=authenticate option becomes an optional parameter.
```

# [delete](#tab/firewalldelete)

```
- Deletes a rule identified by name and optionally by endpoints, ports, protocol, and type.
- If multiple matches are found, all matching rules are deleted.
- If name=all is specified, all rules are deleted from the specified type and profile.
```

# [set](#tab/firewallset)

```
- Sets a new parameter value on an identified rule. The command fails if the rule does not exist. To create a rule, use the add command.
- Values after the new keyword are updated in the rule. If there are no values, or the new keyword is missing, no changes are made.
- A group of rules can only be enabled or disabled.
- If multiple rules match the criteria, all matching rules will be updated.
- Rule name should be unique and cannot be "all."
- If a remote computer or user group is specified, security must be: authenticate, authenc, or authdynenc.
- Setting security to authdynenc allows systems to dynamically negotiate the use of encryption for traffic that matches a given Windows Defender Firewall rule. Encryption is negotiated based on existing connection security rule properties. This option enables the ability of a machine to accept the first TCP or UDP packet of an inbound IPsec connection as long as it's secured, but not encrypted, using IPsec. Once the first packet is processed, the server will renegotiate the connection and upgrade it so that all subsequent communications are fully encrypted.
- authdynenc is valid only when dir=in.
- If action=bypass, the remote computer group must be specified when dir=in.
- If service=any, the rule applies only to services.
- ICMP type or code can be "any."
- Edge can only be specified for inbound rules.
```

---

### Mainmode parameter remarks

# [add](#tab/mainmodeadd)

```
- Add a new mainmode rule to the firewall policy.
- Rule name should be unique and can't be "all".
- Computerpsk and computerntlm methods can't be specified together for auth1.
- The use of DES, MD5, and DHGroup1 isn't recommended. These cryptographic algorithms are provided for backward compatibility only.
- The minimum main mode keylifetime is mmkeylifetime=1min. The maximum main mode mmkeylifetime=2880min. The minimum number of sessions=0 sessions. The maximum=2,147,483,647 sessions.
- The mmsecmethods keyword default sets the policy to: dhgroup2-aes128-sha1,dhgroup2-3des-sha1
- Certhash specifies the thumbprint, or hash of the certificate.
- Followrenewal specifies whether to automatically follow renewal links in certificates. Only applicable for certificate section (requires certhash).
- Certeku specifies the comma separated list of EKU OIDs to match in the certificate.
- Certname specifies the string to match for certificate name (requires certnametype).
- Certnametype specifies the certificate field for the certname to be matched against (requires certname).
- Certcriteriatype specifies whether to take the action with the certificate when selecting the local certificate, validating the peer certificate, or both.
```

# [delete](#tab/mainmodedelete)

```
- Deletes an existing main mode setting that matches the name specified. Optionally, profile can be specified. Command fails if setting with the specified name doesn't exist.
- If name=all is specified, all rules are deleted from the specified type and profile. If profile isn't specified, the delete applies to all profiles.
```

# [set](#tab/mainmodeset)

```
- Sets a new parameter value on an identified rule. The command fails if the rule doesn't exist. To create a rule, use the add command.
- Values after the new keyword are updated in the rule. If there are no values, or keyword new is missing, no changes are made.
- If multiple rules match the criteria, all matching rules are updated.- Rule name should be unique and can't be "all".
- Auth1 can be comma-separated lists of options. Computerpsk and computerntlm methods can't be specified together for auth1.
- The use of DES, MD5, and DHGroup1 isn't recommended. These cryptographic algorithms are provided for backward compatibility only.
- The minimum main mode keylifetime is mmkeylifetime=1min. The maximum main mode mmkeylifetime=2880min. The minimum number of sessions=0 sessions. The maximum=2,147,483,647 sessions.
- The mmsecmethods keyword default sets the policy to: dhgroup2-aes128-sha1,dhgroup2-3des-sha1.
- Certhash specifies the thumbprint, or hash of the certificate.
- Followrenewal specifies whether to automatically follow renewal links in certificates. Only applicable for certificate section (requires certhash).
- Certeku specifies the comma separated list of EKU OIDs to match in the certificate.
- Certname specifies the string to match for certificate name (requires certnametype).
- Certnametype specifies the certificate field for the certname to be matched against (requires certname).
- Certcriteriatype specifies whether to take the action with the certificate when selecting the local certificate, validating the peer certificate, or both.
```

---

### Monitor parameter remarks

# [delete](#tab/monitordelete)

```
- This command deletes the matching security association as specified by the source destination pair.
- Source and destination are each a single IPv4 or IPv6 address.
```

# [show consec <br> show mainmode](#tab/monitorshowconsec)

```
- Displays the Connection Security configuration for all available network profiles.
- The [profile=] command enables the administrator to filter the output to specific profiles on the system or to only return results from Active or Inactive profiles.
- The [rule] command allows the administrator to scope the rule output to certain rule names and status to scope the output.
- The Verbose command adds support for displaying detailed security and advanced rule 'source name' information.
```

# [show firewall](#tab/monitorshowfirewall)

```
- Displays the Windows Defender Firewall with Advanced Security properties for all available network profiles.
- The profile= argument enables the administrator to filter the output to specific profiles on the system.
- The Verbose argument adds support for displaying detailed security and advanced rule 'source name' information.
```

# [show mmsa <br> show qmsa](#tab/monitorshowmmsa)

```
- This command shows the security association, or as filtered by the source destination pair.
- Source and destination are each a single IPv4 or IPv6 address.
```

---

## Examples

> [!NOTE]
> For detailed usage instructions and additional examples for all parameters, use the `help` or `?` commands. These commands provide syntax details and guidance for specific operations.

**consec**

To add a connection security rule requiring authentication, run the following command:

```cmd
netsh advfirewall consec add rule name="RequireAuth" endpoint1=any endpoint2=any action=requireinrequestout
```

To add a new connection security rule that uses Kerberos for authentication, run the following command:

```cmd
netsh advfirewall consec add rule name="KerberosAuthRule" endpoint1=any endpoint2=any action=requireinrequireout auth1=computerkerb
```

To delete a connection security rule by its name, run the following command:

```cmd
netsh advfirewall consec delete rule name="RuleName"
```

**dump**

To save the current advanced firewall configuration to a text file, run the following command:

```cmd
netsh advfirewall dump > "C:\path\to\firewall_dump.txt"
```

To display the current firewall configuration in CMD, run the following command:

```cmd
netsh advfirewall dump
```

To include the advanced firewall state in the main dump for diagnostics, run the following command:

```cmd
netsh advfirewall dump | findstr "State"
```

**export**

To export the current firewall policy for backup, run the following command:

```cmd
netsh advfirewall export "C:\folder\firewall_backup.wfw"
```

**firewall**

To add a rule allowing inbound traffic on port 8080, run the following command:

```cmd
netsh advfirewall firewall add rule name="Allow8080" protocol=TCP dir=in localport=8080 action=allow
```

To block outgoing traffic to a specific IP, run the following command:

```cmd
netsh advfirewall firewall add rule name="BlockOutIP" protocol=TCP dir=out remoteip=192.168.1.100 action=block
```

To remove a specific firewall rule by name, run the following command:

```cmd
netsh advfirewall firewall delete rule name="MyRule"
```

**help**

To get help for all firewall commands, run the following command:

```cmd
netsh advfirewall firewall ?
```

To find out syntax details for adding a firewall rule, run the following command:

```cmd
netsh advfirewall firewall add rule ?
```

**import**

To import a saved firewall configuration from a file, run the following command:

```cmd
netsh advfirewall import "C:\folder\firewall_config.wfw"
```

**mainmode**

To add a mainmode rule for security negotiation, run the following command:

```cmd
netsh advfirewall mainmode add rule name="MyMainmodeRule" auth1=computerkerb
```

To show detailed settings of mainmode rules, run the following command:

```cmd
netsh advfirewall mainmode show rule name=all
```

To remove a mainmode rule by specifying its name, run the following command:

```cmd
netsh advfirewall mainmode delete rule name="MyMainmodeRule"
```

**monitor**

To monitor active connection security associations, run the following command:

```cmd
netsh advfirewall monitor show mmsa
```

To display statistics and active connections, run the following command:

```cmd
netsh advfirewall monitor show firewall
```

**reset**

To reset the firewall settings without additional confirmation, run the following command:

```cmd
netsh advfirewall reset
```

**set**

To disable logging of dropped packets, run the following command:

```cmd
netsh advfirewall set currentprofile logging droppedconnections disable
```

To enable notifications for blocked applications, run the following command:

```cmd
netsh advfirewall set currentprofile settings allowunicastresponsetomulticast enable
```

**show**

To display all active firewall rules, run the following command:

```cmd
netsh advfirewall firewall show rule name=all
```

To show detailed information on a specific rule by name, run the following command:

```cmd
netsh advfirewall firewall show rule name="MyRuleName" verbose
```

---
title: netsh ras
description: The netsh ras command manages Remote Access Service (RAS) settings to configure, monitor, and troubleshoot remote access features in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/03/2025
---

# netsh ras

The `netsh ras` command manages Remote Access Service (RAS) settings. RAS provides network connectivity for remote users, such as VPN or dial-up connections. By using this command, admins can configure, monitor, and troubleshoot remote access features, including user authentication, connection profiles, and server settings.

## Syntax

```
netsh ras [aaaa | add | delete | diagnostics | dump | help | ip | ipv6 | set | show | ?]
```

```
netsh ras aaaa add acctserver [name=]server [secret=]secret [init-score=]InitialScore [port=]port
                              [timeout=]timeout [messages=]ENABLED|DISABLED
netsh ras aaaa add authserver [name=]server [secret=]secret [init-score=]InitialScore [port=]port
                              [timeout=]timeout [signature=]ENABLED|DISABLED
```

```
netsh ras aaaa delete acctserver [name=]server
netsh ras aaaa delete authserver [name=]server
```

```
netsh ras aaaa set accounting [provider=]WINDOWS|RADIUS|NONE
netsh ras aaaa set acctserver [name=]server [secret=]secret [init-score=]InitialScore [port=]port
                              [timeout=]timeout [messages=]ENABLED|DISABLED
netsh ras aaaa set authentication [name=]server [secret=]secret [init-score=]InitialScore [port=]port
                                  [timeout=]timeout [messages=]ENABLED|DISABLED
netsh ras aaaa set authserver [name=]server [secret=]secret [init-score=]InitialScore [port=]port
                              [timeout=]timeout [signature=]ENABLED|DISABLED
netsh ras aaaa set ipsecpolicy [psk=]ENABLED|DISABLED [secret=]<Pre-shared key>
```

```
netsh ras aaaa show <accounting>
netsh ras aaaa show acctserver [name=]server
netsh ras aaaa show <authentication>
netsh ras aaaa show authserver [name=]server
netsh ras aaaa show <ipsecpolicy>
```

```
netsh ras add authtype [type=]PAP|MD5CHAP|MSCHAPv2|EAP|CERT
netsh ras add link [type=]SWC|LCP
netsh ras add multilink [type=]MULTI|BACP
netsh ras add registeredserver [domain=]domain [server=]server
```

```
netsh ras delete authtype [type=]PAP|MD5CHAP|MSCHAPv2|EAP|CERT
netsh ras delete link [type=]SWC|LCP
netsh ras delete multilink [type=]MULTI|BACP
netsh ras delete registeredserver [domain=]domain [server=]server
```

```
netsh ras diagnostics <dump>
netsh ras diagnostics set cmtracing [state=]ENABLED|DISABLED
netsh ras diagnostics set loglevel [events=]error|warn|all|none
netsh ras diagnostics set modemtracing [state=]ENABLED|DISABLED
netsh ras diagnostics set rastracing [component=]component [state=]ENABLED|DISABLED
netsh ras diagnostics set securityeventlog [state=]ENABLED|DISABLED
netsh ras diagnostics set tracefacilities [state=]ENABLED|DISABLED|CLEAR
netsh ras diagnostics show <all> <cmtracing> <configuration> <installation>
                           <loglevel> <logs> <modemtracing> <rastracing>
                           <securityeventlog> <tracefascilities>
```

```
netsh ras dump
```

```
netsh ras ip add range [from=] [to=]
netsh ras ip delete pool
netsh ras ip delete range [from=] [to=]
netsh ras ip dump
netsh ras ip set access [mode=]ALL|SERVERONLY
netsh ras ip set addrassign [method=]AUTO|POOL
netsh ras ip set addrreq [mode=]ALLOW|DENY
netsh ras ip set broadcastnameresolution [mode=]ENABLED|DISABLED
netsh ras ip set negotiation [mode=]ALLOW|DENY
netsh ras ip set preferredadapter [name=]<interface_name>
```

```
netsh ras ipv6 dump
netsh ras ipv6 set access [mode=]ALL|SERVERONLY
netsh ras ipv6 set negotiation [mode=]ALLOW|DENY
netsh ras ipv6 set prefix [prefix=]<IPv6 prefix>
netsh ras ipv6 set routeradvertise [mode=]ENABLED|DISABLED
netsh ras ipv6 show <config>
```

```
netsh ras set authmode [mode=]STANDARD|NODCC|BYPASS
netsh ras set client [name=]<str_clientname> [state=]disconnect|resetstats
netsh ras set conf [confstate=]ENABLED|DISABLED
netsh ras set ikev2connection [idletimeout=]<idle_timeout> [nwoutagetime=]<nw_outage_time>
netsh ras set ikev2saexpiry [saexpirytime=]<sa_expiry_time> [sadatasizelimit=]<sa_datasize_limit>
netsh ras set portstatus [name=]<port_name>
netsh ras set sstp-ssl-cert [name=]certname [hash=]<hash>
netsh ras set type [ipv4rtrtype=]lanonly|lananddd|none [ipv6rtrtype=]lanonly|lananddd|none [rastype=]IPv4|IPv6|BOTH|NONE
netsh ras set user [name=]<username> [dialin=]PERMIT|DENY|POLICY [cbpolicy=]NONE|CALLER|ADMIN [cbnumber=]<callback number>
netsh ras set wanports [device=]<devicename> [rasinonly=]enabled|disabled [ddinout=]enabled|disabled [ddoutonly=]enabled|disabled [phone=]<phonenumber> [maxports=]<numports>
```

```
netsh ras show activeservers
netsh ras show authmode
netsh ras show authtype
netsh ras show client [name=]<str_clientname>
netsh ras show conf
netsh ras show ikev2connection
netsh ras show ikev2saexpiry
netsh ras show link
netsh ras show multilink
netsh ras show portstatus [name=]<port_name> [state=]<enum>
netsh ras show registeredserver
netsh ras show sstp-ssl-cert
netsh ras show status
netsh ras show type
netsh ras show user [name=]<username> [mode=]PERMIT|REPORT
netsh ras show wanports [device=]<devicename>
```

## Parameters

| Command | Description |
|--|--|
| ras `aaaa add` | Inserts one or more entries into the AAAA table. <br><br> `acctserver` - Adds a RADIUS accounting server. <br> `authserver` - Adds a RADIUS authentication server. <br><br> See [Remarks](#remarks) for subparameters. |
| ras `aaaa delete` | Removes one or more entries from the AAAA table. <br><br> `acctserver` - Removes a RADIUS accounting server. <br> `authserver` - Removes a RADIUS authentication server. <br><br> See [Remarks](#remarks) for subparameters. |
| ras `aaaa set accounting` | Specifies which service handles accounting for remote access connections. Options are: <br><br> `windows` - Uses Windows security for accounting operations. <br> `radius` - Sends accounting data to a configured RADIUS server. <br> `none` - Disables accounting. No records are kept for connection activities. |
| ras `aaaa set acctserver` | Configures an IP address or name of a RADIUS server to use for accounting. <br><br> See [Remarks](#remarks) for subparameters. |
| ras `aaaa set authentication` | Specifies which service is used to authenticate remote access connections. Options are: <br><br> `windows` - Uses Windows security for authentication. <br> `radius` - Uses a configured RADIUS server for authentication. |
| ras `aaaa set authserver` | Configures an IP address or name of a RADIUS server to pass authentication requests. <br><br> See [Remarks](#remarks) for subparameters. |
| ras `aaaa set ipsecpolicy` | Sets the IPsec policy for L2TP connections. `psk` determines if a custom IPsec policy using a preshared key is enabled for L2TP connections. Options are: <br><br> `enabled` - Allows the use of a custom IPsec policy with a specified preshared key. <br> `disabled` - Uses the default Certificate Authority-based IPsec policy. <br><br> `secret` - Specifies the preshared key to be used when `psk` is set to `enabled`. |
| ras `aaaa show accounting` | Displays the current accounting provider. |
| ras `aaaa show acctserver` | Displays detailed information about an accounting server. If no server name is provided using `name=`, all configured accounting servers are displayed. |
| ras `aaaa show authentication` | Displays the authentication provider. |
| ras `aaaa show authserver` | Displays detailed information about an authentication server. If no server name is provided using `name=`, all configured accounting servers are displayed. |
| ras `aaaa show ipsecpolicy` | Displays the IPsec policy for L2TP connection. The **Routing and Remote Access** service must be running to obtain results. |
| ras `add authtype` | Specifies the authentication types that the Remote Access server attempts to negotiate with connecting clients. The server negotiates authentication methods in order from most secure to least secure. Once both the client and server agree on an authentication type, Point-to-Point Protocol (PPP) negotiation proceeds according to the relevant RFC standards. <br><br> See [Remarks](#remarks) for authentication subparameters. |
| ras `add link` | Adds to the list of link properties PPP negotiates. <br><br> See [Remarks](#remarks) for link subparameters. |
| ras `add multilink` | Adds to the list of multilink types PPP negotiates. <br><br> See [Remarks](#remarks) for multilink subparameters. |
| ras `add registeredserver` | Registers the specified Windows computer as a Remote Access server within the Active Directory (AD) of the designated domain. <br><br> See [Remarks](#remarks) for `server` and `domain` subparameters. |
| ras `delete authtype` | Removes an authentication type from the list of types that the Remote Access server negotiates. <br><br> See [Remarks](#remarks) for authentication subparameters. |
| ras `delete link` | Removes from the list of link properties PPP negotiates. <br><br> See [Remarks](#remarks) for link subparameters. |
| ras `delete multilink` | Removes from the list of multilink PPP types that are negotiated. <br><br> See [Remarks](#remarks) for multilink subparameters. |
| ras `delete registeredserver` | Unregisters the specified Windows computer from the list of Remote Access servers registered in the AD of the designated domain. <br><br> See [Remarks](#remarks) for `server` and `domain` subparameters. |
| ras `diagnostics set` | Performs one of the following actions: <br><br> `cmtracing` - Enables or disables Connection Manager tracing, which logs events related to connection establishment and management. <br><br> `loglevel` - Sets the global log level for Routing and Remote Access Service (RRAS). Options include `error`, `warn`, `all`, or `none`. <br><br> `modemtracing` - Enables or disables detailed tracing of modem settings and messages during network connections. <br><br> `rastracing` - Enables or disables extended tracing for a specified RRAS component to assist with troubleshooting. To trace all components, use `state=*`. The following list describes the available components: <br> - rasman <br> - rasppp <br> - rasauth <br> - rasip <br> - rasl2tp <br> - raspptp <br> - rassstp <br> - rasgre <br> - raseap <br> - rasqec <br> - rasmobility <br> - rascustom <br><br> `securityeventlog` - Enables or disables logging of security events. Security Event logs can be viewed using Event Viewer. <br><br> `tracefacilities` - Enables, disables, or clears extended tracing for all RRAS components. <br><br> See [Remarks](#remarks) for `state` subparameters. |
| ras `dump` <br><br> ras `diagnostics dump` <br><br> ras `ip dump` <br><br> ras `ipv6 dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| ras `ip add range` <br><br> ras `ip delete range` | Adds or removes a range of the static IP address pool that the Remote Access server using `from` and `to` as the range in the `X.X.X.X` format. |
| ras `ip delete pool` | Deletes all ranges from the static IP address pool. |
| ras `ip set access` | Sets what type of access level to grant. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ip set addrassign` | Sets the method by which the Remote Access server assigns IP addresses to client devices. Options are: <br><br> `auto` - Automatically assigns IP addresses to clients using DHCP. If a DHCP server is unavailable, the server assigns a random private IP address. <br> `pool` - Assigns IP addresses from the Remote Access server's configured address pool. |
| ras `ip set addrreq` | Specifies whether dial-in clients are permitted to request their own IP addresses. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ip set broadcastnameresolution` | Specifies whether to enable or disable broadcast name resolution using NetBIOS over TCP/IP. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ip set negotiation` | Specifies whether the Remote Access server allows IPv4 to be configured for any client connections it accepts. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ip set preferredadapter` | Specifies the preferred adapter for Routing and Remote Access Service. <br><br> See [Remarks](#remarks) for `name` subparameters. |
| ras `ipv6 set access` | Sets what type of access level to grant for IPv6. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ipv6 set negotiation` | Specifies whether the Remote Access server allows IPv6 to be configured for any client connections it accepts. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ipv6 set prefix` | Sets the static IPv6 prefix that the Remote Access server uses to advertise to client devices in the format `prefix=X:X:X:X::`. |
| ras `ipv6 set routeradvertise` | Specifies the router advertisement mode on the server. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `ipv6 show config` | Displays the current Remote Access IPv6 configuration. |
| ras `set authmode` | Sets which authentication mode dial-in clients should use. <br><br> See [Remarks](#remarks) for `mode` subparameters. |
| ras `set client` | Disconnects or resets the statistics of the username attached to the client device. <br><br> See [Remarks](#remarks) for `name` and `state` subparameters. |
| ras `set conf` | Configures whether the RAS is `enabled` (on) or `disabled` (off) using `confstate=`. If set to `disabled`, all configurations are also removed. |
| ras `set ikev2connection` | Sets the idle timeout and network outage time values for IKEv2 client connections. <br><br> `idletimeout` - Sets the idle timeout in minutes for IKEv2 client connections. If the client is inactive for this period, the connection is disconnected. Valid range is 5 minutes to 2,879 minutes (less than 48 hours). <br> `nwoutagetime` - Sets the network outage time in minutes for IKEv2 client connections. If the network is unavailable for this duration, the connection is terminated. Minimum value is 2 minutes. |
| ras `set ikev2saexpiry` | Sets the IKEv2 Security Association (SA) expiration controls. <br><br> `saexpirytime` - Sets the SA expiry time in minutes for IKEv2 client connections. The minimum value is 5 minutes and the maximum is 2879 minutes (less than 48 hours). <br> `sadatasizelimit` - Sets the SA data size limit in megabytes for IKEv2 connections. The minimum value is 1 MB. |
| ras `set portstatus` | Resets the statistics information of RAS ports. If a name isn't specified, all active ports statistics are resets. <br><br> See [Remarks](#remarks) for `name` subparameters. |
| ras `set sstp-ssl-cert` | Configures the current Secure Socket Tunneling Protocol (SSTP) certificate. <br><br> `name` - Specifies the certificate name to use for SSTP. <br> `hash` - Specifies the SHA-1 hash of the certificate to use for SSTP. |
| ras `set type` | Configures the router and RAS roles on the device. Options are: <br><br> `ipv4rtrtype` - Sets the IPv4 router mode: <br>- `lanonly`: The computer acts as a LAN-only router and doesn't support Demand Dial or VPN connections. <br> - `lananddd`: The computer acts as both a LAN and Demand Dial router, supporting VPN connections. <br> - `none`: The computer isn't enabled as an IPv4 router. <br><br> `ipv6rtrtype` - Sets the IPv6 router mode: <br> - `lanonly`: The computer acts as a LAN-only router and doesn't support Demand Dial or VPN connections. <br> - `lananddd`: The computer acts as both a LAN and Demand Dial router, supporting VPN connections. <br> - `none`: The computer isn't enabled as an IPv6 router. <br><br> `rastype` - Sets the RAS configuration: <br> - `ipv4`: Configured as a Remote Access Server for IPv4. <br> - `ipv6`: Configured as a Remote Access Server for IPv6. <br> - `both`: Configured as a Remote Access Server for both IPv4 and IPv6. <br> - `none`: Not configured as a RAS. |
| ras `set user` | Configures user Remote Access properties. Options are: <br><br> `username` - The user's logon name. <br> `dialin` - Determines if the user is allowed to dial in: <br> - `PERMIT`: Allows the user to dial in. <br> - `DENY`: Prevents the user from dialing in. <br> - `POLICY`: Uses remote access policies to determine dial-in permission. The `POLICY` option isn't available for users in mixed-mode domains. For these users, `POLICY` is treated as `DENY`. <br><br> `cbpolicy` - Specifies the user's callback policy. Callback allows the server to call the user back to save call costs: <br> - `NONE`: Callback isn't allowed. <br> - `CALLER`: The user can specify a callback number at call time. <br> - `ADMIN`: The server always calls the user at the specified callback number. <br><br> `cbnumber` - The callback number used when `cbpolicy` is set to `ADMIN`. |
| ras `set wanports` | Configures options for RAS WAN ports. <br><br> `device` - Specifies the device name of the WAN port. <br><br> `rasinonly` - Enables (`enabled`) or disables (`disabled`) inbound remote access connections. <br><br> `ddinout` - Enables (`enabled`) or disables (`disabled`) demand dial inbound and outbound routing connections. <br><br> `ddoutonly` - Enables (`enabled`) or disables (`disabled`) demand dial outbound routing connections. <br><br> `phone` - Sets the phone number for the device. Accepts a string value such as a phone number, VPI/VCI, or IP address. <br><br> `maxports` - Specifies the maximum number of ports available for the device. |
| ras `show` | Displays information based on one of the following parameters: <br><br> `activeservers` - Displays advertisements from Remote Access servers. <br> `authmode` - Shows the current authentication mode. <br> `authtype` - Lists enabled authentication types. <br> `client` - Displays connected Remote Access clients and their status. To display a specific client, add `name=`. <br> `conf` - Shows the server's configuration state. <br> `ikev2connection` - Displays idle timeout and network outage settings for IKEv2 connections. <br> `ikev2saexpiry` - Shows IKEv2 SA expiration controls. <br> `link` - Lists PPP link properties to be negotiated. <br> `multilink` - Lists PPP multilink types to be negotiated. <br> `portstatus` - Displays the current status of RAS ports. To display a specific port and its state, use `name=` and `state=` subparameters. <br> `registeredserver` - Indicates if a computer is registered as a Remote Access server in AD. <br> `sstp-ssl-cert` - Shows the current SSTP certificate configuration. <br> `status` - Displays Routing and Remote Access Server status. <br> `type` - Shows router and RAS roles configured on the computer. <br> `user` - Displays Remote Access properties for users. To display specific user properties, use `name=` and `mode=` subparameters. <br> `wanports` - Shows configuration options for RAS WAN ports. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Remarks

`name` - Specify the DNS name or IP address of the RADIUS server or client device, username, network interface name, or network port name.

`secret` - Defines the shared secret used for authentication between the client and the RADIUS server.

`init-score` - Sets the initial priority score for the server. Higher scores indicate higher priority.

`port` - Indicates the port number used to send authentication or accounting requests to the RADIUS server.

`timeout` - Determines the time (in seconds) to wait for a response before marking the RADIUS server as unavailable.

`messages` - Controls whether accounting on/off messages are sent to the RADIUS server. Options are:

- `Enabled`
- `Disabled`

`server` - Specifies the DNS name or computer name to register as a Remote Access server. If omitted, the command registers the computer from which it's run.

`domain` - Specifies the AD domain where the server should be registered. If omitted, the computer's primary domain is used by default.

`state` - For diagnostics, sets tracing and logging options. Options are: `Enable`, `Disable`, and `Clear`. For client devices, `disconnect` removes the specified client and `resetstats` resets the statistical counters for the specified client, such as packets received, error counts, session counters, and others without disconnecting the client. For the RAS ports on your device, it displays which state the specified port is set to, such as:

- nonoperational (nonoperational ports)
- disconnected (the port is disconnected or not active)
- callingback (if the port is a callback port)
- listening (the port is listening for incoming calls)
- authenticating (the connected user is being authenticated)
- connected (authenticated and connected)
- initializing (initializing port for use)

`mode` - Is a multi use parameter where it can perform the following actions:

- Grant access levels for a device with options being `all` where clients are able to reach the remote access server and any networks to which it's connected, and `serveronly` where clients only reach the remote access server.
- You can `allow` or `deny` IP negotiation for client connections and if dial-in clients can request their own IP addresses.
- You can `enable` or `disable` broadcast name resolution where RAS clients resolve NetBIOS names on the local subnet when other resolution methods are unavailable.
- You can `enable` or `disable` router advertisement. A default route is a route with a zero-length prefix (`::/0`). To advertise itself as a default router, a computer acting as an IPv6 router must be configured with a default route (`::/0`) that's published.
- You can determine whether dial-in clients should be authenticated. Options are:
  - `STANDARD` - All devices must authenticate.
  - `NODCC` - Direct-connect devices aren't authenticated.
  - `BYPASS` - Authentication isn't required for any devices.
- You can filter user Remote Access information using `report` to show all users and `permit` to show only users whose dial-in permission is set to PERMIT.

`type` - This is either the type of authentication the Remote Access server uses to negotiate, link property PPP, or multilink PPP. Options are:

- **Authentication**

  - `PAP` - Password Authentication Protocol. Transmits credentials in clear text and is the least secure authentication method.

  - `MD5CHAP` - Challenge Handshake Authentication Protocol using MD5 hashing. Credentials are protected by a challenge-response mechanism with MD5 encryption.

  - `MSCHAPv2` - Microsoft Challenge Handshake Authentication Protocol version 2. Provides enhanced security over earlier versions, including mutual authentication and stronger encryption.

  - `EAP` - Extensible Authentication Protocol. Supports multiple authentication methods, such as smart cards, certificates, and token devices, allowing flexible and extensible authentication.

  - `CERT` - Certificate-based authentication for IKEv2 connections. Uses digital certificates to verify identity and establish secure connections.

- **Link PPP**

  - `SWC` - Enables software-based compression using Microsoft Point-to-Point Compression (MPPC), which reduces the size of transmitted data to optimize bandwidth usage.

  - `LCP` - Activates Link Control Protocol (LCP) extensions from the PPP protocol suite, allowing negotiation of link parameters and management of the PPP connection.

- **Multilink PPP**

  - `MULTI` - Enables multilink PPP sessions, allowing multiple physical links to be combined into a single logical connection for increased bandwidth and redundancy.

  - `BACP` - Activates Bandwidth Allocation Control Protocol, which dynamically manages bandwidth allocation across multiple links in a multilink PPP session to optimize performance.

## Examples

To add a new RADIUS accounting server called "AcctSrv1" with a shared secret of `P@ssw0rd`, an initial score of 50, listening on UDP port 1813, a 30-second timeout, and accounting messages enabled, run the following command:

```cmd
netsh ras aaaa add acctserver name=AcctSrv1 secret=P@ssw0rd init-score=50 port=1813 timeout=30 messages=ENABLED
```

To remove an existing RADIUS authentication server named "AuthSrv1", run the following command:

```cmd
netsh ras aaaa delete authserver name=AuthSrv1
```

To enable MS-CHAPv2 authentication for incoming RAS connections, run the following command:

```cmd
netsh ras add authtype type=MSCHAPv2
```

To remove the LCP link-control protocol from RAS, run the following command:

```cmd
netsh ras delete link type=LCP
```

To log only warning-level RAS diagnostic events, run the following command:

```cmd
netsh ras diagnostics set loglevel events=warn
```

To specify "Ethernet 2" as the preferred network adapter for RAS IP connections, run the following command:

```cmd
netsh ras ip set preferredadapter name="Ethernet 2"
```

To set the IPv6 prefix 2001:0db8:85a3::/64 that RAS hands out to clients, run the following command:

```cmd
netsh ras ipv6 set prefix prefix=2001:0db8:85a3::/64
```

To set the IKEv2 SA to expire after 1 hour (3,600 seconds) or once 1 GB (1,073,741,824 bytes) of data is transferred, run the following command:

```cmd
netsh ras set ikev2saexpiry saexpirytime=3600 sadatasizelimit=1073741824
```

To display the complete RAS configuration, run the following command:

```cmd
netsh ras show conf
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

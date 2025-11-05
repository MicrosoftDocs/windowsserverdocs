---
title: netsh http
description: The netsh http command configures and manages HTTP traffic for applications and system components for the HTTP Service in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/19/2025
---

# netsh http

The `netsh http` command enables you to configure and manage HTTP settings for the HTTP Service in Windows. This service handles HTTP traffic for applications and system components, allowing you to control aspects such as SSL certificates, IP listen lists, cache parameters, and timeouts. Use this command to fine-tune HTTP behavior, enhance security, and troubleshoot network issues related to HTTP traffic.

## Syntax

```
netsh http [add | delete | dump | flush | help | show | update | ?]
```

```
netsh http add cacheparam [type=](cacherangechunksize|maxcacheresponsesize)
                          [value=]<ulong>

netsh http add iplisten [ipaddress=]<IP address>

netsh http add setting [settingtype=]sslthrottle
                       [value=]<ulong>

netsh http add timeout [timeouttype=]idleconnectiontimeout|headerwaittimeout
                       [value=]<u-short>
```

```
netsh http add sslcert [hostnameport=<name:port> | ipport=<ipaddr:port> | ccs=<port>] | json=[filepath]
                       [appid=<GUID>] [certhash=<string>] [certstorename=<string>] [verifyclientcertrevocation=enable|disable]
                       [verifyrevocationwithcachedclientcertonly=enable|disable] [usagecheck=enable|disable]
                       [revocationfreshnesstime=<u-int>] [urlretrievaltimeout=<u-int>] [sslctlidentifier=<string>]
                       [sslctlstorename=<string>] [dsmapperusage=enable|disable] [clientcertnegotiation=enable|disable]
                       [reject=enable|disable] [disablehttp2=enable|disable] [disablequic=enable|disable]
                       [disablelegacytls=enable|disable] [disabletls12=enable|disable] [disabletls13=enable|disable]
                       [disableocspstapling=enable|disable] [enabletokenbinding=enable|disable] [logextendedevents=enable|disable]
                       [enablesessionticket=enable|disable] [disablesessionid=enable|disable]
```

```
netsh http add urlacl [url=]<string> [user=]<string> [listen=]yes|no [delegate=]yes|no [sddl=]<string>
```

```
netsh http delete cache [url=<string>] [recursive=yes|no]
netsh http delete iplisten [ipaddress=<IP address>]
netsh http delete setting [settingtype=]sslthrottle
netsh http delete sslcert ipport=<ipaddr:port> | hostnameport=<name:port> | ccs=<port>
netsh http delete timeout [timeouttype=](idleconnectiontimeout|headerwaittimeout)
netsh http delete urlacl [url=]<string>
```

```
netsh http dump
```

```
netsh http flush logbuffer
```

```
netsh http show <cacheparam> <iplisten> <setting> <timeout>
netsh http show cachestate [url=<string>]
netsh http show servicestate [view=session|requestq|client] [verbose=yes|no]
netsh http show sslcert [ipport=<ipaddr:port> | hostnameport=<name:port> | ccs=<port> | scopedccs=<name:port>] [json=enable]
netsh http show urlacl [url=<string>]
```

```
netsh http update sslcert [hostnameport=<name:port> | ipport=<ipaddr:port> | ccs=<port>] | json=[filepath]
                          [appid=<GUID>] [certhash=<string>] [certstorename=<string>] [verifyclientcertrevocation=enable|disable]
                          [verifyrevocationwithcachedclientcertonly=enable|disable] [usagecheck=enable|disable]
                          [revocationfreshnesstime=<u-int>] [urlretrievaltimeout=<u-int>] [sslctlidentifier=<string>]
                          [sslctlstorename=<string>] [dsmapperusage=enable|disable] [clientcertnegotiation=enable|disable]
                          [reject=enable|disable] [disablehttp2=enable|disable] [disablequic=enable|disable]
                          [disablelegacytls=enable|disable] [disabletls12=enable|disable] [disabletls13=enable|disable]
                          [disableocspstapling=enable|disable] [enabletokenbinding=enable|disable] [logextendedevents=enable|disable]
                          [enablesessionticket=enable|disable] [disablesessionid=enable|disable]
```

```
netsh http show update sslpropertyex [hostnameport=<name:port> | ipport=<ipaddr:port> | ccs=<port>] |
                                     [propertyid=0 receivewindow=<bytes>] [propertyid=1 maxsettingsperframe=<value> maxsettingsperminute=<value>]
```

## Parameters

| Command | Description |
|--|--|
| http `add cacheparam` | Configures and adds specific parameters to the HTTP Service cache. <br><br> `type` - Specifies the type of parameter to be configured. Options are `cacherangechunksize` and `maxcacheresponsesize`. <br><br> `value` - Denotes the parameter value, measured in bytes. If using a hexadecimal representation, prefix the value with `0x`. |
| http `add iplisten` | Adds a new IP address to the IP listen list for the HTTP Service. This list specifies the IP addresses to which the HTTP Service binds, excluding port numbers. The address '0.0.0.0' represents all IPv4 addresses, while '::' represents all IPv6 addresses. The format uses `ipaddress=IP_Address`. |
| http `add setting` | Adds a global configuration setting to the HTTP Service. <br><br> `settingtype=sslthrottle` - Specifies the throttling limit for SSL connections. <br><br> `value` - requires a non-negative integer value (ulong) to set the desired throttling level. |
| http `add sslcert` | Adds SSL certificate binding for a specified IP address or hostname and port, along with corresponding client certificate policies, to securely manage HTTPS connections for the HTTP Service. <br><br> See [Remarks](#remarks) for parameter description details. |
| http `add timeout` | Defines a global timeout setting for the HTTP Service. <br><br> `timeouttype=` options include: <br><li> `idleconnectiontimeout` - Specifies the maximum duration that an idle connection can be maintained before being closed. <li> `headerwaittimeout` - Defines the maximum time to wait for the complete set of HTTP headers to be received. </li><br> The `value` parameter requires a non-negative integer (u-short) representing the timeout duration in *seconds*. |
| http `add urlacl` | Allows non-administrator users and accounts to register the URL. The access permissions can be defined either by specifying an NT account name along with the `listen` and `delegate` parameters, or by using a Security Descriptor Definition Language (SDDL) string for the Discretionary Access Control List (DACL). <br><br> `url=` - Specifies the fully qualified URL that you want to associate with the Access Control List (ACL). This must include the protocol (for example, `http://` or `https://`), domain, and any necessary port or path segments. <br> `user=` - Identifies the user or user-group name that is granted access. This can be in the format of a single user name, a user group, or a security principal. <br> `listen` - Determines whether the specified user has permission to register the URL. Options include: <li> `yes` - Grants the user permission to register the specified URL (default setting). <li> `no` - Prevents the user from registering the specified URL. </li> `delegate` - Determines whether the specified user has permission to delegate the URL. Options include: <li> `yes` - Allows the user to delegate URL management to other users. <li> `no` - Prevents the user from delegating URL management to others (default setting). </li> `sddl` - The SDDL string that provides a detailed description of the Discretionary Access Control List (DACL) associated with the URL ACL, specifying the permissions and access rights for users and groups. |
| http `delete cache` | Clears the entire URI cache or removes specific entries based on the specified URI. <br><br> `url=` - Specifies the URL entry in the HTTP cache that you want to delete. <br><br> `recursive` - Accepts a value of `yes` or `no`. When set to `yes`, it removes not only the specified URL entry but also all entries under that URL, effectively clearing the cache for the specified URL and any sub-URLs or associated resources. When set to `no`, only the specified URL is removed from the cache without affecting any subentries. |
| http `delete iplisten` | Removes an IP address from the IP listen list. <br><br> `ipaddress=` - Specifies the IP address that you want to remove from the HTTP listener list. |
| http `delete setting` | Removes a global configuration setting, causing the HTTP Service to revert to its default behavior for that particular parameter. <br><br> `settingtype=sslthrottle` - Removes the SSL throttle setting. |
| http `delete timeout` | Removes a global timeout setting, restoring the HTTP Service's timeout behavior to its default values. <br><br><li> `timeouttype=idleconnectiontimeout` - Specifies that you want to remove the setting for the idle connection timeout. The idle connection timeout defines how long an idle (inactive) TCP connection should be kept open before it's closed. Removing this setting reverts any custom idle timeout value to its default state. <li> `timeouttype=headerwaittimeout` - Specifies that you want to remove the setting for the header wait timeout. The header wait timeout determines how long the server waits for an HTTP request header to be received before timing out. Removing this setting reverts any custom header wait timeout value to its default state. </li> |
| http `delete urlacl` | Deletes a reserved URL, freeing up the specified URL from being exclusively used by the HTTP Service. <br><br> `url=` - Specifies the URL reservation that you want to delete. |
| http `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| http `flush logbuffer` | Clears the internal buffers for the log files. |
| http `show` `cacheparam` \| `iplisten` \| `setting` \| `timeout` | <li> Displays the cache parameters of the HTTP Service measured in bytes (`cacheparam`). <li> Lists all IP addresses currently included in the IP listen list (`iplisten`). <li> Displays the current configuration settings of the HTTP Service in seconds (`setting`). <li> Displays the timeout values set for the HTTP Service in seconds (`timeout`). </li> |
| http `show cachestate` | Enumerates all resources and their properties stored in the HTTP response cache, or it provides detailed information about a specific resource and its associated properties. <br><br> `url=` - Specifies a particular URL for which you want to view the cache state. |
| http `show servicestate` | Displays a current snapshot of the HTTP Service. <br><br> `view=` - Specifies which aspect of the HTTP service state you wish to view. You can choose one of the following options: <li> `session` - Displays information about active sessions, including connection and session details. <li> `requestq` - Shows the state of the request queue, providing insights into the number of requests being processed and queued. <li> `client` - Provides information about client connections, such as the number of connected clients and connection details. </li><br> `verbose=` - Determines the level of detail included in the output. <li> `yes` - Provides detailed information, offering a more comprehensive view of the selected service state. <li> `no` - Presents a summary with less detail, useful for a quick overview of the service state. </li> |
| http `show sslcert` | Lists SSL server certificate bindings along with their associated client certificate policies. If no specific binding is provided, all available bindings are displayed. <br><br> `scopedccs=name:port` - Specifies a scoped central certificate store (CCS) entry by providing a hostname and port. Similar to the `hostnameport` parameter, it focuses the output on certificates related to a specific scoped CCS configuration. <br><br> Available subparameters are: <li> `ipport=ipaddr:port` <li> `hostnameport=name:port` <li> `ccs=port` <li> `json=enable` <br><br> See [Remarks](#remarks) for parameter description details. |
| http `show urlacl` | Displays the DACLs for a specified reserved URL or for all reserved URLs, offering insights into their access permissions. <br><br> `url=` - Specifies the URL reservation for which you want to view details. |
| http `update sslcert` | Updates an existing SSL server certificate binding and associated client certificate policies for a specified IP address or hostname and port. <br><br> See [Remarks](#remarks) for parameter description details. |
| http `update sslpropertyex` | Modifies the parameters of an existing SSL server certificate binding and its related client certificate policies for a given IP address or hostname and port. <br><br><li> `propertyid=0 receivewindow=<bytes>` - Updates the receive window size for SSL connections. `propertyid=0` identifies this specific property, and `receivewindow=<bytes>` sets the size of the receive window in bytes. <li> `propertyid=1 maxsettingsperframe=<value> maxsettingsperminute=<value>` - Updates the HTTP/2 settings related to SSL connections. Here, `propertyid=1` specifies this particular property, while `maxsettingsperframe=<value>` sets the maximum number of settings frames allowed per frame, and `maxsettingsperminute=<value>` sets the maximum number of settings frames permitted per minute. </li><br> Other available subparameters are: <li> `hostnameport=name:port` <li> `ipport=ipaddr:port` <li> `ccs=port` </li><br> See [Remarks](#remarks) for parameter description details. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Remarks

- `hostnameport=name:port`: Specifies the binding using a hostname and port number. This option binds the SSL certificate to a specific hostname (such as `www.example.com`) on a specified port (typically port 443 for HTTPS).

- `ipport=ipaddr:port`: Specifies the binding using an IP address and port number. This binds the SSL certificate to a particular IP address (such as `192.168.1.1`) and a port.

- `ccs=port`: Refers to a Central Certificate Store (CCS) port. In this context, CCS allows for centralized management of SSL certificates across multiple servers, using a specific port for SSL bindings.

- `json=filepath`: Uses a JSON file for configuring the SSL binding. This option allows for complex or bulk configuration settings to be specified in JSON format that the HTTP Service can parse and apply.

- `appid=GUID`: The unique identifier (GUID) for the application associated with the certificate binding.

- `certhash=<string>`: The certificate hash (often represented as a thumbprint) of the SSL certificate to be bound.

- `certstorename=<string>`: The name of the certificate store where the SSL certificate is located (for example, `MY` for the personal store).

- `verifyclientcertrevocation=`: Enables or disables verification of client certificate revocation status. Options are `enable` or `disable`.

- `verifyrevocationwithcachedclientcertonly=`: Determines whether only cached client certificates are used for revocation checking. Options are `enable` or `disable`.

- `usagecheck=`: Checks the certificate usage policies. Options are `enable` or `disable`. Default is **enabled**.

- `revocationfreshnesstime=`: Sets the freshness time for revocation data in *seconds*. If the value is set to `0`, then the new CRL updates only if the previous one expires.

- `urlretrievaltimeout=`: Defines the timeout for retrieving revocation URLs in *milliseconds*.

- `sslctlidentifier=<string>`: The identifier for the SSL certificate trust list (CTL) to be used.

- `sslctlstorename=<string>`: Specifies the name of the certificate store under the `LOCAL_MACHINE` registry hive where the SSL CTL is stored.

- `dsmapperusage=`: Enables or disables the use of the Active Directory DSMapper for client certificate mapping. Options are `enable` or `disable`.

- `clientcertnegotiation=`: Controls negotiation for client certificates during the SSL handshake. Options are `enable` or `disable`. Default is **disabled**.

- `reject=`: Specifies the rejection of SSL connections based on certain criteria. Options are `enable` or `disable`.

- `disablehttp2=`: Enables or disables HTTP/2 protocol support. Options are `enable` or `disable`.

- `disablequic=`: Enables or disables QUIC protocol support. Options are `enable` or `disable`.

- `disablelegacytls=`: Enables or disables the use of legacy TLS protocols. Options are `enable` or `disable`.

- `disabletls12=` | `disabletls13=`: Enables or disables specific versions of the TLS protocol (TLS 1.2 or TLS 1.3). Options are `enable` or `disable`.

- `disableocspstapling=`: Enables or disables OCSP stapling, which is used for checking certificate revocation status. Options are `enable` or `disable`.

- `enabletokenbinding=`: Enables or disables token binding for enhanced security. Options are `enable` or `disable`.

- `logextendedevents=`: Enables or disables logging of extended events for diagnostic purposes. Options are `enable` or `disable`.

- `enablesessionticket=`: Controls whether SSL session tickets are enabled for session resumption. Options are `enable` or `disable`.

- `disablesessionid=`: Controls whether SSL session IDs are disabled for session resumption. Options are `enable` or `disable`.

## Examples

To reserve the URL `http://example.com:8080/` for the user `DOMAIN\UserName` with listening permissions enabled, run the following command:

```cmd
netsh http add urlacl url=http://example.com:8080/ user=DOMAIN\UserName listen=yes
```

To remove a specific IP address from the list of addresses HTTP.sys listens on, run the following command:

```cmd
netsh http delete iplisten ipaddress=192.168.1.100
```

To display the cache state for a specific URL, run the following command:

```cmd
netsh http show cachestate url=http://example.com
```

To remove a URL reservation, run the following command:

```cmd
netsh http delete urlacl url=http://+:80/MyApp
```

To display details about a specific URL reservation, run the following command:

```cmd
netsh http show urlacl url=http://+:80/MyApp
```

To view SSL certificate details for a specific IP and port, run the following command:

```cmd
netsh http show sslcert ipport=192.168.1.100:443
```

To update HTTP/2 settings regarding SSL connections on a specific IP and port, allowing `100` frames at `1000` minutes, run the following command:

```cmd
netsh http update sslpropertyex ipport=192.168.1.100:443 propertyid=1 maxsettingsperframe=100 maxsettingsperminute=1000
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

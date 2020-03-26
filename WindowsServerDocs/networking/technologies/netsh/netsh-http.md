---
title: Netsh Commands for Hypertext Transfer Protocol (HTTP)
description: Use netsh http to query and configure HTTP.sys settings and parameters.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 
manager: dougkim
ms.author: lizross
author: eross-msft
---

# Netsh http commands


Use **netsh http** to query and configure HTTP.sys settings and parameters.  

>[!TIP]
>If you are using Windows PowerShell on a computer running Windows Server 2016 or Windows 10, type **netsh** and press Enter. At the netsh prompt, type **http** and press Enter to get the netsh http prompt.
>
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;netsh http\>

The available netsh http commands are:

- [add iplisten](#add-iplisten)
- [add sslcert](#add-sslcert)
- [add timeout](#add-timeout)
- [add urlacl](#add-urlacl)
- [delete cache](#delete-cache)
- [delete iplisten](#delete-iplisten)
- [delete sslcert](#delete-sslcert)
- [delete timeout](#delete-timeout)
- [delete urlacl](#delete-urlacl)
- [flush logbuffer](#flush-logbuffer)
- [show cachestate](#show-cachestate)
- [show iplisten](#show-iplisten)
- [show servicestate](#show-servicestate)
- [show sslcert](#show-sslcert)
- [show timeout](#show-timeout)
- [show urlacl](#show-urlacl)

## add iplisten

Adds a new IP address to the IP listen list, excluding the port number.

**Syntax**

```powershell
add iplisten [ ipaddress= ] IPAddress
```

**Parameters**

|               |                                                                                                                                                                                                                          |          |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| **ipaddress** | The IPv4 or IPv6 address to be added to the IP listen list. The IP listen list is used to scope the list of addresses to which the HTTP service binds. "0.0.0.0" means any IPv4 address and "::" means any IPv6 address. | Required |

---

**Examples**

Following are four examples of the **add iplisten** command.

-   add iplisten ipaddress=fe80::1
-   add iplisten ipaddress=1.1.1.1
-   add iplisten ipaddress=0.0.0.0
-   add iplisten ipaddress=::

---

## add sslcert

Adds a new SSL server certificate binding and corresponding client certificate policies for an IP address and port.

**Syntax**

```powershell
add sslcert [ ipport= ] IPAddress:port [ certhash= ] CertHash [ appid= ] GUID [ [ certstorename= ] CertStoreName [ verifyclientcertrevocation= ] enable | disable [verifyrevocationwithcachedclientcertonly= ] enable | disable [ usagecheck= ] enable | disable [ revocationfreshnesstime= ] U-Int [ urlretrievaltimeout= ] U-Int [sslctlidentifier= ] SSLCTIdentifier [ sslctlstorename= ] SLCtStoreName [ dsmapperusage= ] enable | disable [ clientcertnegotiation= ] enable | disable ] ]
```

**Parameters**


|                                              |                                                                                                                                                                                          |          |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
|                  **ipport**                  |                       Specifies the IP address and port for the binding. A colon character (:) is used as a delimiter between the IP address and the port number.                        | Required |
|                 **certhash**                 |                                     Specifies the SHA hash of the certificate. This hash is 20 bytes long and is specified as a hexadecimal string.                                      | Required |
|                  **appid**                   |                                                                  Specifies the GUID to identify the owning application.                                                                  | Required |
|              **certstorename**               |                                  Specifies the store name for the certificate. Defaults to MY. Certificate must be stored in the local machine context.                                  | Optional |
|        **verifyclientcertrevocation**        |                                                      Specifies the Turns on/off verification of revocation of client certificates.                                                       | Optional |
| **verifyrevocationwithcachedclientcertonly** |                                      Specifies whether the usage of only cached client certificate for revocation checking is enabled or disabled.                                       | Optional |
|                **usagecheck**                |                                                      Specifies whether the usage check is enabled or disabled. Default is enabled.                                                       | Optional |
|         **revocationfreshnesstime**          | Specifies the time interval, in seconds, to check for an updated certificate revocation list (CRL). If this value is zero, then the new CRL is updated only if the previous one expires. | Optional |
|           **urlretrievaltimeout**            |                            Specifies the timeout interval (in milliseconds) after the attempt to retrieve the certificate revocation list for the remote URL.                            | Optional |
|             **sslctlidentifier**             |                Specifies the list of the certificate issuers that can be trusted. This list can be a subset of the certificate issuers that are trusted by the computer.                 | Optional |
|             **sslctlstorename**              |                                                Specifies the certificate store name under LOCAL_MACHINE where SslCtlIdentifier is stored.                                                | Optional |
|              **dsmapperusage**               |                                                        Specifies whether DS mappers is enabled or disabled. Default is disabled.                                                         | Optional |
|          **clientcertnegotiation**           |                                              Specifies whether the negotiation of certificate is enabled or disabled. Default is disabled.                                               | Optional |

---

**Examples**

Following is an example of the **add sslcert** command.

add sslcert ipport=1.1.1.1:443 certhash=0102030405060708090A0B0C0D0E0F1011121314
appid={00112233-4455-6677-8899- AABBCCDDEEFF}

---

## add timeout

Adds a global timeout to the service.

**Syntax** 

```powershell
add timeout [ timeouttype= ] IdleConnectionTimeout | HeaderWaitTimeout [ value=] U-Short
```

**Parameters**

|                 |                                                                                                     |
|-----------------|-----------------------------------------------------------------------------------------------------|
| **timeouttype** |                                    Type of timeout for setting.                                     |
|    **value**    | Value of the timeout (in seconds). If the value is in hexadecimal notation, then add the prefix 0x. |

---

**Examples**

Following are two examples of the **add timeout** command.

-   add timeout timeouttype=idleconnectiontimeout value=120
-   add timeout timeouttype=headerwaittimeout value=0x40

---

## add urlacl

Adds a Uniform Resource Locator (URL) reservation entry. This command reserves
the URL for non-administrator users and accounts. The DACL can be specified by
using an NT account name with the listen and delegate parameters or by using an
SDDL string.

**Syntax**

```powershell
add urlacl [ url= ] URL [ [user=] User [ [ listen= ] yes | no [ delegate= ] yes | no ] | [ sddl= ] SDDL ]
```

**Parameters**

|              |                                                                                                                                                  |          |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------|----------|
|   **url**    |                                          Specifies the fully qualified Uniform Resource Locator (URL).                                           | Required |
|   **user**   |                                                      Specifies the user or user-group name                                                       | Required |
|  **listen**  | Specifies one of the following values: yes: Allow the user to register URLs. This is the default value. no: Deny the user from registering URLs. | Optional |
| **delegate** |  Specifies one of the following values: yes: Allow the user to delegate URLs no: Deny the user from delegating URLs. This is the default value.  | Optional |
|   **sddl**   |                                                Specifies an SDDL string that describes the DACL.                                                 | Optional |

---

**Examples**

Following are four examples of the **add urlacl** command.

- add urlacl url=https://+:80/MyUri user=DOMAIN\\user
- add urlacl url=<https://www.contoso.com:80/MyUri> user=DOMAIN\\user listen=yes
- add urlacl url=<https://www.contoso.com:80/MyUri> user=DOMAIN\\user delegate=no
- add urlacl url=https://+:80/MyUri sddl=...

---

## delete cache

Deletes all the entries, or a specified entry, from the HTTP service kernel URI
cache.

**Syntax**

```powershell
delete cache [ [ url= ] URL [ [recursive= ] yes | no ]
```

**Parameters**

|               |                                                                                                                              |          |
|---------------|------------------------------------------------------------------------------------------------------------------------------|----------|
|    **url**    |                    Specifies the fully qualified Uniform Resource Locator (URL) that you want to delete.                     | Optional |
| **recursive** | Specifies whether all entries under the url cache get removed. **yes**: remove all entries **no**: do not remove all entries | Optional |

---

**Examples**

Following are two examples of the **delete cache** command.

- delete cache url=<https://www.contoso.com:80/myresource/> recursive=yes
- delete cache

---

## delete iplisten

Deletes an IP address from the IP listen list. The IP listen list is used to
scope the list of addresses to which the HTTP service binds.

**Syntax**

```powershell
delete iplisten [ ipaddress= ] IPAddress
```

**Parameters**

|               |                                                                                                                                                                                                                                                                     |          |
|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| **ipaddress** | The IPv4 or IPv6 address to be deleted from the IP listen list. The IP listen list is used to scope the list of addresses to which the HTTP service binds. "0.0.0.0" means any IPv4 address and "::" means any IPv6 address. This does not include the port number. | Required |

---


**Examples**

Following are four examples of the **delete iplisten** command.

-   delete iplisten ipaddress=fe80::1
-   delete iplisten ipaddress=1.1.1.1
-   delete iplisten ipaddress=0.0.0.0
-   delete iplisten ipaddress=::

---

## delete sslcert


Deletes SSL server certificate bindings and corresponding client certificate
policies for an IP address and port.

**Syntax**

```powershell
delete sslcert [ ipport= ] IPAddress:port
```

**Parameters**

|            |                                                                                                                                                                                          |          |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| **ipport** | Specifies the IPv4 or IPv6 address and port for which the SSL certificate bindings get deleted. A colon character (:) is used as a delimiter between the IP address and the port number. | Required |

---


**Examples**

Following are three examples of the **delete sslcert** command.

- delete sslcert ipport=1.1.1.1:443
- delete sslcert ipport=0.0.0.0:443
- delete sslcert ipport=[::]:443

---

## delete timeout

Deletes a global timeout and makes the service revert to default values.

**Syntax**

```powershell
delete timeout [ timeouttype= ] idleconnectiontimeout | headerwaittimeout
```

**Parameters**

|                 |                                        |          |
|-----------------|----------------------------------------|----------|
| **timeouttype** | Specifies the type of timeout setting. | Required |

---


**Examples**

Following are two examples of the **delete timeout** command.

-   delete timeout timeouttype=idleconnectiontimeout
-   delete timeout timeouttype=headerwaittimeout

---

## delete urlacl

Deletes URL reservations.

**Syntax**

```powershell
delete urlacl [ url= ] URL
```

**Parameters**

|         |                                                                                       |          |
|---------|---------------------------------------------------------------------------------------|----------|
| **url** | Specifies the fully qualified Uniform Resource Locator (URL) that you want to delete. | Required |

---


**Examples**

Following are two examples of the **delete urlacl** command.

- delete urlacl url=https://+:80/MyUri
- delete urlacl url=<https://www.contoso.com:80/MyUri>

---

## flush logbuffer

Flushes the internal buffers for the logfiles.

**Syntax**

```powershell
flush logbuffer
```

---

## show cachestate

Lists cached URI resources and their associated properties. This command lists
all resources and their associated properties that are cached in HTTP response
cache or displays a single resource and its associated properties.

**Syntax**

```powershell
show cachestate [ [url= ] URL]
```

**Parameters**

|         |                                                                                                                                                    |          |
|---------|----------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| **url** | Specifies the fully qualified URL that you want to display. If not specified, display all URLs. The URL could also be a prefix to registered URLs. | Optional |

---


**Examples**

Following are two examples of the **show cachestate** command:

- show cachestate url=<https://www.contoso.com:80/myresource>
- show cachestate

---

## show iplisten

Displays all IP addresses in the IP listen list. The IP listen list is used to
scope the list of addresses to which the HTTP service binds. "0.0.0.0" means any
IPv4 address and "::" means any IPv6 address.

**Syntax**

```powershell
show iplisten
```

---

## show servicestate

Displays a snapshot of the HTTP service.

**Syntax**
```powershell
show servicestate [ [ view= ] session | requestq ] [ [ verbose= ] yes | no ]
```

**Parameters**

|             |                                                                                                                      |          |
|-------------|----------------------------------------------------------------------------------------------------------------------|----------|
|  **View**   | Specifies whether to view a snapshot of the HTTP service state based on the server session or on the request queues. | Optional |
| **Verbose** |                Specifies whether to display verbose information that also shows property information.                | Optional |

---

**Examples**

Following are two examples of the **show servicestate** command.

-   show servicestate view="session"
-   show servicestate view="requestq"

---

## show sslcert

Displays Secure Sockets Layer (SSL) server certificate bindings and
corresponding client certificate policies for an IP address and port.

**Syntax**

```powershell
show sslcert [ ipport= ] IPAddress:port
```

**Parameters**

|            |                                                                                                                                                                                                                                                |          |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| **ipport** | Specifies the IPv4 or IPv6 address and port for which the SSL certificate bindings display. A colon character (:) is used as a delimiter between the IP address and the port number. If you do not specify ipport, all bindings are displayed. | Required |

---


**Examples**

Following are five examples of the **show sslcert** command.

-   show sslcert ipport=[fe80::1]:443
-   show sslcert ipport=1.1.1.1:443
-   show sslcert ipport=0.0.0.0:443
-   show sslcert ipport=[::]:443
-   show sslcert

---

## show timeout

Displays, in seconds, the timeout values of the HTTP service.

**Syntax**

```powershell
show timeout
```

---

## show urlacl

Displays discretionary access control lists (DACLs) for the specified reserved URL or all reserved URLs.

**Syntax**

```powershell
show urlacl [ [url= ] URL]
```

**Parameters**

|         |                                                                                                |          |
|---------|------------------------------------------------------------------------------------------------|----------|
| **url** | Specifies the fully qualified URL that you want to display. If not specfied, display all URLs. | Optional |

---


**Examples**

Following are three examples of the **show urlacl** command.

- show urlacl url=https://+:80/MyUri
- show urlacl url=<https://www.contoso.com:80/MyUri>
- show urlacl

---
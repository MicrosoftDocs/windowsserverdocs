---
title: Netsh commands for interface portproxy
description: Use the netsh interface portproxy commands to act as proxies between IPv4 and IPv6 networks and applications.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 08/30/2018
---


# Netsh interface portproxy commands

Use the **netsh interface portproxy** commands to act as proxies between IPv4 and IPv6 networks and applications. You can use these commands to establish proxy service in the following ways:

-   IPv4-configured computer and application messages sent to other IPv4-configured computers and applications.

-   IPv4-configured computer and application messages sent to IPv6-configured computers and applications.

-   IPv6-configured computer and application messages sent to IPv4-configured computers and applications.

-   IPv6-configured computer and application messages sent to other IPv6-configured computers and applications.

When writing batch files or scripts using these commands, each command must start with **netsh interface portproxy**. For example, when using the **delete v4tov6** command to specify that the portproxy server deletes an IPv4 port and address from the list of IPv4 addresses for which the server listens, the batch file or script must use the following syntax:

```PowerShell
netsh interface portproxy delete v4tov6listenport= {Integer | ServiceName} [[listenaddress=] {IPv4Address| HostName}] [[protocol=]tcp]
```

The available netsh interface portproxy commands are:

-   [add v4tov4](#add-v4tov4)

-   [add v4tov6](#add-v4tov6)

-   [add v6tov4](#add-v6tov4)

-   [add v6tov6](#add-v6tov6)

-   [delete v4tov4](#delete-v4tov4)

-   [delete v4tov6](#delete-v4tov6)

-   [delete v6tov6](#delete-v6tov6)

-   [reset](#reset)

-   [set v4tov4](#set-v4tov4)

-   [set v4tov6](#set-v4tov6)

-   [setv6tov4](#set-v6tov4)

-   [set v6tov6](#set-v6tov6)

-   [show all](#show-all)

-   [show v4tov4](#show-v4tov4)

-   [show v4tov6](#show-v4tov6)

-   [show v6tov4](#show-v6tov4)

-   [show v6tov6](#show-v6tov6)


## add v4tov4

The portproxy server listens for messages sent to a specific port and IPv4 address and maps a port and IPv4 address to send the messages received after establishing a separate TCP connection.

### Syntax

```PowerShell
add v4tov4 listenport= {Integer | ServiceName} [[connectaddress=] {IPv4Address | HostName}] [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv4Address | HostName}] [[protocol=]tcp]
```

### Parameters


|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv4 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv4 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv4 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv4 address for which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## add v4tov6

The portproxy server listens for messages sent to a specific port and IPv4 address, and maps a port and IPv6 address to send the messages received after establishing a separate TCP connection.

### Syntax

```PowerShell
add v4tov6 listenport= {Integer | ServiceName} [[connectaddress=] {IPv6Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv4Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv4 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv6 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv6 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv4 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## add v6tov4

The portproxy server listens for messages sent to a specific port and IPv6 address, and maps a port and IPv4 address to which to send the messages received after establishing a separate TCP connection.

### Syntax

```PowerShell
add v6tov4 listenport= {Integer | ServiceName} [[connectaddress=] {IPv4Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv6 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv4 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv4 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv6 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## add v6tov6

The portproxy server listens for messages sent to a specific port and IPv6 address, and maps a port and IPv6 address to which to send the messages received after establishing a separate TCP connection.

### Syntax

```PowerShell
add v6tov6 listenport= {Integer | ServiceName} [[connectaddress=] {IPv6Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv6 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv6 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv6 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv6 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## delete v4tov4

The portproxy server deletes an IPv4 address from the list of IPv4 ports and addresses for which the server listens.

### Syntax

```PowerShell
delete v4tov4 listenport= {Integer | ServiceName} [[listenaddress=] {IPv4Address | HostName} [[protocol=]tcp]
```

### Parameters

|                   |                                                                                                          |
|-------------------|----------------------------------------------------------------------------------------------------------|
|  **listenport**   |                                    Specifies the IPv4 port to delete.                                    |
| **listenaddress** | Specifies the IPv4 address to delete. If an address is not specified, the default is the local computer. |
|   **protocol**    |                                      Specifies the protocol to use.                                      |

## delete v4tov6

The portproxy server deletes an IPv4 port and address from the list of IPv4 addresses for which the server listens.

### Syntax

```PowerShell 
delete v4tov6 listenport= {Integer | ServiceName} [[listenaddress=] {IPv4Address | HostName} [[protocol=]tcp]
```

### Parameters

|                   |                                                                                                          |
|-------------------|----------------------------------------------------------------------------------------------------------|
|  **listenport**   |                                    Specifies the IPv4 port to delete.                                    |
| **listenaddress** | Specifies the IPv4 address to delete. If an address is not specified, the default is the local computer. |
|   **protocol**    |                                      Specifies the protocol to use.                                      |

## delete v6tov4

The portproxy server deletes an IPv6 port and address from the list of IPv6 addresses for which the server listens.

### Syntax

```PowerShell
delete v6tov4 listenport= {Integer | ServiceName} [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                   |                                                                                                          |
|-------------------|----------------------------------------------------------------------------------------------------------|
|  **listenport**   |                                    Specifies the IPv6 port to delete.                                    |
| **listenaddress** | Specifies the IPv6 address to delete. If an address is not specified, the default is the local computer. |
|   **protocol**    |                                      Specifies the protocol to use.                                      |

## delete v6tov6

The portproxy server deletes an IPv6 address from the list of IPv6 addresses for which the server listens.

### Syntax

```PowerShell
delete v6tov6 listenport= {Integer | ServiceName} [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                   |                                                                                                          |
|-------------------|----------------------------------------------------------------------------------------------------------|
|  **listenport**   |                                    Specifies the IPv6 port to delete.                                    |
| **listenaddress** | Specifies the IPv6 address to delete. If an address is not specified, the default is the local computer. |
|   **protocol**    |                                      Specifies the protocol to use.                                      |

## reset

Resets the IPv6 configuration state.

### Syntax

`reset`

## set v4tov4

Modifies the parameter values of an existing entry on the portproxy server created with the **add v4tov4** command, or adds a new entry to the list that maps port/address pairs.

### Syntax

```PowerShell
set v4tov4 listenport= {Integer | ServiceName} [[connectaddress=] {IPv4Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv4Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv4 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv4 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv4 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv4 address for which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## set v4tov6

Modifies the parameter values of an existing entry on the portproxy server created with the **add v4tov6** command, or adds a new entry to the list that maps port/address pairs.

### Syntax

```PowerShell
set v4tov6 listenport= {Integer | ServiceName} [[connectaddress=] {IPv6Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv4Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv4 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv6 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv6 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv4 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## set v6tov4

Modifies the parameter values of an existing entry on the portproxy server created with the **add v6tov4** command, or adds a new entry to the list that maps port/address pairs.

### Syntax

```PowerShell
set v6tov4 listenport= {Integer | ServiceName} [[connectaddress=] {IPv4Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                           Specifies the IPv6 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv4 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer. |
|  **connectport**   |       Specifies the IPv4 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv6 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|    **protocol**    |                                                                                  Specifies the protocol to use.                                                                                   |

## set v6tov6

Modifies the parameter values of an existing entry on the portproxy server created with the **add v6tov6** command, or adds a new entry to the list that maps port/address pairs.

### Syntax

```PowerShell 
set v6tov6 listenport= {Integer | ServiceName} [[connectaddress=] {IPv6Address | HostName} [[connectport=] {Integer | ServiceName}] [[listenaddress=] {IPv6Address | HostName} [[protocol=]tcp]
```

### Parameters

|                    |                                                                                                                                                                                                    |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   **listenport**   |                                                            Specifies the IPv6 port, by port number or service name, on which to listen.                                                            |
| **connectaddress** | Specifies the IPv6 address to which to connect. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If an address is not specified, the default is the local computer.  |
|  **connectport**   |        Specifies the IPv6 port, by port number or service name, to which to connect. If **connectport** is not specified, the default is the value of **listenport** on the local computer.        |
| **listenaddress**  | Specifies the IPv6 address on which to listen. Acceptable values are IP address, computer NetBIOS name, or computer DNS name. If you do not specify an address, the default is the local computer. |
|    **protocol**    |                                                                                   Specifies the protocol to use.                                                                                   |

## show all

Displays all portproxy parameters, including port/address pairs for v4tov4, v4tov6, v6tov4, and v6tov6.

### Syntax

`show all`


## show v4tov4

Displays v4tov4 portproxy parameters.

### Syntax

`show v4tov4`

## show v4tov6

Displays v4tov6 portproxy parameters.

### Syntax

`show v4tov6`

## show v6tov4

Displays v6tov4 portproxy parameters.

### Syntax

`show v6tov4`


## show v6tov6

Displays v6tov6 portproxy parameters.

### Syntax

`show v6tov6`

---

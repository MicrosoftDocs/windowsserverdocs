---
title: netsh winhttp
description: The netsh winhttp command configures and manages WinHTTP settings for network communications for applications that use WinHTTP in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/19/2025
---

# netsh winhttp

The `netsh winhttp` command configures and manages the WinHTTP (Windows HTTP Services) settings. WinHTTP is a Microsoft API used by applications to make HTTP requests which allows administrators to manage network communications for applications that use WinHTTP.

## Syntax

```
netsh winhttp [dump | help | import | reset | set| show | ?]
```

```
netsh winhttp dump
```

```
netsh winhttp import proxy [source=]ie
```

```
netsh winhttp reset <autoproxy> <proxy> <tracing>
```

```
netsh winhttp set advproxy <settings-scope> <settings-file> <settings>
netsh winhttp set proxy [proxy-server=]<server name> [bypass-list=]<hosts list>
netsh winhttp set tracing
```

```
netsh winhttp show <advproxy> <proxy> <tracing>
```

## Parameters

| Command | Description |
|--|--|
| http `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| winhttp `import proxy source=ie` | Import proxy settings into the WinHTTP configuration from the Internet Explorer (IE) settings. There isn't any direct built-in support for importing settings from other browsers using this command. |
| winhttp `reset` `<autoproxy>` \| `<proxy>` \| `<tracing>` | Provides options to reset various components of the WinHTTP configuration, such as: <br><br><li> `autoproxy` - Resets the WinHTTP proxy autodiscovery service. This is used to clear any settings or cache related to the automatic detection of proxy servers. <li> `proxy` - Resets the WinHTTP proxy setting to `DIRECT`, effectively removing any configured proxy server and allowing direct internet access without a proxy. <li> `tracing` - For this operation, the system advises using the `netsh trace stop` command, which is intended to stop and reset any tracing activities. </li> |
| winhttp `set advproxy` | Configures advanced proxy settings for WinHTTP, providing detailed configurations like bypass lists or multiple proxy settings. <br><br> `setting-scope` - Specifies the scope of the settings. Acceptable values are: <li> `user` - Applies the settings to the current user. <li> `machine` - Applies the settings system-wide. <br><br> `settings-file` - Specifies a path to a JSON file containing the proxy configuration settings. This file should contain a JSON object with the relevant properties. <br><br> `settings` - Specifies the proxy settings directly in JSON format. The JSON object must include the following properties: <li> `Proxy` - A string value representing the proxy server. <li> `ProxyBypass` - A string value listing hosts that should bypass the proxy. <li> `AutoconfigUrl` - A string value for the URL of an automatic configuration script. <li> `AutoDetect` - A boolean value indicating whether to automatically detect proxy settings (true or false). |
| winhttp `set proxy` | Configures the basic proxy settings for WinHTTP by specifying a proxy server and an optional list of hosts that should bypass the proxy. <br><br><li> `proxy-server=` - Specifies the proxy server to be used for both HTTP and HTTPS protocols. You can designate a single server, and optionally, a port number (for example, `proxy.example.com:8080`). <li> `bypass-list=` - Provides a list of hostnames or IP addresses that should not use the proxy server and instead be accessed directly. The list should be separated by semicolons. Use an empty string (`""`) to bypass the proxy for all short-name hosts (non-fully qualified domain names). |
| winhttp `set tracing` | Related to starting network tracing activities for troubleshooting or monitoring purposes. It suggests using the following to initiate tracing, `netsh trace start scenario=InternetClient`, which starts tracing network traffic activities specifically for internet client scenarios. |
| winhttp `show` `<advproxy>` \| `<proxy>` \| `<tracing>` | Provides options to display various WinHTTP configurations, such as: <br><br><li> `advproxy` - Displays the current advanced proxy settings for WinHTTP. This includes any detailed proxy configurations that have been set. <li> `proxy` - Displays the current basic proxy settings for WinHTTP. This reveals the proxy server in use and any bypass lists that have been configured. <li> `tracing` - Displays tracing information. It's advised to use the `netsh trace show` command. </li> |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To import proxy settings from Internet Explorer into WinHTTP, run the following command:

```cmd
netsh winhttp import proxy source=ie
```

To reset the WinHTTP proxy settings to their default state, run the following command:

```cmd
netsh winhttp reset proxy
```

To set advanced proxy settings for WinHTTP at the machine level using a JSON configuration string, run the following command:

```cmd
netsh winhttp set advproxy setting-scope=machine settings="{\"Proxy\":\"proxy.example.com:8080\",\"ProxyBypass\":\"*.example.com\",\"AutoconfigUrl\":\"http://config.example.com/proxy.pac\",\"AutoDetect\":true}"
```

To display the current WinHTTP proxy settings, run the following command:

```cmd
netsh winhttp show proxy
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

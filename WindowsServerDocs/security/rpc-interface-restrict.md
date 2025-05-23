---
title: RPC Interface Restriction for Windows Server
description: RPC Interface Restriction helps to prevent unauthorized access to system resources and data when enabled in group policy object editor or in the registry.
ms.topic: how-to
author: xelu86
ms.author: alalve
ms.date: 02/25/2025
---

# RPC Interface Restriction

The Remote Procedure Call (RPC) service makes RPC interfaces secure by default to reduce attacks. The `RestrictRemoteClients` registry key enables you to modify the behavior of all RPC interfaces on the system and can be used to eliminate remote anonymous access to RPC interfaces on the system, with some exceptions. You can apply other interface controls using the `EnableAuthEpResolution` registry key covered in this article. Both RPC application developers and system administrators can configure RPC Interface Restrictions.

## Prerequisites

When using `RestrictRemoteClients` on your server:

- Your RPC clients are required to use RPC security when contacting your server applications, which is the best method to mitigate security threats.  

- Exempt your RPC setting from requiring authentication by setting the _RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH_ flag during registration. Doing so configures RPC to allow anonymous connections to your applications.

### RestrictRemoteClients threat mitigation

Enabling `RestrictRemoteClients` is useful in mitigation against worms that rely on exploitable buffer overruns that can be invoked remotely through anonymous connections. RPC applications that expect to receive call from remote anonymous RPC clients might not run correctly when using this feature. As a result, applications that use DCOM (Distributed Component Object Model) might not work correctly if this value is set.

RPC calls using connectionless protocols fail if this key is enabled. Secure RPC calls over connectionless protocols, such as UDP (User Datagram Protocol) and IPX (Internetwork Packet Exchange), use a lower level of security compared to connection-oriented protocols. Specifically, `ncadg_ip_udp` and `ncadg_ipx` are considered less secure. For the purposes of this policy, these calls are always considered nonsecure.

To allow RPC client calls using connectionless protocols, keep `RestrictRemoteClients` value set to **disabled**.

## Restrictions for RPC clients

When an interface is registered using `RpcServerRegisterIf`, RPC allows the server application to restrict access to the interface through a security callback. The `RestrictRemoteClients` registry key forces RPC to perform additional security checks for all interfaces, even if the interface has no registered security callback.

RPC clients that use the named pipe protocol sequence (`ncacn_np`) are exempt from all restrictions discussed in this section. The named pipe protocol sequence can't be restricted due to significant backwards compatibility issues.

`RestrictRemoteClients` can also be controlled programmatically in the [rpcdce.h](/windows/win32/api/rpcdce/) API (Application Programming Interface) header.

### Configuring RestrictRemoteClients

To edit these policies using the GPO (Group Policy Object) editor:

1. Select **Start** > type **gpedit.msc** > hit **<kbd>Enter</kbd>** to open the **Local Group Policy Editor**.

1. To enable the equivalent of `RestrictRemoteClients` settings, navigate to **Computer Configuration\Administrative Templates\System\Remote Procedure Call\Restrictions for Unauthenticated RPC Clients**, then select one of the following:

   - **Disabled** - This setting is the default value for server SKUs. Corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_NONE_ in rpcdce.h and it's the responsibility of the server application to impose appropriate RPC restrictions.
   - **Authenticated** - Corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_DEFAULT_ in rpcdce.h. Allows only authenticated RPC Clients to connect to RPC Servers running on the machine on which the policy setting is applied. RPC runtime rejects Anonymous calls. If an interface registers a security callback and provides the _RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH_ flag, then this restriction doesn't apply to that interface.
   - **Authenticated without exceptions**<sup>1</sup> - Corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_HIGH_ in rpcdce.h. Allows only authenticated RPC Clients to connect to RPC Servers running on the machine on which the policy setting is applied. No exceptions are allowed when this value is set as the system can't receive remote anonymous calls using RPC.

Any changes to either of these settings requires a **system reboot** to take effect.

> [!CAUTION]
> **¹**Don't use this value without significant testing. For more information, see **[Restrictions for Unauthenticated RPC Clients](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128)**.

## EnableAuthEpResolution

The `EnableAuthEpResolution` key allows the RPC client runtime to use NTLM (NT LAN Manager) to authenticate to the endpoint mapper when enabled. This authenticated query takes place only if the actual RPC client call uses RPC authentication.

RPC clients make calls to an RPC server that has a registered dynamic endpoint with RPC Endpoint Mapper Client Authentication enabled. These calls are queried on behalf of authenticated calls using NTLM authentication.

RPC clients that attempt to make a call using a dynamic endpoint queries the RPC Endpoint Mapper on the server to determine what endpoint it should connect to. This query is performed anonymously, even if the RPC client call itself is performed using RPC security. The RPC Endpoint Mapper interface isn't accessible anonymously if the `RestrictRemoteClients` setting is enabled.

### Configuring EnableAuthEpResolution

To edit these policies using the GPO (Group Policy Object) editor:

1. Select **Start** > type **gpedit.msc** > hit **<kbd>Enter</kbd>** to open the **Local Group Policy Editor**.

1. To enable the equivalent of `EnableAuthEpResolution` settings, navigate to **Computer Configuration\Administrative Templates\System\Remote Procedure Call\Enable RPC Endpoint Mapper Client Authentication**, then select one of the two available settings:

   - **Disabled** - This setting is the default. RPC clients don't authenticate to the Endpoint Mapper Service, but they're able to communicate with the Endpoint Mapper Service on Windows NT4 Server.
   - **Enabled** - PC clients authenticate via the Endpoint Mapper Service for calls that contain authentication information. Clients making such calls aren't able to communicate with the Windows NT4 Server Endpoint Mapper Service.

Any changes to either of these settings requires a **system reboot** to take effect.

> [!IMPORTANT]
> The following Group Policy settings found in **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options** can't be used with `EnableAuthEpResolution`:
> - Network security: Restrict NTLM: Incoming NTLM traffic – **"Deny All Accounts"**
> - Network security: Restrict NTLM: Outgoing NTLM traffic to remote servers – **"Deny All"**
>
> Moving away from NTLM to better secure your environment is encouraged. If faced with a choice between restricting NTLM and using `EnableAuthEpResolution`, the recommended approach is that you restrict NTLM in your environment.  

## Other RPC Interface Registration flags

These interface registration flags are created to make it easier for an application developer to secure an RPC interface:

- **RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH** <br> When this flag is registered, the RPC runtime invokes the registered security callback for all calls, regardless of the call security settings. Without this flag, RPC rejects all unauthenticated calls before they reach the security callback. This flag works only when a security callback is registered.  

- **RPC_IF_SEC_NO_CACHE** <br> A security callback is registered for an interface to restrict access. Typically, the security callback impersonates the client to verify if the client has sufficient rights to make a call to the interface. Once a particular client identity passes the security callback, it usually passes the same security callback on subsequent attempts.

  The RPC runtime takes advantage of this pattern by remembering when an individual client identity passes a security callback. It then skips the security callback for subsequent calls by that client to the same interface. This feature is called security callback caching and existed since the Microsoft Windows 2000 family of operating systems. You can use the _RPC_IF_SEC_NO_CACHE_ flag to disable security callback caching for a given interface. Which is useful if the security check might change, possibly rejecting a client identity that was previously permitted.  

- **RPC_IF_LOCAL_ONLY** <br> When an interface is registered with this flag, RPC does reject calls made by remote RPC clients. In addition, local calls over all `ncadg_`* protocol sequences and all `ncacn_`* protocol sequences (except for named pipes, using `ncacn_np`) are also rejected. If a call is made on `ncacn_np`, RPC allows the call only if it doesn't come from SRV (Service Location Protocol), which filters out all remote calls. `Ncalrpc` calls are always allowed through.  

The use of these flags is at the discretion of the application developer. RPC application developers are provided with additional security tools to help secure their RPC interface as these flags doesn't change any existing application or cause them to run incorrectly.

## See also

- [Remote Procedure Call (RPC)](/windows/win32/rpc/rpc-start-page)
- [RPC error troubleshooting](/troubleshoot/windows-client/networking/rpc-errors-troubleshooting)

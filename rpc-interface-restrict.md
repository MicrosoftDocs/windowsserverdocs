---
title: RPC Interface Restriction
description: RPC Interface Restriction helps to prevent unauthorized access to system resources and data when enabled in group policy object editor or the registry.
ms.topic: reference
ms.prod: security
author: xelu86 
ms.author: wscontent
ms.date: 05/09/2023
---

# RPC Interface Restriction

> Applies To: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 11, Windows 10

Several changes were made in the Remote Procedure Call (RPC) service that help make RPC interfaces secure by default to reduce attacks. This was introduced into Windows Server 2003 SP1 and applies to future iterations. The most significant change was the addition of the `RestrictRemoteClients` registry key. This key enables you to modify the behavior of all RPC interfaces on the system and can be used to eliminate remote anonymous access to RPC interfaces on the system, with some exceptions. Changes also included the `EnableAuthEpResolution` registry key and three new interface registration flags.

## Who does this feature apply to?

This feature applies to both RPC application developers and System Administrators.

## RestrictRemoteClients

When an interface is registered using `RpcServerRegisterIf`, RPC allows the server application to restrict access to the interface, typically through a security callback. The `RestrictRemoteClients` registry key forces RPC to perform additional security checks for all interfaces, even if the interface has no registered security callback.

RPC clients that use the named pipe protocol sequence (**ncacn_np**) are exempt from all restrictions discussed in this section. The named pipe protocol sequence can't be restricted due to significant backwards compatibility issues.

The `RestrictRemoteClients` registry key can have one of three DWORD values that can also be controlled programmatically in rpcdce.h. This setting can be modified in several ways.

# [Group Policy](#tab/group-policy)

To edit these policies using the GPO (Group Policy Object) editor, click **Start** > type **gpedit.msc** > hit **<kbd>Enter</kbd>** to open the **Local Group Policy Editor**.

To enable the equivalent of `RestrictRemoteClients` settings, navigate to:

**Computer Configuration\Administrative Templates\System\Remote Procedure Call\Restrictions for Unauthenticated RPC Clients**. This setting is **disabled** by default. There are two options available when it's enabled:

- **Authenticated** - Allows only authenticated RPC Clients to connect to RPC Servers running on the machine on which the policy setting is applied. Exemptions are granted to interfaces that have requested them.
- **Authenticated without exceptions** - Allows only authenticated RPC Clients to connect to RPC Servers running on the machine on which the policy setting is applied. No exceptions are allowed.

To enable the equivalent of `EnableAuthEpResolution` settings, navigate to:

**Computer Configuration\Administrative Templates\System\Remote Procedure Call\Enable RPC Endpoint Mapper Client Authentication**. This setting is **disabled** by default. Only two settings are available:

- **Disabled** - RPC clients won't authenticate to the Endpoint Mapper Service, but they'll be able to communicate with the Endpoint Mapper Service on Windows NT4 Server.
- **Enabled** - PC clients authenticate via the Endpoint Mapper Service for calls that contain authentication information.  Clients making such calls won't be able to communicate with the Windows NT4 Server Endpoint Mapper Service.

> [!NOTE]
> Any changes to either of these settings requires a **system reboot** to take effect.

# [Registry](#tab/registry)

The `RestrictRemoteClients` reg key has 3 available **DWORD** settings when it comes to RPC restriction:

- **0** - Disabled: This corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_NONE_ in rpcdce.h and it's the responsibility of the server application to impose appropriate RPC restrictions. This is the default for server SKUs.
- **1** - Enabled: Restricts access to all RPC interfaces. All remote anonymous calls are rejected by the RPC runtime except calls coming in through named pipes (ncacn_np). This corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_DEFAULT_ in rpcdce.h. If an interface registers a security callback and provides the _RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH_ flag, then this restriction doesn't apply to that interface. This is equivalent to **Authenticated** in GPO.
- **2**<sup>1</sup> - High: All remote anonymous calls are rejected by the RPC runtime with no exemptions. This corresponds to the value _RPC_RESTRICT_REMOTE_CLIENT_HIGH_ in rpcdce.h. When this value is set, the system can't receive remote anonymous calls using RPC. This is equivalent to **Authenticated without exceptions** in GPO.

> [!NOTE]
> **¹**Don't use this value without significant testing. See [Restrictions for Unauthenticated RPC Clients](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128) for more information.

If the `RestrictRemoteClients` reg key doesn't exist, create it with the corresponding **value** of the required restriction in the following location:

```registry
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC\
```

---

### What threats does RestrictRemoteClients help mitigate?

It's much more difficult to attack an interface if you require calls to perform authentication, even a relatively low level of authentication. Enabling `RestrictRemoteClients` is useful in mitigation against worms that rely on exploitable buffer overruns that can be invoked remotely through anonymous connections.

### What works differently?

RPC applications that expect to receive call from remote anonymous RPC clients may not run correctly when using this feature. As a result, applications that use DCOM (Distributed Component Object Model) might not work correctly if this value is set.

Because secure RPC calls over connectionless protocols such as UDP (User Datagram Protocol) and IPX (Internetwork Packet Exchange), `ncadq_ip_udp` and `ncadg_ipx` respectively, uses a lower level of security  than calls over connection-oriented protocols where these calls are always considered nonsecure for the purposes of this policy. As a result, RPC calls over connectionless protocols will fail if this key is enabled.

To allow RPC client calls using connectionless protocols, keep the `RestrictRemoteClients` value set to **0** (_RPC_RESTRICT_REMOTE_CLIENT_NONE_).

### How do I resolve these issues?

Here are the requirements when using `RestrictRemoteClients` on your server:

- Require your RPC clients to use RPC security when contacting your server application. This is the best method to mitigate security threats.  

- Exempt your RPC setting from requiring authentication by setting the _RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH_ flag during registration. This configures RPC to allow anonymous connections to your applications.

## EnableAuthEpResolution

If you enable the `RestrictRemoteClients` flag, the RPC Endpoint Mapper interface won't be accessible anonymously. This is a significant security improvement, but it changes the task of resolving an endpoint. Currently, an RPC client that attempts to make a call using a dynamic endpoint will first query the RPC Endpoint Mapper on the server to determine what endpoint it should connect to.

This query is performed anonymously, even if the RPC client call itself is performed using RPC security. Anonymous calls to the RPC Endpoint Mapper interface will fail if the `RestrictRemoteClients` key is set to 1 or higher. This makes it necessary to modify the RPC client runtime to perform an authenticated query to the Endpoint Mapper. If the `EnableAuthEpResolution` key is set, the RPC client runtime uses NTLM (NT LAN Manager) to authenticate to the endpoint mapper. This authenticated query takes place only if the actual RPC client call uses RPC authentication.

> [!NOTE]
> The following Group Policy settings found in **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options** cannot be used with `EnableAuthEpResolution`:
> - Network security: Restrict NTLM: Incoming NTLM traffic – "Deny All Accounts"
> - Network security: Restrict NTLM: Outgoing NTLM traffic to remote servers – "Deny All"
>
> Generally speaking, it's encouraged to move away from NTLM to better secure your environment. If faced with a choice between restricting NTLM and using `EnableAuthEpResolution`, the recommend approach is that you don't implement `EnableAuthEpResolution`. Instead, restrict NTLM in your environment.  

### Why is this change important?

This change enables an RPC client to make a call to an RPC server that has a registered dynamic endpoint with `RestrictRemoteClients` enabled. The client computer must set this registry key so that it performs an authenticated query to the RPC Endpoint Mapper.

### What works differently for EnableAuthEpResolution?

This registry key is used to enable the specific scenario described in the previous section. When this key is turned on, all RPC Endpoint Mapper queries that are performed on behalf of authenticated calls are performed using NTLM authentication.

This setting can also be specified using the GPO editor to configure the group policy located in **Computer Configuration\Administrative Templates\System\Remote Procedure Call\Enable RPC Endpoint Mapper Client Authentication**.

### New RPC Interface Registration flags

Three new interface registration flags have been created to make it easier for an application developer to secure an RPC interface:

- **RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH** <br> When this flag is registered, the RPC runtime invokes the registered security callback for all calls, regardless of the call security settings. Without this flag, RPC rejects all unauthenticated calls before they reach the security callback. This flag works only when a security callback is registered.  

- **RPC_IF_SEC_NO_CACHE** <br> A security callback is registered for an interface in order to restrict access to that interface. The typical security callback impersonates the client to determine whether the client has sufficient rights to make a call to the interface. If a particular client identity passes a security callback once, it usually passes the same security callback every time.

  - The RPC runtime takes advantage of this pattern by remembering when an individual client identity passes a security callback and skips the security callback for subsequent calls by that client to the same interface. This feature is called security callback caching and has existed since the Microsoft Windows 2000 family of operating systems. You can use the _RPC_IF_SEC_NO_CACHE_ flag to disable security callback caching for a given interface. This is useful if the security check might change, possibly rejecting a client identity that was previously permitted.  

- **RPC_IF_LOCAL_ONLY** <br> When an interface is registered with this flag, RPC rejects calls made by remote RPC clients. In addition, local calls over all `ncadg_`* protocol sequences and all `ncacn_`* protocol sequences (except for named pipes, using `ncacn_np`) are also rejected. If a call is made on `ncacn_np`, RPC allows the call only if it doesn't come from SRV (Service Location Protocol), which filters out all remote calls. `Ncalrpc` calls are always allowed through.  

This change provides RPC application developers with additional security tools to help secure their RPC interface as these flags won't change any existing application or cause it not to run correctly. The use of these new flags is at the discretion of the application developer.

## Additional references

- [Remote Procedure Call (RPC)](/windows/win32/rpc/rpc-start-page)
- [RPC error troubleshooting](/troubleshoot/windows-client/networking/rpc-errors-troubleshooting)

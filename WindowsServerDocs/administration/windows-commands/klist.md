---
title: klist
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4689b4a9-1740-47dd-9240-02105efca428
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# klist



Displays a list of currently cached Kerberos tickets. This information applies to Windows Server 2012. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
klist [-lh <LogonId.HighPart>] [-li <LogonId.LowPart>] tickets | tgt | purge | sessions | kcd_cache | get | add_bind | query_bind | purge_bind
```

### Parameters

|Parameter|Description|
|---------|-----------|
|-lh|Denotes the high part of the user’s locally unique identifier (LUID), expressed in hexadecimal. If neither –lh or –li are present, the command defaults to the LUID of the user who is currently signed in.|
|-li|Denotes the low part of the user’s locally unique identifier (LUID), expressed in hexadecimal. If neither –lh or –li are present, the command defaults to the LUID of the user who is currently signed in.|
|tickets|Lists the currently cached ticket-granting-tickets (TGTs), and service tickets of the specified logon session. This is the default option.|
|tgt|Displays the initial Kerberos TGT.|
|purge|Allows you to delete all the tickets of the specified logon session.|
|sessions|Displays a list of logon sessions on this computer.|
|kcd_cache|Displays the Kerberos constrained delegation cache information.|
|get|Allows you to request a ticket to the target computer specified by the service principal name (SPN).|
|add_bind|Allows you to specify a preferred domain controller for Kerberos authentication.|
|query_bind|Displays a list of cached preferred domain controllers for each domain that Kerberos has contacted.|
|purge_bind|Removes the cached preferred domain controllers for the domains specified.|
|kdcoptions|Displays the Key Distribution Center (KDC) options specified in RFC 4120.|
|/?|Displays Help for this command.|

## Remarks

Membership in **Domain Admins**, or equivalent, is the minimum required to run all the parameters of this command.

If no parameters are provided, Klist will retrieve all the tickets for the currently logged on user.

The parameters display the following information:
-   **tickets**

    Lists the currently cached tickets of services that you have authenticated to since logon. Displays the following attributes of all cached tickets:  
    -   LogonID: The LUID
    -   Client: The concatenation of the client name and the domain name of the client
    -   Server: The concatenation of the service name and the domain name of the service
    -   KerbTicket Encryption Type: The encryption type that is used to encrypt the Kerberos ticket
    -   Ticket Flags: The Kerberos ticket flags
    -   Start Time: The time from which the ticket will be valid
    -   End Time: The time the ticket becomes no longer valid. When a ticket is past this time, it can no longer be used to authenticate to a service or be used for renewal
    -   Renew Time: The time that a new initial authentication is required
    -   Session Key Type: The encryption algorithm that is used for the session key
-   **tgt**

    Lists the initial Kerberos TGT and the following attributes of the currently cached ticket:  
    -   LogonID: Identified in hexadecimal
    -   ServiceName: krbtgt
    -   TargetName \<SPN>: krbtgt
    -   DomainName: Name of the domain that issues the TGT
    -   TargetDomainName: Domain that the TGT is issued to
    -   AltTargetDomainName: Domain that the TGT is issued to
    -   Ticket Flags: Address and target actions and type
    -   Session Key: Key length and encryption algorithm
    -   StartTime: Local computer time that the ticket was requested
    -   EndTime: Time the ticket becomes no longer valid. When a ticket is past this time, it can no longer be used to authenticate to a service.
    -   RenewUntil: Deadline for ticket renewal
    -   TimeSkew: Time difference with the Key Distribution Center (KDC)
    -   EncodedTicket: Encoded ticket
-   **purge**

    Allows you to delete a specific ticket. Purging tickets destroys all tickets that you have cached, so use this attribute with caution. It might stop you from being able to authenticate to resources. If this happens, you will have to log off and log on again.  
    -   LogonID: Identified in hexadecimal
-   **sessions**

    Allows you to list and display the information for all logon sessions on this computer.  
    -   LogonID: If specified, displays the logon session only by the given value. If not specified, displays all the logon sessions on this computer.
-   **kcd_cache**

    Allows you to display the Kerberos constrained delegation cache information.  
    -   LogonID: If specified, displays the cache information for the logon session by the given value. If not specified, displays the cache information for the current user’s logon session.
-   **get**

    Allows you to request a ticket to the target that is specified by the SPN.  
    -   LogonID: If specified, requests a ticket by using the logon session by the given value. If not specified, requests a ticket by using the current user’s logon session.
    -   kdcoptions: Requests a ticket with the given KDC options
-   **add_bind**

    Allows you to specify a preferred domain controller for Kerberos authentication.
-   **query_bind**

    Allows you to display cached, preferred domain controllers for the domains.
-   **purge_bind**

    Allows you to remove cached, preferred domain controllers for the domains.
-   **kdcoptions**

    For the current list of options and their explanations, see [RFC 4120](http://www.ietf.org/rfc/rfc4120.txt).

**Other considerations**
-   Klist.exe is available in Windows Server 2012 and Windows 8, and it requires no special installation.

## <a name="BKMK_Examples"></a>Examples

1. When you are diagnosing an Event ID 27 while processing a ticket-granting service (TGS) request for the target server, the account did not have a suitable key to generate a Kerberos ticket. You can use Klist to query the Kerberos ticket cache to determine if any tickets are missing, if the target server or account is in error, or if the encryption type is not supported.  
   ```
   klist 
   ```  
   ```
   klist –li 0x3e7
   ```  
2. When you diagnose errors and you want to know the specifics of each ticket-granting-ticket that is cached on the computer for a logon session, you can use Klist to display the TGT information.  
   ```
   klist tgt
   ```  
3. If you are unable to establish a connection and diagnosis might take too long, you can purge the Kerberos ticket cache, log off, and then log back on.  
   ```
   klist purge
   ```  
   ```
   klist purge –li 0x3e7
   ```  
4. When you want to diagnose a logon session for a user or a service, you can use the following command to find the LogonID that is used in other Klist commands.  
   ```
   klist sessions
   ```  
5. When you want to diagnose Kerberos constrained delegation failure, you can use the following command to find the last error that was encountered.  
   ```
   klist kcd_cache
   ```  
6. When you want to diagnose if a user or a service can get a ticket to a server, you can use this command to request a ticket for a specific SPN.  
   ```
   klist get host/%computername%
   ```  
7. When diagnosing replication issues across domain controllers, you typically need the client computer to target a specific domain controller. In these cases, you can use the following command to target the client computer to that specific domain controller.  
   ```
   klist add_bind CONTOSO KDC.CONTOSO.COM
   ```  
   ```
   klist add_bind CONTOSO.COM KDC.CONTOSO.COM
   ```  
8. To query what domain controllers this computer recently contacted, you can use the following command.  
   ```
   klist query_bind
   ```  
9. When you want Kerberos to rediscover domain controllers, you can use the following command. This command can also be used to flush the cache before creating new domain controller bindings with klist add_bind.  
   ```
   klist purge_bind
   ```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
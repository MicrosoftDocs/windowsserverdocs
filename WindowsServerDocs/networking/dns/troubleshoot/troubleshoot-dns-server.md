---
title: Troubleshooting DNS Servers
description: This article introduces how to troubleshoot DNS issue from server-side. 
manager: dcscontentpm
ms.prod: 
ms.technology: networking-dns
ms.topic: article
ms.author: delhan
ms.date: 8/8/2019
author: Deland-Han
---

# Troubleshooting DNS servers

This article discusses how to troubleshoot issues on DNS servers.

## Check IP configuration

1. Run `ipconfig /all` at a command prompt, and verify the IP address, subnet mask, and default gateway.

2. Check whether the DNS server is authoritative for the name that is being looked up. If so, see [Checking for problems with authoritative data](#checking-for-problems-with-authoritative-data).

3. Run the following command:

   ```cmd
   nslookup <name> <IP address of the DNS server>
   ```
   For example: 
   ```cmd
   nslookup app1 10.0.0.1
   ```
   If you get a failure or time-out response, see [Checking for recursion problems](#checking-for-recursion-problems).

4. Flush the resolver cache. To do this, run the following command in an administrative Command Prompt window:

   ```cmd
   dnscmd /clearcache
   ```
   Or, in an administrative PowerShell window, run the following cmdlet:
   ```powershell
   Clear-DnsServerCache
   ```

5. Repeat step 3. 

## Check DNS server problems

### Event log

Check the following logs to see whether there are any recorded errors:

- Application

- System

- DNS Server

### Test by using nslookup query

Run the following command and check whether the DNS server is reachable from client computers.

```cmd
nslookup <client name> <server IP address>
```

- If the resolver returns the IP address of the client, the server does not have any problems.

- If the resolver returns a "Server failure" or "Query refused" response, the zone is probably paused, or the server is possibly overloaded. You can learn whether it's paused by checking the General tab of the zone properties in the DNS console.

If the resolver returns a "Request to server timed out" or "No response from server" response, the DNS service probably is not running. Try to restart the DNS Server service by entering the following at a command prompt on the server:

```cmd
net start DNS
```

If the issue occurs when the service is running, the server might not be listening on the IP address that you used in your nslookup query. On the **Interfaces** tab of the server properties page in the DNS console, administrators can restrict a DNS server to listen on only selected addresses. If the DNS server has been configured to limit service to a specific list of its configured IP addresses, it's possible that the IP address that's used to contact the DNS server is not in the list. You can try a different IP address in the list or add the IP address to the list.

In rare cases, the DNS server might have an advanced security or firewall configuration. If the server is located on another network that is reachable only through an intermediate host (such as a packet filtering router or proxy server), the DNS server might use a non-standard port to listen for and receive client requests. By default, nslookup sends queries to DNS servers on UDP port 53. Therefore, if the DNS server uses any other port, nslookup queries fail. If you think that this might be the problem, check whether an intermediate filter is intentionally used to block traffic on well-known DNS ports. If it's not, try to modify the packet filters or port rules on the firewall to allow traffic on UDP/TCP port 53.

## Checking for problems with authoritative data

Check whether the server that returns the incorrect response is a primary server for the zone (the standard primary server for the zone or a server that uses Active Directory integration to load the zone) or a server that's hosting a secondary copy of the zone. 

### If the server is a primary server

The problem might be caused by user error when users enter data into the zone. Or, it might be caused by a problem that affects Active Directory replication or dynamic update.

### If the server is hosting a secondary copy of the zone

1. Examine the zone on the master server (the server from which this server pulls zone transfers).

   > [!NOTE]
   >You can determine which server is the master server by examining the properties of the secondary zone in the DNS console.

   If the name is not correct on the master server, go to step 4.

2. If the name is correct on the master server, check whether the serial number on the master server is less than or equal to the serial number on the secondary server. If it is, modify either the master server or the secondary server so that the serial number on the master server is greater than than the serial number on the secondary server. 
  
3. On the secondary server, force a zone transfer from within the DNS console or by running the following command:
  
   ```cmd
   dnscmd /zonerefresh <zone name>
   ```
  
   For example, if the zone is corp.contoso.com, enter: `dnscmd /zonerefresh corp.contoso.com`.
  
4. Examine the secondary server again to see whether the zone was transferred correctly. If not, you probably have a zone transfer problem. For more information, see [Zone Transfer Problems](#zone-transfer-problems).

5. If the zone was transferred correctly, check whether the data is now correct. If not, the data is incorrect in the primary zone. The problem might be caused by user error when users enter data into the zone. Or, it might be caused by a problem that affects Active Directory replication or dynamic update.

## Checking for recursion problems

For recursion to work successfully, all DNS servers that are used in the path of a recursive query must be able to respond and forward correct data. If they can't, a recursive query can fail for any of the following reasons:

- The query times out before it can be completed.

- A server that's used during the query fails to respond.

- A server that's used during the query provides incorrect data.

Start troubleshooting at the server that was used in your original query. Check whether this server forwards queries to another server by examining the **Forwarders** tab in the server properties in the DNS console. If the **Enable forwarders** check box is selected, and one or more servers are listed, this server forwards queries.

If this server does forward queries to another server, check for problems that affect the server to which this server forwards queries. To check for problems, see [Check DNS Server problems](#check-dns-server-problems). When that section instructs you to perform a task on the client, perform it on the server instead.

If the server is healthy and can forward queries, repeat this step, and examine the server to which this server forwards queries.

If this server does not forward queries to another server, test whether this server can query a root server. To do this, run the following command:

```cmd
nslookup
server <IP address of server being examined>
set q=NS
 ```

- If the resolver returns the IP address of a root server, you probably have a broken delegation between the root server and the name or IP address that you're trying to resolve. Follow the [Test a broken delegation](#test-a-broken-delegation) procedure to determine where you have a broken delegation.

- If the resolver returns a "Request to server timed out" response, check whether the root hints point to functioning root servers. To do this, use the [To view the current root hints](#to-view-the-current-root-hints) procedure. If the root hints do point to functioning root servers, you might have a network problem, or the server might use an advanced firewall configuration that prevents the resolver from querying the server, as described in the [Check DNS server problems](#check-dns-server-problems) section. It's also possible that the recursive time-out default is too short.

### Test a broken delegation

Begin the tests in the following procedure by querying a valid root server. The test takes you through a process of querying all the DNS servers from the root down to the server that you're testing for a broken delegation.

1. At the command prompt on the server that you're testing, enter the following:

   ```cmd
   nslookup
   server <server IP address>
   set norecursion
   set querytype= <resource record type>
   <FQDN>
   ```
   > [!NOTE]
   >Resource record type is the type of resource record that you were querying for in your original query, and FQDN is the FQDN for which you were querying (terminated by a period).
 
2. If the response includes a list of "NS" and "A" resource records for delegated servers, repeat step 1 for each server and use the IP address from the "A" resource records as the server IP address.

   - If the response does not contain an "NS" resource record, you have a broken delegation.
   
   - If the response contains "NS" resource records, but no "A" resource records, enter **set recursion**, and query individually for "A" resource records of servers that are listed in the "NS" records. If you do not find at least one valid IP address of an "A" resource record for each NS resource record in a zone, you have a broken delegation.

3. If you determine that you have a broken delegation, fix it by adding or updating an "A" resource record in the parent zone by using a valid IP address for a correct DNS server for the delegated zone.

### To view the current root hints

1. Start the DNS console.

2. Add or connect to the DNS server that failed a recursive query.

3. Right-click the server, and select **Properties**.

4. Click Root Hints.

Check for basic connectivity to the root servers.

- If root hints appear to be configured correctly, verify that the DNS server that's used in a failed name resolution can ping the root servers by IP address.

- If the root servers do not respond to pinging by IP address, the IP addresses for the root servers might have changed. However, it's uncommon to see a reconfiguration of root servers.

## Zone Transfer Problems

Run the following checks:

- Check Event Viewer for both the primary and secondary DNS server.

- Check the master server to see whether it's refusing to send the transfer for security. 

- Check the **Zone Transfers** tab of the zone properties in the DNS console. If the server restricts zone transfers to a list of servers, such as those listed on the **Name Servers** tab of the zone properties, make sure that the secondary server is on that list. Make sure that the server is configured to send zone transfers.

- Check the master server for problems by following the steps in the [Check DNS server problems](#check-dns-server-problems) section. When you're prompted to perform a task on the client, perform the task on the secondary server instead.

- Check whether the secondary server is running another DNS server implementation, such as BIND. If it is, the problem might have one of the following causes:

  - The Windows master server might be configured to send fast zone transfers, but the third-party secondary server might not support fast-zone transfers. If this is the case, disable fast-zone transfers on the master server from within the DNS console by selecting the **Enable Bind secondaries** check box on the **Advanced** tab of the properties for your server.

  - If a forward lookup zone on the Windows server contains a record type (for example, an SRV record) that the secondary server does not support, the secondary server might have problems pulling the zone.

Check whether the master server is running another DNS server implementation, such as BIND. If so, it's possible that the zone on the master server includes incompatible resource records that Windows does not recognize.
 
If either the master or secondary server is running another DNS server implementation, check both servers to make sure that they support the same features. You can check the Windows server in the DNS console on the **Advanced** tab of the properties page for the server. In addition to the Enable Bind secondaries box, this page includes the **Name checking** drop-down list. This enables you to select enforcement of strict RFC compliance for characters in DNS names.


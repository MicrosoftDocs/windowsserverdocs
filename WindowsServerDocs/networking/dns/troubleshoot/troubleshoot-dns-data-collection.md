---
title: Troubleshooting Domain Name System (DNS) issues
description: This article introduces how to collect data when DNS issues occur.
manager: dcscontentpm
ms.prod: 
ms.technology: networking-dns
ms.topic: article
ms.author: delhan
ms.date: 8/8/2019
author: Deland-Han
---

# Troubleshooting Domain Name System (DNS) issues
 
Domain Name resolution issues can be broken down into client-side and server-side issues. In general, you should start with client-side troubleshooting unless you determine during the scoping phase that the issue is definitely occurring on the server side.

- [Troubleshooting DNS clients](troubleshoot-dns-client.md)

- [Troubleshooting DNS Servers](troubleshoot-dns-server.md)
 
## Data Collection
 
We recommend that you simultaneously collect data on both the client and server sides when the issue occurs. However, depending on the actual issue, you can start your collection at a single data set on either the DNS client or DNS server.
 
To collect a Windows Networking Diagnostic from an affected client and its configured DNS server, follow these steps:

1. Start network captures on the client and server:

   ```cmd
   netsh trace start capture=yes tracefile=c:\%computername%_nettrace.etl
   ```

2. Clear the DNS cache on the DNS client by running the following command:

   ```cmd
   ipconfig /flushdns
   ```

3. Reproduce the issue.

4. Stop and save traces:

   ```cmd
   netsh trace stop
   ```

5. Save the Nettrace.cab files from each computer. This information will be helpful when you contact Microsoft Support.
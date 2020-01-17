---
title: Guidelines for troubleshooting DNS-related activation issues
description: 
ms.topic: troubleshooting
ms.date: 09/10/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
ms.localizationpriority: medium
---

# Guidelines for troubleshooting DNS-related activation issues

You may have to use some of these methods if one or more of the following conditions are true:

- You use volume-licensed media and a&nbsp;Volume License generic product key to install one of the following operating systems:
   - Windows Server 2019
   - Windows Server 2016
   - Windows Server 2012 R2
   - Windows Server 2012
   - Windows Server 2008 R2
   - Windows Server 2008
   - Windows 10
   - Windows 8.1
   - Windows 8
- The activation wizard cannot connect to a KMS host computer.

When you try to activate a client system, the activation wizard uses DNS to locate a corresponding computer that&#39;s running the KMS software. If the wizard queries DNS and does not find the DNS entry for the KMS host computer, the wizard reports an error.   

<a id="list"></a>Review the following list to find an approach that fits your circumstances:

- If you cannot install a KMS host or if you cannot use KMS activation, try the [Change the product key to an MAK](#change-the-product-key-to-an-mak) procedure.
- If you have to install and configure a KMS host, use the [Configure a KMS host for the clients to activate against](#configure-a-kms-host-for-the-clients-to-activate-against) procedure.
- If the client cannot locate your existing KMS host, use the following procedures to troubleshoot your routing configurations. These procedures are arranged from the simplest to the most complex.
  - [Verify basic IP connectivity to the DNS server](#verify-basic-ip-connectivity-to-the-dns-server)
  - [Verify the KMS host configuration](#verify-the-configuration-of-the-kms-host)  
  - [Determine the type of routing issue](#determine-the-type-of-routing-issue)
  - [Verify the DNS configuration](#verify-the-dns-configuration)
  - [Manually create a KMS SRV record](#manually-create-a-kms-srv-record)
  - [Manually assign a KMS host to a KMS client](#manually-assign-a-kms-host-to-a-kms-client)
  - [Configure the KMS host to publish in multiple DNS domains](#configure-the-kms-host-to-publish-in-multiple-dns-domains)

## Change the product key to an MAK

If you cannot install a KMS host or, for some other reason, you cannot use KMS activation, change the product key to an MAK. If you downloaded Windows images from the Microsoft Developer Network (MSDN), or from TechNet, the stock-keeping units (SKUs) that are listed below the media are generally volume licensed-media, and the product key that's provided is an MAK key.

To change the product key to an MAK, follow these steps:

1. Open an elevated Command Prompt window. To do this, press the Windows logo key+X, right-click **Command Prompt**, and then select **Run as administrator**. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. At the command prompt, run the following command:
   ```cmd
    slmgr -ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
   ```
   > [!NOTE]
   > The **xxxxx-xxxxx-xxxxx-xxxxx-xxxxx** placeholder represents your MAK product key.  

[Return to the procedure list.](#list)

## Configure a KMS host for the clients to activate against

KMS activation requires that a KMS host be configured for the clients to activate against. If there are no KMS hosts configured in your environment, install and activate one by using an appropriate KMS host key. After you configure a computer on the network to host the KMS software, publish the Domain Name System (DNS) settings.

For information about the KMS host configuration process, see [Activate using Key Management Service](https://docs.microsoft.com/windows/deployment/volume-activation/activate-using-key-management-service-vamt) and [Install and Configure VAMT](https://docs.microsoft.com/windows/deployment/volume-activation/install-configure-vamt).

[Return to the procedure list.](#list)

## Verify basic IP connectivity to the DNS server

Verify basic IP connectivity to the DNS server by using the ping command. To do this, follow these steps on both the KMS client that is experiencing the error and the KMS host computer:

1. Open an elevated Command Prompt window.
1. At the command prompt, run the following command:
   ```cmd
   ping <DNS_Server_IP_address>
   ```
   > [!NOTE]
   > If the output from this command does not include the phrase "Reply from," there is a network problem or DNS issue that you must resolve before you can use the other procedures in this article. For more information about how to troubleshoot TCP/IP issues if you cannot ping the DNS server, see [Advanced troubleshooting for TCP/IP issues](https://docs.microsoft.com/windows/client-management/troubleshoot-tcpip).

[Return to the procedure list.](#list)

## Verify the configuration of the KMS host

Check the registry of the KMS host server to determine whether it is registering with DNS. By default, a KMS host server dynamically registers a DNS SRV record one time every 24 hours. 
> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

To check this setting, follow these steps:
1. Start Registry Editor. To do this, right-click **Start**, select **Run**, type **regedit**, and then press Enter.
1. Locate the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SL** subkey, and check the value of the **DisableDnsPublishing** entry. This entry has the following possible values:
   - **0** or undefined (default): The KMS host server registers a SRV record once every 24 hours.
   - **1**: The KMS host server does not automatically register SRV records. If your implementation does not support dynamic updates, see [Manually create a KMS SRV record](#manually-create-a-kms-srv-record).  
1. If the **DisableDnsPublishing** entry is missing, create it (the type is DWORD). If dynamic registration is acceptable, leave the value undefined or set it to **0**.

[Return to the procedure list.](#list)

## Determine the type of routing issue

You can use the following commands to determine whether this is a name resolution issue or an SRV record issue.  

1. On a KMS client, open an elevated Command Prompt window.  
1. At the command prompt, run the following commands:
   ```cmd
   cscript \windows\system32\slmgr.vbs -skms <KMS_FQDN>:<port>
   cscript \windows\system32\slmgr.vbs -ato
   ```
   > [!NOTE]
   > In this command, <KMS_FQDN> represents the fully qualified domain name (FQDN) of the KMS host computer and \<port\> represents the TCP port that KMS uses.  

   If these commands resolve the problem, this is an SRV record issue. You can you can troubleshoot it by using one of the commands that are documented in the [Manually assign a KMS host to a KMS client](#manually-assign-a-kms-host-to-a-kms-client) procedure.  

1. If the problem persists, run the following commands:
   ```cmd
   cscript \windows\system32\slmgr.vbs -skms <IP Address>:<port>
   cscript \windows\system32\slmgr.vbs -ato
   ```
   > [!NOTE]
   > In this command, \<IP Address\> represents the IP address of the KMS host computer and \<port\> represents the TCP port that KMS uses.  

   If these commands resolve the problem, this is most likely a name resolution issue. For additional troubleshooting information, see the [Verify the DNS configuration](#verify-the-dns-configuration) procedure.

1. If none of these commands resolves the problem, check the computer's firewall configuration. Any activation communications that occur between KMS clients and the KMS host use the 1688 TCP port. The firewalls on both the KMS client and the KMS host must allow communication over port 1688.

[Return to the procedure list.](#list)

## Verify the DNS configuration

>[!NOTE]
> Unless otherwise stated, follow these steps on a KMS client that has experienced the applicable error.

1. Open an elevated Command Prompt window
1. At the command prompt, run the following command:
   ```cmd
   IPCONFIG /all
   ```
1. From the command results, note the following information:
   - The assigned IP address of the KMS client computer
   - The IP address of the Primary DNS server that the KMS client computer uses
   - The IP address of the default gateway that the KMS client computer uses
   - The DNS suffix search list that the KMS client computer uses
1. Verify that the KMS host SRV records are registered in DNS. To do this, follow these steps:  
   1. Open an elevated Command Prompt window.
   1. At the command prompt, run the following command:
      ```cmd
      nslookup -type=all _vlmcs._tcp>kms.txt
      ```
   1. Open the KMS.txt file that the command generates. This file should contain one or more entries that resemble the following entry:
       ```
       _vlmcs._tcp.contoso.com SRV service location:
       priority = 0
       weight = 0
       port = 1688 svr hostname = kms-server.contoso.com
       ```
       > [!NOTE]
       > In this entry, contoso.com represents the domain of the KMS host.
      1. Verify the IP address, host name, port, and domain of the KMS host.
      1. If these **_vlmcs** entries exist, and if they contain the expected KMS host names, go to [Manually assign a KMS host to a KMS client](#manually-assign-a-kms-host-to-a-kms-client).  
      > [!NOTE]
      > If the [**nslookup**](https://docs.microsoft.com/windows-server/administration/windows-commands/nslookup) command finds the KMS host, it does not mean that the DNS client can find the KMS host. If the **nslookup** command finds the KMS host, but you still cannot activate by using the KMS host, check the other DNS settings, such as the primary DNS suffix and the search list of the DNS suffix.
1. Verify that the search list of the primary DNS suffix contains the DNS domain suffix that is associated with the KMS host. If the search list does not include this information, go to the [Configure the KMS host to publish in multiple DNS domains](#configure-the-kms-host-to-publish-in-multiple-dns-domains) procedure.

[Return to the procedure list.](#list)

## Manually create a KMS SRV record

To manually create an SRV record for a KMS host that uses a Microsoft DNS server, follow these steps:

1. On the DNS server, open DNS Manager. To open DNS Manager, select **Start**, select **Administrative Tools**, and then select **DNS**.
1. Select the DNS server on which you have to create the SRV resource record.
1. In the console tree, expand **Forward Lookup Zones**, right-click the domain, and then select **Other New Records**.
1. Scroll down the list, select **Service Location (SRV)**, and then select **Create Record**.
1. Type the following information:
   - Service: **_VLMCS**
   - Protocol: **_TCP**
   - Port number: **1688**
   - Host offering the service: **&lt;*FQDN of the KMS host*&gt;**
1. When you are finished, select **OK**, and then select **Done**.

To manually create an SRV record for a KMS host that uses a BIND 9.x-compliant DNS server, follow the instructions for that DNS server, and provide the following information for the SRV record:

- Name:&nbsp;**_vlmcs._TCP**
- Type:&nbsp;**SRV**
- Priority: **0**
- Weight: **0**
- Port: **1688**
- Hostname: **&lt;*FQDN or A-Name of the KMS host*&gt;**

> [!NOTE]
> KMS does not use the **Priority** or **Weight** values. However, the record must include them.

To configure a BIND 9.x-compatible DNS server to support KMS auto-publishing, configure the DNS server to enable resource record updates from KMS hosts. For example, add the following line to the zone definition in Named.conf or in Named.conf.local:

```cmd
allow-update { any; };
```
## Manually assign a KMS host to a KMS client

By default, the KMS clients use the automatic discovery process. According to this process, a KMS client queries DNS for a list of servers that have published _vlmcs SRV records within the membership zone of the client. DNS returns the list of KMS hosts in a random order. The client picks a KMS host and tries to establish a session on it. If this attempt works, the client caches the name of the KMS host and tries to use it for the next renewal attempt. If the session setup fails, the client randomly picks another KMS host. We highly recommend that you use the automatic discovery process.  

However, you can manually assign a KMS host to a particular KMS client. To do this, follow these steps.

1. On a KMS client, open an elevated Command Prompt window.
1. Depending on your implementation, follow one of these steps:
   - To assign a KMS host by using the FQDN of the host, run the following command:
     ```cmd
     cscript \windows\system32\slmgr.vbs -skms <KMS_FQDN>:<port>
     ```
   - To assign a KMS host by using the version 4 IP address of the host, run the following command:
     ```cmd
     cscript \windows\system32\slmgr.vbs -skms <IPv4Address>:<port>
     ```
    - To assign a KMS host by using the version 6 IP address of the host, run the following command:
      ```cmd
      cscript \windows\system32\slmgr.vbs -skms <IPv6Address>:<port>
      ```
    - To assign a KMS host by using the NETBIOS name of the host, run the following command:
      ```cmd
      cscript \windows\system32\slmgr.vbs -skms <NETBIOSName>:<port>
      ```
   - To revert to automatic discovery on a KMS client, run the following command:
     ```cmd
     cscript \windows\system32\slmgr.vbs -ckms
     ```
     > [!NOTE]
     > These commands use the following placeholders:
     >- **<KMS_FQDN>** represents the fully qualified domain name (FQDN) of the KMS host computer
     >- **\<IPv4Address\>** represents the IP version 4 address of the KMS host computer
     >- **\<IPv6Address\>** represents the IP version 6 address of the KMS host computer
     >- **\<NETBIOSName\>** represents the NETBIOS name of the KMS host computer
     >- **\<port\>** represents the TCP port that KMS uses.  

## Configure the KMS host to publish in multiple DNS domains

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

As described in [Manually assign a KMS host to a KMS client](#manually-assign-a-kms-host-to-a-kms-client), KMS clients typically use the automatic discovery process to identify KMS hosts. This process requires that the _vlmcs SRV records must be available in the DNS zone of the KMS client computer. The DNS zone corresponds to either the primary DNS suffix of the computer or to one of the following:
- For domain-joined computers, the computer's domain as assigned by the DNS system (such as Active Directory Domain Services (AD DS) DNS).
- For workgroup computers, the computer's domain as assigned by the Dynamic Host Configuration Protocol (DHCP). This domain name is defined by the option that has the code value of 15 as defined in Request for Comments (RFC) 2132.

By default, a KMS host registers its SRV records in the DNS zone that corresponds to the domain of the KMS host computer. For example, assume that a KMS host joins the contoso.com domain. In this scenario, the KMS host registers its _vmlcs SRV record under the contoso.com DNS zone. Therefore, the record identifies the service as VLMCS._TCP.CONTOSO.COM.

If the KMS host and KMS clients use different DNS zones, you must configure the KMS host to automatically publish its SRV records in multiple DNS domains. To do this, follow these steps:

1. On the KMS host, start Registry Editor. 
1. Locate and then select the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SL** subkey.
1. In the **Details** pane, right-click a blank area, select **New**, and then select **Multi-String Value**.
1. For the name of the new entry, enter **DnsDomainPublishList**.
1. Right-click the new **DnsDomainPublishList** entry, and then select **Modify**.
1. In the **Edit Multi-String** dialog box, type each DNS domain suffix that KMS publishes on a separate line, and then select **OK**.
   > [!NOTE]
   > For Windows Server 2008 R2, the format for **DnsDomainPublishList** differs. For more information, see the Volume Activation Technical Reference Guide.
1. Use the Services administrative tool to restart the Software Licensing service. This operation creates the SRV records.
1. Verify that by using a typical method, the KMS client can contact the KMS host that you configured. Verify that the KMS client correctly identifies the KMS host both by name and by IP address. If either of these verifications fails, investigate this DNS client resolver issue.
1. To clear any previously cached KMS host names on the KMS client, open an elevated Command Prompt window on the KMS client, and then run the following command:
   ```cmd
   cscript C:\Windows\System32\slmgr.vbs -ckms
   ```

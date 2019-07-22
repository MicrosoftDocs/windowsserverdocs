---
title: Common troubleshooting procedures for KMS and DNS issues
description: 
ms.topic: troubleshooting
ms.date: 07/22/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
ms.localizationpriority: medium
---

# Common troubleshooting procedures for KMS and DNS issues

You may have to use one or more of these methods if one or more of the following conditions are true:

- You use volume-licensed media&nbsp;and&nbsp;a&nbsp;Volume License generic product key to install one of the following operating systems:
   - Windows Server 2019
   - Windows Server 2016
   - Windows Server 2012 R2
   - Windows Server 2012
   - Windows Server 2008 R2
   - Windows Server 2008
   - Windows 10
   - Windows 8.1
   - Windows 8
- The activation wizard cannot connect to a KMS&nbsp;host computer.

When you try to activate a client system, the activation wizard uses DNS to locate a corresponding computer that&#39;s running the KMS software. If the wizard queries DNS and does not find the DNS entry for the KMS host computer, the wizard reports an error. If you do not have a KMS host computer set up, you have to either set up a KMS host computer or switch to an MAK product key method to activate your volume license installation.

> [!NOTE]
> If you have a KMS host computer and you still received the wizard error, the client computer could not find the correct DNS entries. Review the configuration of the KMS host computer and the KMS host DNS records.


- [Method 1: Change the product key to an MAK](#method-1-change-the-product-key-to-an-mak)
- [Method 2: Configure a KMS host server for the clients to activate against](#method-2-configure-a-kms-host-server-for-the-clients-to-activate-against)
- [Method 3: Manually create a KMS SRV record](#method-3-manually-create-a-kms-srv-record)
- [Method 4: Manually assign a KMS server](#method-4-manually-assign-a-kms-server)
- [Method 5: Automatically publish KMS in multiple DNS domains](#method-5-automatically-publish-kms-in-multiple-dns-domains)

### Method 1: Change the product key to an MAK

If KMS activation will not be used, and if there is no KMS server, the product key should be changed to an MAK. For Microsoft Developer Network (MSDN), or for TechNet, the stock-keeping units (SKUs) that are listed below the media are generally volume licensed-media, and the product key that's provided is an MAK key.

To change the product key to an MAK, follow these steps:

1. Open an elevated command prompt. To do this, press the Windows logo key+X, and then right-click&nbsp;<strong class="uiterm">Command Prompt</strong>, and then select <strong>Run as administrator</strong>. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. At the command prompt, run the following command:
   ```cmd
    slmgr -ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
   ```
   > [!NOTE]
   > The **xxxxx-xxxxx-xxxxx-xxxxx-xxxxx** placeholder represents your MAK product key.  

### Method 2: Configure a KMS host server for the clients to activate against

KMS activation requires that a KMS host server be configured for the clients to activate against. If there are no KMS host servers configured in your environment, install and activate one by using an appropriate KMS host server key. After you configure a computer on the network to host the KMS software, publish the Domain Name System (DNS) settings.

For information about the KMS host server configuration process, see [Activate using Key Managment Service](https://docs.microsoft.com/windows/deployment/volume-activation/activate-using-key-management-service-vamt).

For more information about volume activation, see [Plan for volume activation](https://docs.microsoft.com/en-us/windows/deployment/volume-activation/plan-for-volume-activation-client).

### Method 3: Manually create a KMS SRV record

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756) in case problems occur.

If your network has a KMS host computer set up, and if the client cannot locate a KMS host on the network for activation, follow these steps:

1. Verify that the computer that has the KMS host installed and is activated by using a KMS key that&#39;s registered in DNS. To do this, follow these steps:  
   1. Open an elevated command prompt. To do this, press the Windows logo key+X, and then right-click **Command Prompt**, and then select **Run as administrator**. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
   1. At the command prompt, run the following command:
      ```cmd
      nslookup -type=all _vlmcs._tcp&gt;kms.txt
      ```
   1. Open the KMS.txt file that the command generates. This file should contain one or more entries that resemble the following entry:
      ```cmd
      _vlmcs._tcp.contoso.com         SRV service location:          priority   = 0          weight   = 0         port   = 1688         svr hostname   = kms-server.contoso.com 
      ```
   1. If these **_vlmcs** entries are present, and if they contain the expected KMS host names, go to [Method 4: Manually assign a KMS server](#method-4-manually-assign-a-kms-server).
1. Check the registry of the KMS host server to determine whether it is registering with DNS. By default, a KMS host server dynamically registers a DNS SRV record one time every 24 hours. To check this setting, follow these steps:
   1. Start Registry Editor. To do this, right-click **Start**, select **Run**, type **regedit**, and then press Enter.
   1. Locate the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SL** subkey, and check the value of the **DisableDnsPublishing** entry. This entry has the following possible values:
      - **0** or undefined (default): The KMS host server registers a SRV record once every 24 hours.
      - **1**: The KMS host server does not automatically register SRV records. If your implementation does not support dynamic updates, see [To manually create a SRV record for a KMS host](#to-manually-create-a-srv-record-for-a-kms-host).  
      If the **DisableDnsPublishing** entry is missing, create it (the type is DWORD). If dynamic registration is acceptable, leave the value undefined or set it to **0**.

#### To manually create a SRV record for a KMS host

To manually create a&nbsp;SRV record for a KMS host that uses a Microsoft DNS server, follow these steps:

1. On the DNS server, open DNS Manager. To open DNS Manager, select **Start**, select **Administrative Tools**, and then select **DNS**.
1. Select the DNS server on which you have to create the SRV resource record.
1. In the console tree, expand **Forward Lookup Zones**, right-click the domain, and then select **Other New Records**.
1. Scroll down the list, select **Service Location (SRV)**, and then select **Create Record**.
1. Type the following information:
   - Service: **_VLMCS**
   - Protocol: **_TCP**
   - Port number: **1688**
   - Host offering the service: **&lt;*FQDN of the KMS host*</em>*&gt;**
1. When you are finished, select **OK**, and then select **Done**.

To manually create a SRV record for a KMS host that uses a BIND 9.x-compliant DNS server, follow the instructions for that DNS server and provide the following information for the SRV record:

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
### Method 4: Manually assign a KMS server

By default, the KMS clients use the automatic discovery feature and query DNS for a list of servers that have published the _VLMCS record within the membership zone of the client. DNS returns the list of KMS hosts in a random order. The client picks a KMS host and tries to establish a session on it. If this attempt works, the client caches the server and tries to use it for the next renewal attempt. If the session setup fails, the client picks another server randomly. We highly recommend that you use the automatic discovery feature. However, you can manually assign a KMS server. To do this, open an elevated command prompt on the KMS client.

1. On a KMS client, open an elevated command prompt. To do this, press the Windows logo key+X, and then right-click&nbsp;**Command Prompt**, and then select **Run as administrator**. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
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
      cscript \windows\system32\slmgr.vbs -skms <NetbiosName>:<port>
      ```
   - To revert to automatic discovery on a KMS client, run the following command:
     ```cmd
     cscript \windows\system32\slmgr.vbs -ckms
     ```

### Method 5: Automatically publish KMS in multiple DNS domains

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

If the previous methods have not resolved this problem, the client may not be able to resolve the DNS name of the KMS server or connect to the KMS server. If this is the problem, follow these steps.

>[!NOTE]
> Unless otherwise stated, follow these steps on a KMS client that has experienced the applicable error.

1. At a command prompt, run the following command:
   ```cmd
   IPCONFIG /all
   ```
1. From the command results, note the assigned IP address, the DNS server address, and the default gateway address.
1. Verify basic IP connectivity to the DNS server by using the ping command. To do this, run the following command:
   ```cmd
   ping <DNS_Server_IP_address>
   ```
   > [!NOTE]
   > If this command does not ping the server, this problem must be resolved first. For more information about how to troubleshoot TCP/IP issues if you cannot ping the DNS server, see [Advanced troubleshooting for TCP/IP issues](https://docs.microsoft.com/windows/client-management/troubleshoot-tcpip).
1. Verify that the search list of the primary DNS suffix contains the DNS domain suffix that the KMS host registered.

   For the computers that have joined the domain, the DNS automatic discovery of KMS requires that the DNS zone contains the SRV resource record for the KMS host. This DNS zone is the DNS zone that corresponds to either the primary DNS suffix of the computer or to the domain of the Active Directory DNS.
  
   For workgroup computers, the DNS automatic discovery of KMS requires that the DNS zone contains the SRV resource record for the KMS host. This DNS zone is the DNS zone that corresponds to either the primary DNS suffix of the computer or to the DNS domain name that is assigned by the Dynamic Host Configuration Protocol (DHCP). This domain name is defined by the option that has the code value of 15 as defined in Request for Comments (RFC) 2132.
1. Verify that the KMS host SRV records are registered in DNS. At an elevated command prompt, run the following command:
   ```cmd
   nslookup -type=all _vlmcs._tcp>kms.txt
   ```
1. Open the Kms.txt file that was generated in step 5. This file should contain one or more entries that resemble the following:
   ```
   _vlmcs._tcp.contoso.com SRV service location:
   priority = 0
   weight = 0
   port = 1688 svr hostname = kms-server.contoso.com
   ```
   Verify the IP address, host name, and port of the KMS host.
   > [!NOTE]
   > If the **nslookup** command finds the KMS host, it does not mean that the DNS client can find the KMS host. If the **nslookup** command finds the KMS host, and if you still cannot activate the KMS host server, check the other settings, such as the primary DNS suffix and the search list of the DNS suffix.

   The SRV records are registered in the DNS zone that corresponds to the KMS host domain membership. For example, assume that a KMS host joins the contoso.com domain. In this scenario, the KMS host registers its VLMCS._TCP SRV record under the contoso.com DNS zone. Therefore, the VLMCS._TCP.CONTOSO.COM record is created.

#### To publish KMS information in multiple DNS domains
If the clients are configured to use a different DNS zone, automatically publish KMS in multiple DNS domains. To do this, follow these steps:

1. Start Registry Editor. To do this, right-click **Start**, select **Run**, type **regedit**, and then press Enter.
1. Locate and then select the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SL** subkey.
1. In the **Details** pane, right-click a blank area, select&nbsp;**New**, and then select **Multi-String Value**.
1. For the name of the new entry, enter&nbsp;**DnsDomainPublishList**.
1. Right-click the new **DnsDomainPublishList** entry, and then select&nbsp;**Modify**.
1. In the **Edit Multi-String** dialog box, type each DNS domain suffix that KMS publishes on a separate line, and then select **OK**.
   > [!NOTE]
   > For Windows Server 2008 R2, the format for **DnsDomainPublishList** differs.&nbsp;For more information, see the Volume Activation Technical Reference Guide.
1. Use the Services administrative tool to restart the Software Licensing service. This operation creates the SRV records.
1. Verify that by using a typical method, the KMS client can resolve the host name that is returned in the last step. When the name resolves, also verify that the IP address that is returned is accurate. If either of these verifications fails, investigate this DNS client resolver issue.
1. To use the KMS automatic discovery feature, run the following command at an elevated command prompt to clear any previously cached KMS host names:
   ```cmd
   cscript C:\Windows\System32\slmgr.vbs -ckms
   ```
1. If you believe that you have an SRV record issue, you can troubleshoot it by using one of the commands that are documented in [Method 4](#method-4-manually-assign-a-kms-server) to statically specify a KMS host. The following commands can be used to determine whether this is a name resolution issue or an SRV record issue. If none of these commands resolves the problem, you may be encountering a blocked port or an inaccessible host **(see the &quot;More Information&quot; section)**. Run the following commands:
   ```cmd
   cscript \windows\system32\slmgr.vbs -skms <KMS_FQDN>:<port>
   cscript \windows\system32\slmgr.vbs -ato
   ```
   If these commands resolve the problem, this is an SRV record issue. To fix it, you must troubleshoot the SRV record.

   If these commands do not resolve the problem, run the following commands:
   ```cmd
   cscript \windows\system32\slmgr.vbs -skms <IP Address>:<port>
   cscript \windows\system32\slmgr.vbs -ato
   ```
   If these commands resolve the problem, this is most likely a name resolution issue.

The 1688 TCP port is used for the activation communication between the KMS client and the KMS host. If the communication seems to be blocked, check the firewall configurations or anything else that may block the 1688 TCP port.

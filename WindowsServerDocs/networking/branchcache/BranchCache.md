---
title: BranchCache
description: This topic provides an overview of BranchCache in Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-bc
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4587cff-c086-49f1-a0bf-cd74b8a44440
ms.author: lizross
author: eross-msft
---
# BranchCache

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic, which is intended for Information Technology (IT) professionals, provides overview information about BranchCache, including BranchCache modes, features, capabilities, and the BranchCache functionality that is available in different operating systems.

> [!NOTE]
> In addition to this topic, the following BranchCache documentation is available.
> 
> - [BranchCache Network Shell and Windows PowerShell Commands](../branchcache/BranchCache-Network-Shell-and-Windows-PowerShell-Commands.md)
> -   [BranchCache Deployment Guide](../branchcache/deploy/BranchCache-Deployment-Guide.md)

**Who will be interested in BranchCache?**

If you are a system administrator, network or storage solution architect, or other IT professional, BranchCache might interest you under the following circumstances:

- You design or support IT infrastructure for an organization that has two or more physical locations and a wide area network (WAN) connection from the branch offices to the main office.

- You design or support IT infrastructure for an organization that has deployed cloud technologies, and a WAN connection is used by workers to access data and applications at remote locations.

- You want to optimize WAN bandwidth usage by reducing the amount of network traffic between branch offices and the main office.

- You have deployed or are planning on deploying content servers at your main office that match the configurations that are described in this topic.

- The client computers in your branch offices are running Windows 10,  Windows 8.1, Windows 8, or  Windows 7 .

This topic includes the following sections:

-   [What is BranchCache?](#bkmk_what)

-   [BranchCache modes](#BKMK_2)
  
-   [BranchCache-enabled content servers](#BKMK_3)
  
-   [BranchCache and the cloud](#BKMK_3a)
  
-   [Content information versions](#bkmk_version)  
  
-   [How BranchCache handles content updates in files](#bkmk_handles)  
  
-   [BranchCache installation guide](#BKMK_4)  
  
-   [Operating system versions for BranchCache](#bkmk_os)  
  
-   [BranchCache security](#bkmk_security)  
  
-   [Content flow and processes](#bkmk_flow)  
  
-   [Cache Security](#bkmk_cache)  
  
## <a name="bkmk_what"></a>What is BranchCache?

BranchCache is a wide area network (WAN) bandwidth optimization technology that is included in some editions of the Windows Server 2016 and Windows 10 operating systems, as well as in some editions of Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2 and  Windows 7. To optimize WAN bandwidth when users access content on remote servers, BranchCache fetches content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.
  
At branch offices, content is stored either on servers that are configured to host the cache or, when no server is available in the branch office, on client computers that are running Windows 10, Windows 8.1, Windows 8 or Windows 7. After a client computer requests and receives content from the main office and the content is cached at the branch office, other computers at the same branch office can obtain the content locally rather than downloading the content from the content server over the WAN link.

When subsequent requests for the same content are made by client computers, the clients download *content information* from the server instead of the actual content. Content information consists of hashes that are calculated using chunks of the original content, and are extremely small compared to the content in the original data. Client computers then use the content information to locate the content from a cache in the branch office, whether the cache is located on a client computer or on a server. Client computers and servers also use content information to secure cached content so that it cannot be accessed by unauthorized users.

BranchCache increases end user productivity by improving content query response times for clients and servers in branch offices, and can also help improve network performance by reducing traffic over WAN links.

## <a name="BKMK_2"></a>BranchCache modes
BranchCache has two modes of operation: distributed cache mode and hosted cache mode.

When you deploy BranchCache in distributed cache mode, the content cache at a branch office is distributed among client computers.

When you deploy BranchCache in hosted cache mode, the content cache at a branch office is hosted on one or more server computers, which are called hosted cache servers.

> [!NOTE]
> You can deploy BranchCache using both modes, however only one mode can be used per branch office. For example, if you have two branch offices, one which has a server and one which does not, you can deploy BranchCache in hosted cache mode in the office that contains a server, while deploying BranchCache in distributed cache mode in the office that contains only client computers.

In the following illustration, BranchCache is deployed in both modes.  

![BranchCache Modes](../media/BranchCache/bc_modes.jpg)

Distributed cache mode is best suited for small branch offices that do not contain a local server for use as a hosted cache server. Distributed cache mode allows you to deploy BranchCache with no additional hardware in branch offices.

If the branch office where you want to deploy BranchCache contains additional infrastructure, such as one or more servers that are running other workloads, deploying BranchCache in hosted cache mode is beneficial for the following reasons:

### Increased cache availability

Hosted cache mode increases the cache efficiency because content is available even if the client that originally requested and cached the data is offline. Because the hosted cache server is always available, more content is cached, providing greater WAN bandwidth savings, and BranchCache efficiency is improved.

### Centralized caching for multiple-subnet branch offices


Distributed cache mode operates on a single subnet. At a multiple-subnet branch office that is configured for distributed cache mode, a file downloaded to one subnet cannot be shared with client computers on other subnets. 

Because of this, clients on other subnets, unable to discover that the file has already been downloaded, get the file from the main office content server, using WAN bandwidth in the process.

When you deploy hosted cache mode, however, this is not the case - all clients in a multiple-subnet branch office can access a single cache, which is stored on the hosted cache server, even if the clients are on different subnets. In addition, BranchCache in Windows Server 2016,  Windows Server 2012 R2, and  Windows Server 2012  provides the ability to deploy more than one hosted cache server per branch office.

> [!CAUTION]
> If you use BranchCache for SMB caching of files and folders, do not disable Offline Files. If you disable Offline Files, BranchCache SMB caching does not function correctly.

## <a name="BKMK_3"></a>BranchCache-enabled content servers

When you deploy BranchCache, the source content is stored on BranchCache-enabled content servers in your main office or in a cloud data center. The following types of content servers are supported by BranchCache:

> [!NOTE]
> Only source content - that is, content that client computers initially obtain from a BranchCache-enabled content server - is accelerated by BranchCache. Content that client computers obtain directly from other sources, such as Web servers on the Internet or Windows Update, is not cached by client computers or hosted cache servers and then shared with other computers in the branch office. If you want to accelerate Windows Update content, however, you can install a Windows Server Update Services (WSUS) application server at your main office or cloud data center and configure it as a BranchCache content server.

### Web servers

Supported Web servers include computers that are running Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 that have the Web Server (IIS) server role installed and that use Hypertext Transfer Protocol (HTTP) or HTTP Secure (HTTPS).

In addition, the Web server must have the BranchCache feature installed.

### File servers

Supported file servers include computers that are running Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 that have the File Services server role and the BranchCache for Network Files role service installed. 

These file servers use Server Message Block (SMB) to exchange information between computers. After you complete installation of your file server, you must also share folders and enable hash generation for shared folders by using Group Policy or Local Computer Policy to enable BranchCache.

### Application servers

Supported application servers include computers that are running Windows Server 2016,  Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 with Background Intelligent Transfer Service (BITS) installed and enabled. 

In addition, the application server must have the BranchCache feature installed. As examples of application servers, you can deploy Microsoft Windows Server Update Services (WSUS) and Microsoft Endpoint Configuration Manager Branch Distribution Point servers as BranchCache content servers.

## <a name="BKMK_3a"></a>BranchCache and the cloud

The cloud has enormous potential to reduce operational expenses and achieve new levels of scale, but moving workloads away from the people who depend on them can increase networking costs and hurt productivity. Users expect high performance and don't care where their applications and data are hosted. 

BranchCache can improve the performance of networked applications and reduce bandwidth consumption with a shared cache of data.  It improves productivity in branch offices and in headquarters, where workers are using servers that are deployed in the cloud.

Because BranchCache does not require new hardware or network topology changes, it is an excellent solution for improving communication between office locations and both public and private clouds.

> [!NOTE]
> Because some Web proxies cannot process non-standard Content-Encoding headers, it is recommended that you use BranchCache with Hyper Text Transfer Protocol Secure (HTTPS) and not HTTP.
  
=======
For more information about cloud technologies in Windows Server 2016, see [Software Defined Networking &#40;SDN&#41;](../sdn/Software-Defined-Networking--SDN-.md).
  
## <a name="bkmk_version"></a>Content information versions

There are two versions of content information:

- Content information that is compatible with computers running  Windows Server 2008 R2 and  Windows 7 is called version 1, or V1. With V1 BranchCache file segmentation, file segments are larger than in V2 and are of fixed size. Because of large fixed segment sizes, when a user makes a change that modifies the file length, not only is the segment with the change invalidated, but all of the segments to the end of the file are invalidated. The next call for the changed file by another user in the branch office therefore results in reduced WAN bandwidth savings because the changed content and all content after the change are sent over the WAN link.

- Content information that is compatible with computers running Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1,  Windows Server 2012, and Windows 8 is called version 2, or V2. V2 content information uses smaller, variable-sized segments that are more tolerant to changes within a file. This increases the probability that segments from an older version of the file can be reused when users access an updated version, causing them to retrieve only the changed portion of the file from the content server, and using less WAN bandwidth.

The following table provides information on the content information version that is used depending upon which client, content server, and hosted cache server operating systems you are using in your BranchCache deployment.

> [!NOTE]
> In the table below, the acronym "OS" means operating system.

|Client OS|Content Server OS|Hosted Cache Server OS|Content Information Version|
|-------------|---------------------|--------------------------|-------------------------------|
|Windows Server 2008 R2 and Windows 7 |Windows Server 2012 or later|Windows Server 2012 or later; none for distributed cache mode|V1|
|Windows Server 2012 or later; Windows 8 or later|Windows Server 2008 R2 |Windows Server 2012 or later; none for distributed cache mode|V1|
|Windows Server 2012 or later; Windows 8 or later| Windows Server 2012 or later| Windows Server 2008 R2 |V1|
|Windows Server 2012 or later; Windows 8 or later|Windows Server 2012 or later|Windows Server 2012 or later; none for distributed cache mode|V2|

When you have content servers and hosted cache servers that are running Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012, they use the content information version that is appropriate based on the operating system of the BranchCache client that requests information. 

When computers running  Windows Server 2012 and Windows 8 or later operating systems request content, the content and hosted cache servers use V2 content information; when computers running  Windows Server 2008 R2 and Windows 7 request content, the content and hosted cache servers use V1 content information.

>[!IMPORTANT]
>When you deploy BranchCache in distributed cache mode, clients that use different content information versions do not share content with each other. For example, a client computer running Windows 7 and a client computer running Windows 10 that are installed in the same branch office do not share content with each other.
  
## <a name="bkmk_handles"></a>How BranchCache handles content updates in files

When branch office users modify or update the contents of documents, their changes are written directly to the content server in the main office without BranchCache's involvement. This is true whether the user downloaded the document from the content server or obtained it from either a hosted or distributed cache in the branch office.

When the modified file is requested by a different client in a branch office, the new segments of the file are downloaded from the main office server and added to the distributed or hosted cache in that branch. Because of this, branch office users always receive the most recent versions of cached content.

## <a name="BKMK_4"></a>BranchCache installation guide

You can use Server Manager in Windows Server 2016 to install either the BranchCache feature or the BranchCache for Network Files role service of the File Services server role. You can use the following table to determine whether to install the role service or the feature.

|Functionality|Computer location|Install this BranchCache element|
|-----------------|---------------------|------------------------------------|
|Content server \(BITS-based application server\)|Main office or cloud data center|BranchCache feature|
|Content server \(Web server\)|Main office or cloud data center|BranchCache feature|
|Content server \(file server using the SMB protocol\)|Main office or cloud data center|BranchCache for Network Files role service of the File Services server role|
|Hosted cache server|Branch office|BranchCache feature with hosted cache server mode enabled|
|BranchCache-enabled client computer|Branch office|No installation needed; just enable BranchCache and a BranchCache mode \(distributed or hosted\) on the client|

To install either the role service or the feature, open Server Manager and select the computers where you want to enable BranchCache functionality. In Server Manager, click **Manage**, and then click **Add Roles and Features**. The **Add Roles and Features** wizard opens. As you run the wizard, make the following selections:

- On the wizard page **Select Installation Type**, select **Role-based or Feature-based Installation**.

- On the wizard page **Select Server Roles**, if you are installing a BranchCache-enabled file server, expand **File and Storage Services** and **File and iSCSI Services**, and then select **BranchCache for Network Files**.  To save disk space, you can also select the **Data Deduplication** role service, and then continue through the wizard to installation and completion. If you do not want to install a BranchCache-enabled file server, do not install the File and Storage Services role with the BranchCache for Network Files role service.

- On the wizard page **Select features**, if you are installing a content server that is not a file server or you are installing a hosted cache server, select **BranchCache**, and then continue through the wizard to installation and completion. If you do not want to install a content server other than a file server or a hosted cache server, do not install the BranchCache feature.
  
## <a name="bkmk_os"></a>Operating system versions for BranchCache

Following is a list of operating systems that support different types of BranchCache functionality.

### Operating systems for BranchCache client computer functionality

The following operating systems provide BranchCache with support for Background Intelligent Transfer Service (BITS), Hyper Text Transfer Protocol (HTTP), and Server Message Block (SMB).

- Windows 10 Enterprise

- Windows 10 Education

- Windows 8.1 Enterprise

- Windows 8 Enterprise

- Windows 7 Enterprise

- Windows 7 Ultimate

In the following operating systems, BranchCache does not support HTTP and SMB functionality, but does support BranchCache BITS functionality.

-   Windows 10 Pro, BITS support only

-   Windows 8.1 Pro, BITS support only

-   Windows 8 Pro, BITS support only

-   Windows 7 Pro, BITS support only

> [!NOTE]
> BranchCache is not available by default in the Windows Server 2008 or Windows Vista operating systems. On these operating systems, however, if you download and install the Windows Management Framework update, BranchCache functionality is available for the Background Intelligent Transfer Service (BITS) protocol only. For more information, and to download Windows Management Framework, see [Windows Management Framework (Windows PowerShell 2.0, WinRM 2.0, and BITS 4.0)](https://go.microsoft.com/fwlink/?LinkId=188677) at https://go.microsoft.com/fwlink/?LinkId=188677.
  
### Operating systems for BranchCache content server functionality

You can use the Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012 families of operating systems as BranchCache content servers.

In addition, the  Windows Server 2008 R2 family of operating systems can be used as BranchCache content servers, with the following exceptions:

- BranchCache is not supported in Server Core installations of Windows Server 2008 R2 Enterprise with Hyper-V.

- BranchCache is not supported in Server Core installations of Windows Server 2008 R2 Datacenter with Hyper-V.

### Operating systems for BranchCache hosted cache server functionality

You can use the Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012 families of operating systems as BranchCache hosted cache servers.

In addition, the following  Windows Server 2008 R2  operating systems can be used as BranchCache hosted cache servers:

- Windows Server 2008 R2 Enterprise

- Windows Server 2008 R2 Enterprise with Hyper-V

- Windows Server 2008 R2 Enterprise Server Core Installation

- Windows Server 2008 R2 Enterprise Server Core Installation with Hyper-V

- Windows Server 2008 R2 for Itanium-Based Systems

- Windows Server 2008 R2 Datacenter

- Windows Server 2008 R2 Datacenter with Hyper-V

- Windows Server 2008 R2 Datacenter Server Core Installation with Hyper-V

## <a name="bkmk_security"></a>BranchCache Security

BranchCache implements a secure-by-design approach that works seamlessly alongside your existing network security architectures, without the requirement for additional equipment or complex additional security configuration.
  
BranchCache is non-invasive and does not alter any Windows authentication or authorization processes. After you deploy BranchCache, authentication is still performed using domain credentials, and the way in which authorization with Access Control Lists (ACLs) functions is unchanged. In addition, other configurations continue to function just as they did before BranchCache deployment.

The BranchCache security model is based on the creation of metadata, which takes the form of a series of hashes. These hashes are also called content information.

After content information is created, it is used in BranchCache message exchanges rather than the actual data, and it is exchanged using the supported protocols (HTTP, HTTPS, and SMB).

Cached data is kept encrypted and cannot be accessed by clients that do not have permission to access content from the original source.  Clients must be authenticated and authorized by the original content source before they can retrieve content metadata, and must possess content metadata to access the cache in the local office.

### How BranchCache generates content information

Because content information is created from multiple elements, the value of the content information is always unique. These elements are:

- The actual content (such as Web pages or shared files) from which the hashes are derived.  

- Configuration parameters, such as the hashing algorithm and block size. To generate content information, the content server divides the content into segments and then subdivides those segments into blocks. BranchCache uses secure cryptographic hashes to identify and verify each block and segment, supporting the SHA256 hash algorithm.

- A server secret. All content servers must be configured with a server secret, which is a binary value of arbitrary length.

> [!NOTE]
> The use of a server secret ensures that client computers are not able to generate the content information themselves. This prevents malicious users from using brute force attacks with BranchCache-enabled client computers to guess minor changes in content across versions in situations in which the client had access to a previous version but does not have access to the current version.

### Content information details

BranchCache uses the server secret as a key in order to derive a content-specific hash that is sent to authorized clients. Applying a hashing algorithm to the combined server secret and the Hash of Data generates this hash.

This hash is called the segment secret. BranchCache uses segment secrets to secure communications. In addition, BranchCache creates a Block Hash List, which is list of hashed data blocks, and the Hash of Data, which is generated by hashing the Block Hash List.

The content information includes the following:

- The Block Hash List:

    `BlockHashi = Hash(dataBlocki)   1<=i<=n`

- The Hash of Data (HoD):

    `HoD = Hash(BlockHashList)`

- Segment Secret (Kp):

    `Kp = HMAC(Ks, HoD)`

BranchCache uses the Peer Content Caching protocol and the Retrieval Framework protocol to implement the processes that are required to ensure the secure caching and retrieval of data between content caches.

In addition, BranchCache handles content information with the same degree of security that it uses when handling and transmitting the actual content itself.

## <a name="bkmk_flow"></a>Content flow and processes

The flow of content information and actual content is divided into four phases:

1.  [BranchCache processes: Request content](#BKMK_8)

2.  [BranchCache processes: Locate content](#BKMK_9)

3.  [BranchCache processes: Retrieve content](#BKMK_10)

4.  [BranchCache processes: Cache content](#BKMK_11)

The following sections describe these phases.

## <a name="BKMK_8"></a>BranchCache processes: Request content

In the first phase, the client computer in the branch office requests content, such as a file or a Web page, from a content server in a remote location, such as a main office. The content server verifies that the client computer is authorized to receive the requested content. If the client computer is authorized and both content server and client are BranchCache\-enabled, the content server generates content information.

The content server then sends the content information to the client computer using the same protocol as would have been used for the actual content. 

For example, if the client computer requested a Web page over HTTP, the content server sends the content information using HTTP. Because of this, the wire-level security guarantees of the content and the content information are identical.

After the initial portion of content information (Hash of Data + Segment Secret) is received, the client computer performs the following actions:

- Uses the Segment Secret (Kp) as the encryption key (Ke).

- Generates the Segment ID (HoHoDk) from the HoD and Kp:

    `HoHoDk = HMAC(Kp, HoD + C), where C is the ASCII string "MS_P2P_CACHING" with NUL terminator.`

The primary threat at this layer is the risk to the Segment Secret, however BranchCache encrypts the content data blocks to protect the Segment Secret. BranchCache does this by using the encryption key that is derived from the Segment Secret of the content segment within which the content blocks are located.

This approach ensures that an entity that is not in possession of the server secret cannot discover the actual content in a data block. The Segment Secret is treated with the same degree of security as the plaintext segment itself, because knowledge of the Segment Secret for a given segment enables an entity to obtain the segment from peers and then decrypt it. Knowledge of the Server Secret does not immediately yield any particular plaintext but can be used to derive certain types of data from the cipher text and then to possibly expose some partially known data to a brute-force guessing attack. The server secret, therefore, should be kept confidential.
  
## <a name="BKMK_9"></a>BranchCache processes: Locate content

After the content information is received by the client computer, the client uses the Segment ID to locate the requested content in the local branch office cache, whether that cache is distributed between client computers or is located on a hosted cache server.

If the client computer is configured for hosted cache mode, it is configured with the computer name of the hosted cache server and contacts that server to retrieve the content.

If the client computer is configured for distributed cache mode, however, the content might be stored across multiple caches on multiple computers in the branch office. The client computer must discover where the content is located before the content is retrieved.

When they are configured for distributed cache mode, client computers locate content by using a discovery protocol that is based on the Web Services Dynamic Discovery (WS-Discovery) protocol. Clients send WS-Discovery multicast Probe messages to discover cached content over the network. Probe messages include the Segment ID, which enables clients to check whether the requested content matches the content stored in their cache. Clients that receive the initial Probe message reply to the querying client with unicast Probe-Match messages if the Segment ID matches content that is cached locally.  

The success of the WS-Discovery process depends on the fact that the client that is performing the discovery has the correct content information, which was provided by the content server, for the content that it is requesting.

The main threat to data during the Request content phase is information disclosure, because access to the content information implies authorized access to content. To mitigate this risk, the discovery process does not reveal the content information, other than the Segment ID, which does not reveal anything about the plaintext segment that contains the content.

In addition, another client computer run by a malicious user on the same network subnet can see the BranchCache discovery traffic to the original content source going through the router.

If the requested content is not found in the branch office, the client requests the content directly from the content server across the WAN link.

After the content is received, it is added to the local cache, either on the client computer or on a hosted cache server. In this case, the content information prevents a client or hosted cache server from adding to the local cache any content that does not match the hashes. The process of verifying content by matching hashes ensures that only valid content is added to the cache, and the integrity of the local cache is protected.

## <a name="BKMK_10"></a>BranchCache processes: Retrieve content

After a client computer locates the desired content on the content host, which is either a hosted cache server or a distributed cache mode client computer, the client computer begins the process of retrieving the content.

First the client computer sends a request to the content host for the first block that it requires. The request contains the Segment ID and block range that identify the desired content. Because only one block is returned, the block range contains only a single block. (Requests for multiple blocks are currently not supported.) The client also stores the request in its local Outstanding Request List.  

Upon receiving a valid request message from a client, the content host checks whether the block specified in the request exists in the content host's content cache.

If the content host is in possession of the content block, then the content host sends a response that contains the Segment ID, the Block ID, the encrypted data block, and the initialization vector that is used for encrypting the block.

If the content host is not in possession of the content block, the content host sends an empty response message. This informs the client computer that the content host does not have the requested block. An empty response message contains the Segment ID and Block ID of the requested block, along with a zero-sized data block.

When the client computer receives the response from the content host, the client verifies that the message corresponds to a request message in its Outstanding Request List. (The Segment ID and block index must match that of an outstanding request.)

If this verification process is unsuccessful and the client computer does not have a corresponding request message in its Outstanding Request List, the client computer discards the message.

If this verification process is successful and the client computer has a corresponding request message in its Outstanding Request List, the client computer decrypts the block. The client then validates the decrypted block against the appropriate block hash from the content information that the client initially obtained from the original content server.

If the block validation is successful, the decrypted block is stored in the cache.

This process is repeated until the client has all of the required blocks.

> [!NOTE]
> If the complete segments of content do not exist on one computer, the retrieval protocol retrieves and assembles content from a combination of sources:  a set of distributed cache mode client computers, a hosted cache server, and - if the branch office caches do not contain the complete content - the original content server in the main office.

Before BranchCache sends content information or content, the data is encrypted. BranchCache encrypts the block in the response message. In Windows 7, the default encryption algorithm that BranchCache uses is AES-128, the encryption key is Ke, and the key size is 128 bits, as dictated by the encryption algorithm. 

BranchCache generates an initialization vector that is suitable for the encryption algorithm and uses the encryption key to encrypt the block. BranchCache then records the encryption algorithm and the initialization vector in the message. 

Servers and clients never exchange, share, or send each other the encryption key. The client receives the encryption key from the content server that hosts the source content. Then, using the encryption algorithm and initialization vector it received from the server, it decrypts the block. There is no other explicit authentication or authorization built into the download protocol.

### Security threats

The primary security threats at this layer include:

- Tampering with data:

  *A client serving data to a requester tampers with the data*. The BranchCache security model uses hashes to confirm that neither the client nor the server has altered the data.  

- Information disclosure:  

    *BranchCache sends encrypted content to any client that specifies the appropriate Segment ID*. Segment IDs are public, so any client can receive encrypted content. However, if a malicious user obtains encrypted content, they must know the encryption key to decrypt the content. The upper layer protocol performs authentication and then gives the content information to the authenticated and authorized client. The security of the content information is equivalent to the security provided to the content itself, and BranchCache never exposes the content information.  

    *An attacker sniffs the wire to obtain the content*.  BranchCache encrypts all transfers between clients by using AES128 where the secret key is Ke, preventing data from being sniffed from the wire.  Content information that is downloaded from the content server is protected in exactly the same way as the data itself would have been and is hence no more or less protected from information disclosure than if BranchCache had not been used at all.

-   Denial of Service:

    *A client is overwhelmed by requests for data*. BranchCache protocols incorporate queue management counters and timers to prevent clients from being overloaded.

## <a name="BKMK_11"></a>BranchCache processes: Cache content

On distributed cache mode client computers and hosted cache servers that are located in branch offices, content caches are built up over time as content is retrieved over WAN links.

When client computers are configured with hosted cache mode, they add content to their own local cache and also offer data to the hosted cache server. The Hosted Cache Protocol provides a mechanism for clients to inform the hosted cache server about content and segment availability.

To upload content to the hosted cache server, the client informs the server that it has a segment that is available. The hosted cache server then retrieves all of the content information that is associated with the offered segment, and downloads the blocks within the segment that it actually needs. This process is repeated until the client has no more segments to offer the hosted cache server.

To update the hosted cache server by using the Hosted Cache Protocol, the following requirements must be met:

- The client computer is required to have a set of blocks within a segment that it can offer to the hosted cache server. The client must supply content information for the offered segment; this is comprised of the Segment ID, the segment Hash of Data, the Segment Secret, and a list of all block hashes that are contained within the segment.

- For hosted cache servers that are running  Windows Server 2008 R2, a hosted cache server certificate and associated private key are required, and the certification authority (CA) that issued the certificate must be trusted by client computers in the branch office. This allows the client and server to participate successfully in HTTPS Server authentication.

    > [!IMPORTANT]
    > Hosted cache servers that are running Windows Server 2016,  Windows Server 2012 R2 , or  Windows Server 2012  do not require a hosted cache server certificate and associated private key.  

- The client computer is configured with the computer name of the hosted cache server and the Transmission Control Protocol (TCP) port number upon which the hosted cache server is listening for BranchCache traffic. The hosted cache server's certificate is bound to this port. The computer name of the hosted cache server can be a fully qualified domain name (FQDN), if the hosted cache server is a domain member computer; or it can be the NetBIOS name of the computer if the hosted cache server is not a domain member.

- The client computer actively listens for incoming block requests. The port on which it is listening is passed as part of the offer messages from the client to the hosted cache server. This enables the hosted cache server to use BranchCache protocols to connect to the client computer to retrieve data blocks in the segment.

- The hosted cache server starts to listen for incoming HTTP requests when it is initialized.

- If the hosted cache server is configured to require client computer authentication, both the client and the hosted cache server are required to support HTTPS authentication.

### Hosted cache mode cache population

The process of adding content to the hosted cache server's cache in a branch office begins when the client sends an INITIAL_OFFER_MESSAGE, which includes the Segment ID. The Segment ID in the INITIAL_OFFER_MESSAGE request is used to retrieve the corresponding segment Hash of Data, list of block hashes, and the Segment Secret from the hosted cache server's block cache. If the hosted cache server already has all the content information for a particular segment, the response to the INITIAL_OFFER_MESSAGE will be OK, and no request to download blocks occurs.

If the hosted cache server does not have all of the offered data blocks that are associated with the block hashes in the segment, the response to the INITIAL_OFFER_MESSAGE is INTERESTED. The client then sends a SEGMENT_INFO_MESSAGE that describes the single segment that is being offered. The hosted cache server responds with an OK message and initiates the download of the missing blocks from the offering client computer.

The segment Hash of Data, list of block hashes, and the segment secret are used to ensure that the content that is being downloaded has not been tampered with or otherwise altered. The downloaded blocks are then added to the hosted cache server's block cache.

## <a name="bkmk_cache"></a>Cache Security  
This section provides information on how BranchCache secures cached data on client computers and on hosted cache servers.

### Client computer cache security
The greatest threat to data stored in the BranchCache is tampering. If an attacker can tamper with content and content information that is stored in the cache, then it might be possible to use this to try and launch an attack against the computers that are using BranchCache. Attackers can initiate an attack by inserting malicious software in place of other data. BranchCache mitigates this threat by validating all content using block hashes found in the content information. If an attacker attempts to tamper with this data, it is discarded and is replaced with valid data from the original source.

A secondary threat to data stored in the BranchCache is information disclosure. In distributed cache mode, the client caches only the content that it has requested itself; however, that data is stored in clear text, and might be at risk. To help restrict cache access to the BranchCache Service only, the local cache is protected by file system permissions that are specified in an ACL. 

Although the ACL is effective in preventing unauthorized users from accessing the cache, it is possible for a user with administrative privileges to gain access to the cache by manually changing the permissions that are specified in the ACL. BranchCache does not protect against the malicious use of an administrative account.

Data that is stored in the content cache is not encrypted, so if data leakage is a concern, you can use encryption technologies such as BitLocker or the Encrypting File System (EFS). The local cache that is used by BranchCache does not increase the information disclosure threat borne by a computer in the branch office; the cache contains only copies of files that reside unencrypted elsewhere on the disk. 

Encrypting the entire disk is particularly important in environments in which the physical security of the clients is difficult to ensure. For example, encrypting the entire disk helps to secure sensitive data on mobile computers that might be removed from the branch office environment.

### Hosted cache server cache security

In hosted cache mode, the greatest threat to the security of the hosted cache server is information disclosure. BranchCache in a hosted cache environment behaves in a similar manner to distributed cache mode, with file system permission protecting the cached data. The difference is that the hosted cache server stores all of the content that any BranchCache-enabled computer in the branch office requests, rather than just the data that a single client requests. The consequences of unauthorized intrusion into this cache could be much more serious, because much more data is at risk.  
  
In a hosted cache environment where the hosted cache server is running  Windows Server 2008 R2, the use of encryption technologies such as BitLocker or EFS is advisable if any of the clients in the branch office can access sensitive data across the WAN link. It is also necessary to prevent physical access to the hosted cache, because disk encryption works only when the computer is turned off when the attacker gains physical access.  If the computer is turned on or is in sleep mode, then disk encryption offers little protection.

> [!NOTE]
> Hosted cache servers that are running Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 encrypt all data in the cache by default, so the use of additional encryption technologies is not required.

Even if a client is configured in hosted cache mode, it will still cache data locally, and you might want to take steps to protect the local cache in addition to the cache on the hosted cache server.

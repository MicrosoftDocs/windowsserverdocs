---
title: DNSSEC Performance Considerations
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d597031-23d8-472f-9cb5-48d020d18b15
---
# DNSSEC Performance Considerations
Prior to signing a DNS zone, consider the impact that DNSSEC can have on DNS server performance and resource utilization. This section provides information to help you understand how server performance is affected by DNSSEC.  
  
## In this section  
[DNS performance](../Topic/DNSSEC-Performance-Considerations.md#considerations)  
  
[Cryptographic algorithms](../Topic/DNSSEC-Performance-Considerations.md#algorithms)  
  
## <a name="considerations"></a>DNS performance  
Performance considerations for DNSSEC\-signed zones include the following:  
  
-   Signed zones can require up to five times more memory than an equivalent unsigned zone. Make sure that sufficient memory is available on all the DNS servers that will host signed zones.  
  
-   Zone loading time is increased for DNSSEC\-signed zones. A DNS server with several large DNSSEC\-signed zones will require additional time to restart the DNS Server service or to reload individual signed zones.  
  
-   When responding to queries, the DNS server will respond with additional DNSSEC resource records. This will increase the number of packets on the wire and can decrease the maximum query throughput of the DNS server by a factor of two to three times compared to an unsigned zone.  
  
-   A DNS server that is performing validation of DNSSEC data can experience an increase in CPU usage. A server that is authoritative for signed zones typically experiences only a small increase in CPU usage associated with its zone handling. However, the increase in CPU load can be more significant if the DNS server also performs validation on data that it obtains from other remote signed zones, when it servicesqueries from clients, or when it is configured to act as a forwarder for other DNS servers, depending on how many queries it has to service.  
  
-   A signed zone can have four or more times the number of records as the unsigned version of the zone depending on the number of signing keys and algorithms that are used. Depending on the signature size, the actual disk space that is consumed by a file\-backed signed zone can be more than ten times that of the unsigned zone. This disk space requirement is not a concern for Active Directory\-integrated zones, because the signatures are only stored in memory and are never committed to disk.  
  
The actual performance of a DNSSEC\-signed zone depends on the following factors:  
  
-   **Zone type**: The DNS server must generate signatures when loading Active Directory\-integrated zones, but will have signatures stored on disk for a file\-backed zone. Therefore, zone type can significantly affect the server performance with respect to zone loading.  
  
-   **Cryptographic algorithms**: RSA\-based algorithms are generally faster from a signature generation and validation standpoint as compared to Elliptical Curve\-based algorithms, for example.  
  
-   **Key length**: Longer key lengths create larger signatures and increased signature computation and verification overhead.  
  
-   **Denial of Existence \(NSEC vs. NSEC3\)**: NSEC3 requires the calculation of hashes in the authenticating and non\-authenticating functions. The number of hash iterations can also affect performance by adding overhead to zone signing time and validation.  
  
## <a name="algorithms"></a>Cryptographic algorithms  
In general, cryptographic operations are computationally expensive. For large zones, the DNS server can take several minutes to sign the zone depending on the key length and size of the zone. To prevent performance degradation from occurring when all DNS servers start to sign the zone at the same time, signing is staggered. When a replica domain controller identifies the DNSSEC keys and configuration, it waits for a random period of between 5 minutes and 30 minutes before it begins signing the zone. Different cryptographic algorithms also have a different impact on DNS server resources. See the following table.  
  
The following table shows available cryptographic algorithms on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
|Algorithm|Key length \(bits\)|  
|-------------|-----------------------|  
|ECDSAP256\/SHA\-256|256|  
|ECDSAP384\/SHA\-384|384|  
|RSA\/SHA\-1|1024 \- 4096|  
|RSA\/SHA\-1 \(NSEC3\)|1024 \- 4096|  
|RSA\/SHA\-256|1024 \- 4096|  
|RSA\/SHA\-512|1024 \- 4096|  
  
The following figure displays results from lab testing of Active Directory\-integrated zone signing performance and memory usage for different choices of ZSK cryptographic algorithms, key lengths, and NSEC choices. The results are intended to show a general trend for different choices of signing key parameters. Precise results will vary based on the DNS environment.  
  
The following figure shows zone signing performance and memory usage for different cryptographic algorithms and key lengths.  
  
![](../Image/DNSSEC_crypto-perf.png)  
  
-   Red indicates the number of nodes that are signed per second. In Active Directory, resource records are represented as attribute values on a dnsNode object.  
  
-   Blue indicates additional memory that is required by the DNS service process when the zone is loaded. A value of three means that the zone takes up three times as much memory.  
  
As shown in the preceding figure, longer key lengths or the use of ECDSAP cryptographic algorithms are associated with significantly greater computational expense and memory consumption.  
  
## See also  
[Why DNSSEC](../Topic/Why-DNSSEC.md)  
  
[Stage a DNSSEC Deployment](../Topic/Stage-a-DNSSEC-Deployment.md)  
  
[DNSSEC Requirements](../Topic/DNSSEC-Requirements.md)  
  

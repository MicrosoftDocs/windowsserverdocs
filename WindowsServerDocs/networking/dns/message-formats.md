---
title: DNS Message Formats in Windows and Windows Server
description: Learn DNS message formats in Windows environments. Understand query, response, and update message structures to troubleshoot name resolution and optimize DNS performance.
#customer intent: As a DNS server administrator, I want to understand DNS query message structure so that I can analyze DNS traffic and identify potential problems.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 07/01/2025
---

# DNS message formats

This article explains the structure and format of DNS (Domain Name System) messages in Windows and Windows Server environments. Understanding DNS message formats is essential for DNS server administrators who need to analyze DNS traffic, troubleshoot name resolution issues, and optimize DNS performance.

DNS uses standardized message formats for communication between clients and servers. All DNS messages—whether queries, responses, or updates—follow a common structure with specific fields that determine how the information is processed. This article covers the three main types of DNS messages and breaks down their components to help you understand how DNS communication works at the protocol level.

## DNS protocols and standards

DNS in Windows and Windows Server adheres to industry standards and protocols defined by the Internet Engineering Task Force (IETF). The core DNS protocol is specified in [RFC 1035](https://datatracker.ietf.org/doc/rfc1035/), which outlines the format of DNS messages, including queries and responses. Additional standards, such as [RFC 2136](https://datatracker.ietf.org/doc/rfc2136/) for dynamic updates and [RFC 4033](https://datatracker.ietf.org/doc/rfc4033/) for DNS Security Extensions (DNSSEC), enhance the functionality and security of DNS.

The DNS protocol consists of different types of DNS messages that are processed according to the information in their message fields. This section discusses the types of DNS messages and the fields in each message type.

There are three types of DNS messages:

- Queries

- Responses

- Updates

Queries and responses are defined in the original DNS standard, and updates are defined in RFC 2136. All three types follow a common message format.

To learn more about the message formats, expand the following sections.

## DNS query message format
The common DNS message format has a fixed-length, 12-byte header and a variable position reserved for question, answer, authority, and additional DNS resource records. The common message format can be illustrated as follows:

**Standard DNS query message format**

- **DNS header** (fixed length)
- **Question entries** (variable length)
- **Answer resource records** (variable length)
- **Authority resource records** (variable length)
- **Additional resource records** (variable length)

### DNS query message header

The DNS message header contains the following fields, in the following order:

**DNS query message header fields**

- **Transaction ID**:  
   A 16-bit field identifying a specific DNS transaction. The transaction ID is created by the message originator and is copied by the responder into its response message. Using the transaction ID, the DNS client can match responses to its requests.

- **Flags**:  
   A 16-bit field containing various service flags communicated between the DNS client and server, including:
  - **Request/response**: 1-bit field set to 0 for a request or 1 for a response.
  - **Operation code**: 4-bit field representing the name service operation of the packet; `0x0` is a query.
  - **Authoritative answer**: 1-bit field indicating the responder is authoritative for the queried domain name.
  - **Truncation**: 1-bit field set to 1 if the total number of responses exceeded the UDP datagram size. Unless UDP datagrams larger than 512 bytes or EDNS0 are enabled, only the first 512 bytes of the UDP reply are returned.
  - **Recursion desired**: 1-bit field set to 1 for a recursive query and 0 for iterative queries. If set to 0, the DNS server returns a list of other DNS servers from local cache data.
  - **Recursion available**: 1-bit field set by a DNS server to 1 if it can handle recursive queries. If recursion is disabled, the server sets the field appropriately.
  - **Reserved**: 3-bit field that is reserved and set to 0.
  - **Return code**: 4-bit field holding the return code:
    - `0`: Successful response (query answer is in the response).
    - `0x3`: Name error, indicating that an authoritative DNS server responded that the domain name does not exist. For more information about return codes, see [IANA DNS RCODEs](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6).

- **Question Resource Record count**:  
   A 16-bit field representing the number of entries in the question section of the DNS message.

- **Answer Resource Record count**:  
   A 16-bit field representing the number of entries in the answer section of the DNS message.

- **Authority Resource Record count**:  
   A 16-bit field representing the number of authority resource records in the DNS message.

- **Additional Resource Record count**:  
   A 16-bit field representing the number of additional resource records in the DNS message.

### DNS query question entries

The DNS message’s question entries section contains the domain name that is being queried and has the following three fields:

- **Question Name**:  
  The domain name being queried. DNS domain names are expressed as a series of labels (e.g., `microsoft.com`). In the Question Name field, the domain name is encoded as a series of length-value pairs: a 1-byte field indicating the length of the label, followed by the label itself. For example, `microsoft.com` is encoded as `0x09microsoft0x03com0x00`, where the hexadecimal digits represent label lengths, the ASCII characters are the labels, and the final `0` indicates the end of the name.

- **Question Type**:  
  A 16-bit integer representing the resource record type to be returned. Common values include:
  - `0x01`: Host (A) record
  - `0x02`: Name server (NS) record
  - `0x05`: Alias (CNAME) record
  - `0x0C` (12): Reverse-lookup (PTR) record
  - `0x0F` (15): Mail exchange (MX) record
  - `0x21` (33): Service (SRV) record
  - `0xFB` (251): Incremental zone transfer (IXFR) record
  - `0xFC` (252): Standard zone transfer (AXFR) record
  - `0xFF` (255): All records

- **Question Class**:  
   Represents the IN (Internet) question class, normally set to `0x0001`.

### DNS query response message

The answer, authority, and additional information sections of a DNS response message can contain resource records that answer the query message question section. Resource records are formatted as follows:

- **Resource Record Name**: The DNS domain name recorded as a variable-length field following the same formatting as the Question Name field.
- **Resource Record Type**: The resource record type value.
- **Resource Record Class**: The resource record class code, the Internet class, 0x0001.
- **Time-to-Live**: The TTL expressed in seconds as a 32-bit unsigned field.
- **Resource Data Length**: 2-byte field indicating the length of the resource data.
- **Resource Data**: Variable-length data corresponding to the resource record type.

The Resource Record Name field is encoded in the same way as the Question Name field unless the name is already present elsewhere in the DNS message, in which case a 2-byte field is used in place of a length-value encoded name and acts as a pointer to the name that is already present.

## Name Query message format

A Name Query message format is the same as the DNS message format described above. In a typical Name Query message, the DNS message fields are set as follows:

- **Query Identifier (Transaction ID)**:  
   Set to a unique number to enable the DNS client resolver to match the response to the query. The query response transaction ID always matches the query request transaction ID.

- **Flags**:  
   Set to indicate a standard query with recursion enabled.

- **Question Count**:  
   Set to 1.

- **Question Entry**:  
   Set to the domain name queried and the resource record type to return.

### Name Query Response message format

A Name Query Response message format is the same as the DNS message format described above. In a typical Name Query message, the DNS message fields would be set as follows:

- **Query Identifier (Transaction ID)**:  
   Set to a unique number to enable the DNS client resolver to match the response to the query.

- **Flags**:  
   Set to indicate a standard query with recursion enabled.

- **Question Count**:  
   Set to 1.

- **Question Entry**:  
   Set to the domain name queried and the resource record type to return.

### Reverse name query message format

Reverse name query messages use the common message format with the following differences:

- The DNS client resolver constructs the domain name in the in-addr.arpa domain based on the IP address that is queried.

- A Pointer (PTR) resource record is queried rather than a host (A) resource record.

## Update message format

The DNS update message format uses a header defining the update operation to be performed and a resource record set that contains the update. The DNS update message format has the following fields:

- **Identification**. A 16-bit identifier assigned by the DNS client requestor. This identifier is copied in the corresponding reply and can be used by the requestor to match replies to outstanding requests, or by the server to detect duplicated requests from some requestor.  

- **Flags**. A 16-bit DNS update message flags field. For a description of each flag, see “DNS Update Message Flags field” below.  

- **Number of zone entries**. The number of resource records in the Zone entry section.  

- **Number of prerequisite resource records**. The number of resource records in the Prerequisite resource records section.  

- **Number of update resource records**. The number of resource records in the Update resource records section.  

- **Number of additional resource records**. The number of resource records in the Additional resource records section.  

- **Zone entry**. Denotes the zone of the records being updated. All records to be updated must be in the same zone, and therefore the Zone Section is allowed to contain exactly one record. It has three values: ZNAME is the zone name, the ZTYPE must be SOA, and the ZCLASS is the zone’s class.  

- **Prerequisite resource records**. Contains a set of resource record prerequisites that must be satisfied at the time the update message is received by the master DNS server. There are five possible sets of values that can be expressed:  

  - Resource record set exists (value independent). At least one resource record with a specified name and type (in the zone and class specified by the Zone Section) must exist.  

  - Resource record set exists (value dependent). A set of resource records with a specified name and type exists and has the same members with the same data as the resource record set specified in this section.  

  - Resource record set does not exist. No resource records with a specified name and type (in the zone and class denoted by the Zone section) exist.  

  - Name is in use. At least one resource record with a specified name (in the zone and class specified by the Zone section) exists. This prerequisite is not satisfied by empty nonterminals.  

  - Name is not in use. No resource record of any type is owned by a specified name. This prerequisite is satisfied by empty nonterminals.  

- **Update resource records**. Contains the resource records that are to be added or deleted from the zone. One of four operations is performed during the update:  

  - Add resource records to a resource records set.  

  - Delete a resource records set.  

  - Delete all resource records sets from a name.  

  - Delete a resource record from a resource records set.  

- **Additional resource records**. Contains resource records that are related to the update, or to new resource records being added by the update.  

### DNS update message flags field

The DNS update message flags field uses the following flags:

- **Request/response**. 1-bit field set to 0 to represent an update request and 1 to represent an update response.  

- **Operation code**. 4-bit field set to 0x5 for DNS updates.  

- **Reserved**. 7-bit reserved field set to 0.  

- **Return code**. 4-bit field containing codes to represent the result of the update query. The codes are as follows:  

  - **0 (NOERROR)**: No error; successful update.
  - **1 (FORMERR)**: Format error; DNS server did not understand the update request.
  - **0x2 (SERVFAIL)**: DNS server encountered an internal error, such as a forwarding timeout.
  - **0x3 (NXDOMAIN)**: A name that should exist does not exist.
  - **0x4 (NOTIMP)**: DNS server does not support the specified Operation code.
  - **0x5 (REFUSED)**: DNS server refuses to perform the update.
  - **0x6 (YXDOMAIN)**: A name that should not exist does exist.
  - **0x7 (YXRRSET)**: A resource record set that should not exist does exist.
  - **0x8 (NXRRSET)**: A resource record set that should exist does not exist.
  - **0x9 (NOTAUTH)**: DNS server is not authoritative for the zone named in the Zone section.
  - **0xA (NOTZONE)**: A name used in the Prerequisite or Update sections is not within the zone specified by the Zone section.

### Dynamic update response message format

The dynamic update response message follows the same format as the DNS update message, with the exception of the DNS flags. The dynamic update response message header flags indicate whether the update is successful by including the successful response code or one of the error codes described in DNS update message flags.

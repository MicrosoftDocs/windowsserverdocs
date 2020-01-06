---
title: tapicfg
description: Learn how to manage a TAPI application directory partition.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0e642ce-5d98-4edb-9a65-1dff09aef4e1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# tapicfg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates, removes, or displays a TAPI application directory partition, or sets a default TAPI application directory partition. TAPI 3.1 clients can use the information in this application directory partition with the directory service locator service to find and communicate with TAPI directories.You can also use **tapicfg** to create or remove service connection points, which enable TAPI clients to efficiently locate TAPI application directory partitions in a domain. For more information, see remarks. To view the command syntax, click a command. 
-   [tapicfg install](#BKMK_install)
-   [tapicfg remove](#BKMK_remove)
-   [tapicfg publishscp](#BKMK_publishscp)
-   [tapicfg removescp](#BKMK_removescp)
-   [tapicfg show](#BKMK_show)
-   [tapicfg makedefault](#BKMK_makedefault)

## <a name="BKMK_install"></a>tapicfg install
Creates a TAPI application directory partition.

### Syntax
```
tapicfg install /directory:<PartitionName> [/server:<DCName>] [/forcedefault]
```
### Parameters
|Parameter|Description|
|-------|--------|
|install /directory:\<PartitionName>|Required. Specifies the DNS name of the TAPI application directory partition to be created. This name must be a fully qualified domain name.|
|/server: \<DCName>|Specifies the DNS name of the domain controller on which the TAPI application directory partition is created. If the domain controller name is not specified, the name of the local computer is used.|
|/forcedefault|Specifies that this directory is the default TAPI application directory partition for the domain. There can be multiple TAPI application directory partitions in a domain.<br /><br />if this directory is the first TAPI application directory partition created on the domain, it is automatically set as the default, regardless of whether you use the **/forcedefault** option.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_remove"></a>tapicfg remove
Removes a TAPI application directory partition.

### Syntax
```
tapicfg remove /directory:<PartitionName>
```
### Parameters
|Parameter|Description|
|-------|--------|
|remove /directory:\<PartitionName>|Required. Specifies the DNS name of the TAPI application directory partition to be removed. Note that this name must be a fully qualified domain name.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_publishscp"></a>tapicfg publishscp
Creates a service connection point to publish a TAPI application directory partition.

### Syntax
```
tapicfg publishscp /directory:<PartitionName> [/domain:<DomainName>] [/forcedefault]
```
### Parameters
|Parameter|Description|
|-------|--------|
|publishscp /directory:\<PartitionName>|Required. Specifies the DNS name of the TAPI application directory partition that the service connection point will publish.|
|/domain:\<DomainName>|Specifies the DNS name of the domain in which the service connection point is created. If the domain name is not specified, the name of the local domain is used.|
|/forcedefault|Specifies that this directory is the default TAPI application directory partition for the domain. There can be multiple TAPI application directory partitions in a domain.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_removescp"></a>tapicfg removescp
Removes a service connection point for a TAPI application directory partition.

### Syntax
```
tapicfg removescp /directory:<PartitionName> [/domain:<DomainName>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|removescp /directory:\<PartitionName>|Required. Specifies the DNS name of the TAPI application directory partition for which a service connection point is removed.|
|/domain: \<DomainName>|Specifies the DNS name of the domain from which the service connection point is removed. If the domain name is not specified, the name of the local domain is used.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_show"></a>tapicfg show
Displays the names and locations of the TAPI application directory partitions in the domain.

### Syntax
```
tapicfg show [/defaultonly][ /domain:<DomainName>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/defaultonly|Displays the names and locations of only the default TAPI application directory partition in the domain.|
|/domain: \<DomainName>|Specifies the DNS name of the domain for which the TAPI application directory partitions are displayed. If the domain name is not specified, the name of the local domain is used.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_makedefault"></a>tapicfg makedefault
Sets the default TAPI application directory partition for the domain.

### Syntax
```
tapicfg makedefault /directory:<PartitionName> [/domain:<DomainName>]  
```
### Parameters
|Parameter|Description|
|-------|--------|
|makedefault /directory:\<PartitionName>|Required. Specifies the DNS name of the TAPI application directory partition set as the default partition for the domain. Note that this name must be a fully qualified domain name. Specifies the DNS name of the domain for which the TAPI application directory partition is set as the default. If the domain name is not specified, the name of the local domain is used.|
|/?|Displays help at the command prompt.|

## Remarks
You must be a member of the Enterprise Admins group in active directory to run either **tapicfg install** (to create a TAPI application directory partition) or **tapicfg remove** (to remove a TAPI application directory partition).

This command-line tool can be run on any computer that is a member of the domain.

User-supplied text (such as the names of TAPI application directory partitions, servers, and domains) with International or Unicode characters are only displayed correctly if appropriate fonts and language support are installed.

You can still use Internet Locator Service (ILS) servers in your organization, if ILS is needed to support certain applications, because TAPI clients running Windows XP or a Windows Server 2003 operating system can query either ILS servers or TAPI application directory partitions.

You can use **tapicfg** to create or remove service connection points. If the TAPI application directory partition is renamed for any reason (for example, if you rename the domain in which it resides), you must remove the existing service connection point and create a new one that contains the new DNS name of the TAPI application directory partition to be published. Otherwise, TAPI clients are unable to locate and access the TAPI application directory partition. You can also remove a service connection point for maintenance or security purposes (for example, if you do not want to expose TAPI data on a specific TAPI application directory partition).

## Examples
To create a TAPI application directory partition named tapifiction.testdom.microsoft.com on a server named testdc.testdom.microsoft.com and then set it as the default TAPI application directory partition for the new domain, type:
```
tapicfg install /directory:tapifiction.testdom.microsoft.com /server:testdc.testdom.microsoft.com /forcedefault
```
To display the name of the default TAPI application directory partition for the new domain, type:
```
tapicfg show /defaultonly
```
## Additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)

---
title: dfsdiag TestDCs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: abb915ab-23eb-45d7-9a2e-b6b9a5756a70
---
# dfsdiag TestDCs
Checks the configuration of domain controllers by performing the following tests on each domain controller in the specified domain:

-   verifies that the Distributed File System \(DFS\) Namespace service is running and that its startup type is set to Automatic.

-   Checks for the support of site\-costed referrals for NETLOGON and SYSvol.

-   verifies the consistency of the site association by hostname and IP address.

for examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
dfsdiag /TestDCs [/Domain:<Domain name>]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/Domain:<Domain name>|Domain that you want to check.|

## remarks
\/Domain is an optional parameter. The default value is the local domain that the local host is joined to.

## <a name="BKMK_Examples"></a>Examples
To verify the configuration of domain controllers in the Contoso.com domain, type:

```
dfsdiag /TestDCs /Domain:Contoso.com
```

## additional references

-   [Command-Line Syntax Key](../commandline-syntax-key.md)

-   [dfsdiag](../dfsdiag.md)



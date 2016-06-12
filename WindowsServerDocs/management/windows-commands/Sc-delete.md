---
title: Sc delete
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fe94fb3-e4d1-47b5-b999-39995ecbb644
---
# Sc delete
deletes a service subkey from the registry. if the service is running or if another process has an open handle to the service, the service is marked for deletion.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
sc [<ServerName>] delete [<ServiceName>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ServerName>|Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention \(UNC\) format \(for example, \\\\myserver\). To run SC.exe locally, omit this parameter.|
|<ServiceName>|Specifies the service name returned by the **getkeyname** operation.|
|?|Displays help at the command prompt.|

## remarks
Use **add or remove Programs** on **Control Panel** to delete DHCP, DNS, or any other built\-in operating system services. Note that **add or remove Programs** will not only remove the registry subkey for the service, but it will also uninstall the service and delete any shortcuts to it.

## <a name="BKMK_examples"></a>Examples
To delete the service subkey **NewServ** from the registry on the local computer, type:

```
sc delete newserv
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)



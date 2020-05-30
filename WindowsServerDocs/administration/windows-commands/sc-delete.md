---
title: Sc.exe delete
description: Learn how unregister services using the sc.exe utility
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 2fe94fb3-e4d1-47b5-b999-39995ecbb644
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Sc.exe delete

Deletes a service subkey from the registry. If the service is running or if another process has an open handle to the service, the service is marked for deletion.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
sc.exe [<ServerName>] delete [<ServiceName>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<ServerName>|Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\\\myserver). To run SC.exe locally, omit this parameter.|
|\<ServiceName>|Specifies the service name returned by the **getkeyname** operation.|
|?|Displays help at the command prompt.|

## Remarks

It is not recommended to use sc.exe to delete built-in operating system services such as DHCP, DNS, or Internet Information Services. To install, remove, or reconfigure operating system roles, services and components, see [Install or Uninstall Roles, Role Services, or Features](/WindowsServerDocs/administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)

## Examples

To delete the service subkey **NewServ** from the registry on the local computer, type:
```
sc.exe delete newserv
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

---
title: sc.exe delete
description: Reference article for the sc.exe delete command, which deletes a service subkey from the registry.
ms.topic: reference
ms.assetid: 2fe94fb3-e4d1-47b5-b999-39995ecbb644
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# sc.exe delete

Deletes a service subkey from the registry. If the service is running or if another process has an open handle to the service, the service is marked for deletion.

> [!NOTE]
> We don't recommend you to use this command to delete built-in operating system services such as DHCP, DNS, or Internet Information Services. To install, remove, or reconfigure operating system roles, services and components, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features)

## Syntax

```
sc.exe [<servername>] delete [<servicename>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<servername>` | Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\myserver). To run SC.exe locally, don't use this parameter. |
| `<servicename>` | Specifies the service name returned by the **getkeyname** operation. |
| /? | Displays help at the command prompt. |

## Examples

To delete the service subkey **NewServ** from the registry on the local computer, type:

```
sc.exe delete NewServ
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

---
title: sc delete
description: Reference article for the sc delete command, which deletes a service subkey from the registry.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 08/15/2025
---

# sc delete

Deletes a service subkey from the registry. If the service is running or if another process has an open handle to the service, the service is marked for deletion.

> [!NOTE]
> We don't recommend you to use this command to delete built-in operating system services such as DHCP, DNS, or Internet Information Services. To install, remove, or reconfigure operating system roles, services and components, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features)

## Syntax

```
sc <server> delete [service name]
```

### Parameters

| Parameter | Description |
|--|--|
| `<server>` | Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\\MyServer). To run `sc` locally, don't use this parameter. |
| `<service name>` | Specifies the service name returned by the **getkeyname** operation. |
| /? | Displays help at the command prompt. |

## Examples

To delete the service subkey **NewServ** from the registry on the local computer, type:

```
sc delete NewServ
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

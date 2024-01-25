---
title: pubprn
description: Reference article for the pubprn command, which publishes a printer to the Active Directory Domain Services.
ms.topic: reference
ms.assetid: 0bc7f7e3-84e1-4359-b477-7b1a1a0bd639
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# pubprn

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Publishes a printer to the Active Directory Domain Services. This command is a Visual Basic script located in the `%WINdir%\System32\printing_Admin_Scripts\<language>` directory. To use this command at a command prompt, type **cscript** followed by the full path to the pubprn file, or change directories to the appropriate folder. For example: `cscript %WINdir%\System32\printing_Admin_Scripts\en-US\pubprn`.

## Syntax

```
cscript pubprn {<servername> | <UNCprinterpath>} LDAP://CN=<container>,DC=<container>
```

### Parameters

| Parameter | Description |
|--|--|
| `<servername>` | Specifies the name of the Windows server that hosts the printer that you want to publish. If you don't specify a computer, the local computer is used. |
| `<UNCprinterpath>` | The Universal Naming Convention (UNC) path to the shared printer that you want to publish. |
| `LDAP://CN=<Container>,DC=<Container>` | Specifies the path to the container in Active Directory Domain Services where you want to publish the printer. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "Computer Name").

### Examples

To publish all printers on the \\Server1 computer to the MyContainer container in the MyDomain.company.com domain, type:

```
cscript pubprn Server1 LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com
```

To publish the Laserprinter1 printer on the \\\Server1 server to the MyContainer container in the MyDomain.company.com domain, type:

```
cscript pubprn \\Server1\Laserprinter1 LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)

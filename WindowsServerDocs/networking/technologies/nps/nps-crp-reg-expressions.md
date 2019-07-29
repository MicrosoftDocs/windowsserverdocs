---
title: Use Regular Expressions in NPS
description: This topic explains the use of regular expressions for pattern matching in NPS in Windows Server 2016. You can use this syntax to specify the conditions of network policy attributes and RADIUS realms.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: bc22d29c-678c-462d-88b3-1c737dceca75
ms.author: pashort 
author: shortpatti
---

# Use Regular Expressions in NPS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic explains the use of regular expressions for pattern matching in NPS in Windows Server 2016. You can use this syntax to specify the conditions of network policy attributes and RADIUS realms.

## Pattern-matching reference

You can use the following table as a reference source when creating regular expressions with pattern-matching syntax.


|  Character  |                                                                                 Description                                                                                  |                                                                 Example                                                                 |
|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
|     `\`     |                                                              Marks the next character as a character to match.                                                               |                      `/n/ matches the character "n". The sequence /\n/ matches a line feed or newline character.`                       |
|     `^`     |                                                                 Matches the beginning of the input or line.                                                                  |                                                                 &nbsp;                                                                  |
|     `$`     |                                                                    Matches the end of the input or line.                                                                     |                                                                 &nbsp;                                                                  |
|     `*`     |                                                             Matches the preceding character zero or more times.                                                              |                                                  `/zo*/ matches either "z" or "zoo."`                                                   |
|     `+`     |                                                              Matches the preceding character one or more times.                                                              |                                                   `/zo+/ matches "zoo" but not "z."`                                                    |
|     `?`     |                                                              Matches the preceding character zero or one times.                                                              |                                                 `/a?ve?/ matches the "ve" in "never."`                                                  |
|     `.`     |                                                           Matches any single character except a newline character.                                                           |                                                                 &nbsp;                                                                  |
| `(pattern)` |                         Matches "pattern" and remembers the match.<br />To match the literal characters `(` and `)` (parentheses), use `\(` or `\)`.                         |                                                                 &nbsp;                                                                  |
|   `x | y `  |                                                                               Matches either x or y.                                                          |
|   `{n} `    |                                                          Matches exactly n times \(n is a non\-negative integer\).                                                           |               `/o{2}/ does not match the "o" in "Bob," but matches the first two instances of the letter o in "foooood."`               |
|   `{n,}`    |                                                          Matches at least n times \(n is a non\-negative integer\).                                                          | `/o{2,}/ does not match the "o" in "Bob" but matches all of the instances of the letter o in "foooood." /o{1,}/ is equivalent to /o+/.` |
|   `{n,m}`   |                                                Matches at least n and at most m times \(m and n are non\-negative integers\).                                                |                               `/o{1,3}/ matches the first three instances of the letter o in "fooooood."`                               |
|   `[xyz]`   |                                                       Matches any one of the enclosed characters \(a character set\).                                                        |                                                  `/[abc]/ matches the "a" in "plain."`                                                  |
|  `[^xyz]`   |                                                  Matches any characters that are not enclosed \(a negative character set\).                                                  |                                                 `/[^abc]/ matches the "p" in "plain."`                                                  |
|    `\b`     |                                                              Matches a word boundary \(for example, a space\).                                                               |                                              `/ea*r\b/ matches the "er" in "never early."`                                              |
|    `\B`     |                                                                         Matches a nonword boundary.                                                                          |                                             `/ea*r\B/ matches the "ear" in "never early."`                                              |
|    `\d`     |                                                       Matches a digit character \(equivalent to digits from 0 to 9\).                                                        |                                                                 &nbsp;                                                                  |
|    `\D`     |                                                           Matches a nondigit character \(equivalent to `[^0-9]`\).                                                           |                                                                 &nbsp;                                                                  |
|    `\f`     |                                                                        Matches a form feed character.                                                                        |                                                                 &nbsp;                                                                  |
|    `\n`     |                                                                        Matches a line feed character.                                                                        |                                                                 &nbsp;                                                                  |
|    `\r`     |                                                                     Matches a carriage return character.                                                                     |                                                                 &nbsp;                                                                  |
|    `\s`     |                                   Matches any white space character including space, tab, and form feed \(equivalent to `[ \f\n\r\t\v]`\).                                   |                                                                 &nbsp;                                                                  |
|    `\S`     |                                                  Matches any non-white space character \(equivalent to `[^ \f\n\r\t\v]`\).                                                   |                                                                 &nbsp;                                                                  |
|    `\t`     |                                                                           Matches a tab character.                                                                           |                                                                 &nbsp;                                                                  |
|    `\v`     |                                                                      Matches a vertical tab character.                                                                       |                                                                 &nbsp;                                                                  |
|    `\w`     |                                              Matches any word character, including underscore \(equivalent to `[A-Za-z0-9_]`\).                                              |                                                                 &nbsp;                                                                  |
|    `\W`     |                                           Matches any non\-word character, excluding underscore \(equivalent to `[^A-Za-z0-9_]`\).                                           |                                                                 &nbsp;                                                                  |
|   `\num`    | Refers to remembered matches \(`?num`, where num is a positive integer\).  This option can be used only in the **Replace** text box when configuring attribute manipulation. |                                       `\1` replaces what is stored in the first remembered match.                                       |
|   `/n/ `    |                      Allows the insertion of ASCII codes into regular expressions \(`?n`, where n is an octal, hexadecimal, or decimal escape value\).                       |                                                                 &nbsp;                                                                  |

## Examples for network policy attributes

The following examples describe the use of the pattern-matching syntax to specify network policy attributes:

- To specify all phone numbers within the 899 area code, the syntax is:

     `899.*`

- To specify a range of IP addresses that begin with 192.168.1, the syntax is:

    `192\.168\.1\..+`

## Examples for manipulation of the realm name in the User Name attribute

The following examples describe the use of the pattern-matching syntax to manipulate realm names for the User Name attribute, which is located on the **Attribute** tab in the properties of a connection request policy.

**To remove the realm portion of the User Name attribute**

In an outsourced dial-up scenario in which an Internet service provider \(ISP\) routes connection requests to an organization NPS, the ISP RADIUS proxy might require a realm name to route the authentication request. However, the NPS might not recognize the realm name portion of the user name. Therefore, the realm name must be removed by the ISP RADIUS proxy before it is forwarded to the organization NPS.

- Find: @microsoft\.com

- Replace:

**To replace <em>user@example.microsoft.com</em> with *example.microsoft.com\user***

- Find:`(.*)@(.*)`

- Replace:`$2\$1`



**To replace *domain\user* with *specific_domain\user***

- Find:`(.*)\\(.*)`

- Replace: *specific_domain*`\$2`



<strong>To replace *user* with *user@specific_domain</strong>*

- Find:`$`

- Replace: @*specific_domain*

## Example for RADIUS message forwarding by a proxy server

You can create routing rules that forward RADIUS messages with a specified realm name to a set of RADIUS servers when NPS is used as a RADIUS proxy. Following is a recommended syntax for routing requests based on realm name.

- **NetBIOS name**: `WCOAST`
- **Pattern**:      `^wcoast\\`

In the following example, wcoast.microsoft.com is a unique user principal name (UPN) suffix for the DNS or Active Directory domain wcoast.microsoft.com. Using the supplied pattern, the NPS proxy can route messages based on domain NetBIOS name or UPN suffix.

- **NetBIOS name**: `WCOAST`
- **UPN suffix**:   `wcoast.microsoft.com`
- **Pattern**:      `^wcoast\\|@wcoast\.microsoft\.com$`


For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).

---
title: SMB firewall rules
description: How to configure firewall rules for SMB.
ms.topic: conceptual
author: Heidilohr
ms.author: helohr
ms.date: 02/12/2024
---
# SMB firewall rules (preview)

<!---PREVIEW notification goes here--->

There are certain changes we've made to the Insiders preview version of Windows Server regarding firewall rules.

In earlier versions of Windows Server, when you created a share, the firewall automatically enabled certain rules in the File and Printer Sharing group. In particular, the built-in firewall automatically used inbound NetBIOS ports 137 through 139. However, the current preview build of Windows Server Insiders Edition doesn't contain those NetBIOS ports anymore. Shares made with SMB2 or later don't use NetBIOS ports 137-139. If you need to use an SMB1 server for legacy compatibility reasons, you must manually reconfigure the firewall to open those ports

We made this change to ensure a higher degree of network security. This change brings SMB firewall rules more in line with the standard behavior for the Windows Server File Server role. In the default settings for the File Server role, the firewall only opens the minimum number of ports required for sharing data. Administrators can reconfigure the rules to restore the legacy ports.
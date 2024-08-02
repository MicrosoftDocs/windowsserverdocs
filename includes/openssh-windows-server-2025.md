---
author: Heidilohr
ms.author: helohr
ms.service: windows-server
ms.topic: include
ms.date 08/02/2024
---

Starting with Windows Server 2025, OpenSSH is now installed on Windows Server by default. You don't need to install OpenSSH in order to start using SSHD. However, you can enable or disable OpenSSH in Server Manager.

>[!NOTE]
>When enabled, SSHD is only allowed on private networks on default port 22.

To enable SSHD:

1. Open **Server Manager**.

1. Select **Local Server**.

1. Under **Remote SSH Access**, select **Disabled**.

1. A PowerShell window opens. Wait for a few minutes while the cmdlet to enable SSHD automatically runs. After the window closes and a few more minutes pass, the setting should be enabled.

1. If you're enabling SSHD for a specific user, add them to the **OpenSSH Users** user group.
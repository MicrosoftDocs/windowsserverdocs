---
title: Join a computer to a domain
description: Learn how to add a client computer or server device to a domain in Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 06/06/2025
zone_pivot_groups: windows-os-version-plus-client
---

# Join a computer to a domain

Joining a server or client device to a domain is an essential step for achieving centralized management and improved security within an organization's network. Whether you're configuring a new device or optimizing your network setup, follow this guide for a seamless integration into your domain environment.

> [!IMPORTANT]
> **KB5020276** is a Microsoft update that strengthens the security of the domain join process. This update introduces enhanced validation and authentication to help prevent unauthorized devices from joining a Windows domain, ensuring that only trusted devices can be added to your network. To learn more, see [KB5020276 - Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

## Prerequisites

:::zone pivot="windows-server-2025,windows-server-2022,windows-server-2019,windows-server-2016"

**Server requirements**

Your Windows Server device must have the **Active Directory Domain Services** role installed to use the Active Directory Users and Computers (ADUC) tool. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

You must be a member of the Administrators group or have administrative privileges on both the local account and domain account.

::: zone-end

:::zone pivot="windows-client-11,windows-client-10"

**Client requirements**

The user account must have administrative privileges on the local machine to join a domain.

Your client device must have one of the following versions of Windows installed:

- Enterprise
- Enterprise N
- Pro
- Pro N
- Pro Education
- Pro Education N
- Pro for Workstations
- Pro N for Workstations

::: zone-end

> [!NOTE]
> To keep time synchronized, organizations often use the Windows Time Service or a Network Time Protocol (NTP) server. Within a domain, computers typically sync their clocks with the Domain Controller, which should be aligned with a dependable time source. This process ensures consistent time settings across all devices in the domain, minimizing potential issues with Kerberos authentication.

:::zone pivot="windows-server-2025,windows-server-2022,windows-server-2019,windows-server-2016"

## Prestage a device using ADUC

This step is optional and not mandatory for joining a device to a domain. However, prestaging a device in Active Directory can streamline the process by pre-assigning the computer account to the appropriate organizational unit (OU) and ensuring proper permissions are in place before the device joins the domain.

1. In **Server Manager**, select the **Tools** button from the top right menu.

1. In the drop-down menu, select **Active Directory Users and Computers**.

1. In the left pane, navigate to and select the appropriate organizational unit (OU).

1. Select the **Actions** tab, select **New**, then select **Computer**.

1. Enter the computer name and configure which user or group the device should belong to.

1. Select **OK** This can help prepare for when the client is ready to join the domain.

::: zone-end

## Join a device to a domain

Joining a device to a domain can be done using either graphical user interface (GUI) methods or command-line tools, depending on your preference and the needs of your environment. Both approaches ensure  integration into the domain.

:::zone pivot="windows-server-2025,windows-server-2022,windows-server-2019,windows-server-2016"

### Server Manager method

1. In **Server Manager**, select **Local Server**, under **Workgroup**, select the workgroup or domain name hyperlink.

1. Under the **Computer Name** tab, select **Change**.

1. Under **Member of**, select **Domain**, type the name of the domain that you wish the computer to join, and then select **OK**.

1. Provide the credentials needed to join the domain, then select **OK**.

1. After the device successfully joins the domain, a notification confirms the device's domain membership. Select **OK**, and you're prompted to restart your device.

::: zone-end

### Control Panel method

:::zone pivot="windows-server-2025,windows-client-11"

1. Select **Start**, type **Control Panel**, and then press **ENTER**.

1. Ensure that from the **View by** drop-down menu at the top right is set to **Category**.

1. Navigate to **System and Security**, then select **System**.

1. Select **Domain or workgroup**, under the **Computer Name** tab, select **Change**.

1. Under **Member of**, select **Domain**, type the name of the domain that you wish the computer to join, and then select **OK**.

1. Provide the credentials needed to join the domain, then select **OK**.

1. After the device successfully joins the domain, a notification confirms the device's domain membership. Select **OK**, and you're prompted to restart your device.

::: zone-end

:::zone pivot="windows-server-2022"

1. Select **Start**, type **Control Panel**, and then press **ENTER**.

1. Ensure that from the **View by** drop-down menu at the top right is set to **Category**.

1. Navigate to **System and Security**, then select **System**.

1. Select **Advanced system settings**, then select **Change settings**.

1. Under the **Computer Name** tab, select **Change**.
'
1. Under **Member of**, select **Domain**, type the name of the domain that you wish the computer to join, and then select **OK**.

1. Provide the credentials needed to join the domain, then select **OK**.

1. After the device successfully joins the domain, a notification confirms the device's domain membership. Select **OK**, and you're prompted to restart your device.

::: zone-end

:::zone pivot="windows-server-2019,windows-server-2016,windows-client-10"

1. Select **Start**, type **Control Panel**, and then press **ENTER**.

1. Ensure that from the **View by** drop-down menu at the top right is set to **Category**.

1. Navigate to **System and Security**, then select **System**.

1. Under **Computer name, domain, and workgroup settings**, select **Change settings**.

1. Under the **Computer Name** tab, select **Change**.
'
1. Under **Member of**, select **Domain**, type the name of the domain that you wish the computer to join, and then select **OK**.

1. Provide the credentials needed to join the domain, then select **OK**.

1. After the device successfully joins the domain, a notification confirms the device's domain membership. Select **OK**, and you're prompted to restart your device.

::: zone-end

:::zone pivot="windows-client-11,windows-client-10"

### Settings app method

1. Select **Start**, select **Settings**, then select **Accounts**.

1. Select **Access work or school**, then select **Connect**.

1. Select **Join this device to a local Active Directory domain**.

1. Enter the domain name, select **Next**, and the account credentials, then select **OK**.

1. Restart the device.

::: zone-end

### Command line method

Adding a device to a domain can be performed through the command prompt or PowerShell.

# [Command Prompt](#tab/cmd)

1. Open an elevated command prompt window.

1. Run the following command replacing `YourDomainName` and `DomainUsername` with your values:

   ```cmd
   netdom join %COMPUTERNAME% /domain:YourDomainName /userd:DomainUsername /passwordd:*
   ```

1. The system prompts you to enter the password for the specified domain user account.

1. Reboot your device. Once you sign in, you're joined to the domain.

# [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the following command replacing `YourDomainName` with your value:

   ```powershell
   Add-Computer -DomainName "YourDomainName" -Credential (Get-Credential)
   Restart-Computer
   ```

1. You're prompted to enter the domain credentials.

Your device restarts after entering the domain credentials to join the domain.

---

## Rejoin a disjoined device to a domain

In cases where a client or server device is disjoined from the domain, you can restore its trust relationship by removing the device from the domain and then rejoining it. This process re-establishes the connection between the device and the domain. The process in leaving a domain is similar to joining one.

:::zone pivot="windows-server-2025,windows-server-2022,windows-server-2019,windows-server-2016"

### Rejoin a domain using Server Manager

To leave a domain using the *Server Manager*, follow the previous steps to join the domain until you reach the **System Properties** window.

1. Under **Member of**, select **Workgroup**, type the name of a workgroup to temporarily join, and then select **OK**.

1. Select **OK** again and then reboot your device.

1. Once you sign back into the local account, repeat the steps to join your device to the domain it was disjoined from previously.

### Rejoin a server to a domain using Control Panel

To leave a domain using the *Control Panel*, follow the previous steps to join the domain until you reach the **System Properties** window.

1. Under **Member of**, select **Workgroup**, type the name of a workgroup to temporarily join, and then select **OK**.

1. Select **OK** again and then reboot your device.

1. Once you sign back into the local account, repeat the steps to join your device to the domain it was disjoined from previously.

::: zone-end

:::zone pivot="windows-client-11,windows-client-10"

### Rejoin a client to a domain using Control Panel

To leave a domain using the *Control Panel*, follow the previous steps to join the domain until you reach the **System Properties** window.

1. Under **Member of**, select **Workgroup**, type the name of a workgroup to temporarily join, and then select **OK**.

1. Select **OK** again and then reboot your device.

1. Once you sign back into the local account, repeat the steps to rejoin your device to the domain it was disjoined from previously.

### Rejoin a domain using Settings

To leave a domain using the *Settings app*, follow the previous steps to join the domain until you reach the **Access work or school** window.

1. Under your account, select **Disconnect**, then select **Yes**.

1. Reboot your device.

1. Once you sign back into the local account, repeat the steps to rejoin your device to the domain it was disjoined from previously.

::: zone-end

### Rejoin a domain using the command line

To leave a domain using the *command line*, follow these steps:

# [Command Prompt](#tab/cmd)

1. Open an elevated command prompt window.

1. Run the following command replacing `YourDomainName` and `DomainUsername` with your values:

   ```cmd
   netdom remove %COMPUTERNAME% /domain:YourDomainName /userd:DomainUsername /passwordd:*
   ```

1. The system prompts you to enter the password for the specified domain user account.

1. After your device reboots, sign into the local account.

1. Follow the steps provided in [Command line method](#command-line-method) to rejoin the domain.

# [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the following command:

   ```powershell
   Remove-Computer -UnjoinDomainCredential (Get-Credential) -PassThru -Verbose -Restart
   ```

1. You're prompted to enter the domain credentials. Your device restarts after entering the domain credentials.

1. Sign into your device and follow the steps provided in [Command line method](#command-line-method) to rejoin the domain.

---

## Repair domain trust relationship

You might encounter the following error when the secure channel between a domain-joined computer and the domain controller is disrupted:

```error
The trust relationship between this workstation and the primary domain failed.
```

This error typically occurs when the machine's password isn't synchronized with the domain database. It can also happen if the computer account in the domain was deleted or became corrupt. You can resolve the trust relationship issue between the device and the domain using the command line.

# [Command Prompt](#tab/cmd)

1. Sign in with the local administrator account.

1. Open an elevated command prompt window.

1. Test the secure channel by running the following command replacing `ComputerName` and `YourDomainName` with your values:

   ```cmd
   netdom verify ComputerName /domain:YourDomainName
   ```

1. Reset the machine password by running the following command replacing `DomainControllerName` and `Domain\Username` with your values:

   ```cmd
   netdom resetpwd /server:DomainControllerName /userd:Domain\Username /passwordd:*
   ```

   You're prompted to provide the password for the account.

1. Run the following command replacing `YourDomainName` and `DomainUsername` with your values to reset the secure channel:

   ```cmd
   netdom reset /domain:YourDomainName /userd:DomainUsername /passwordd:*
   ```

   You're prompted to provide the password for the account.

1. Restart your device for changes to take effect. Follow the steps provided in [Command line method](#command-line-method) to rejoin the domain.

# [PowerShell](#tab/powershell)

1. Sign in with the local administrator account.

1. Open an elevated PowerShell window.

1. Test the secure channel by running the following command:

   ```powershell
      Test-ComputerSecureChannel
      ```

      If the test returns `True`, the secure channel is intact, and the problem might be elsewhere such as with the Domain Name System (DNS) or other network issue. If `False`, continue with the next steps.

1. Attempt to repair the secure channel directly using the following command and provide the credentials when prompted:

   ```powershell
   Test-ComputerSecureChannel -Repair -Credential (Get-Credential)
   ```

1. Run the following command to reset the computer account password and enter the domain credentials when prompted:

   ```powershell
   $credential = Get-Credential
   Reset-ComputerMachinePassword -Credential $credential
   Restart-Computer -Force
   ```

1. After your device reboots, follow the steps provided in [Command line method](#command-line-method) to rejoin the domain.

---


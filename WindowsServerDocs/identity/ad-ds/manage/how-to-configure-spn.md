---
title: How to configure SPN for Windows Server
description: Learn how to configure Service Principal Names (SPN) for Active Directory service accounts in Windows Server.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 03/24/2025
---

# How to configure SPN

The `setspn` command-line tool is used to read, modify, and delete the Service Principal Name (SPN) directory property for an Active Directory (AD) service account. SPNs are essential for locating a target principal name associated with a service. With `setspn`, you can view existing SPNs, reset an account's default SPNs, and add or remove additional SPNs as needed.

It's unnecessary to manually modify SPNs since they're automatically set up when a computer joins a domain or when services are installed. However, SPN information can become outdated in certain cases. For instance, if a computer's name changes, the SPNs tied to its services need updating to match the new name. Additionally, some services and applications might require manual updates to a service account's SPN settings to ensure proper authentication.

In AD, the `servicePrincipalName` attribute is a multivalued, nonlinked attribute built from the Domain Name System (DNS) host name. SPNs are used for mutual authentication between the client and the server hosting a service. The client locates a computer account using the SPN of the service it's trying to connect to.

## SPN format

When you modify SPNs using `setspn`, the SPN must be entered in the correct format. The format of an SPN is *serviceclass/host:port/servicename*, in which each item represents a name or value. Unless the service name and port aren't standard, you don't have to enter them when you use `setspn`. For example, the default SPNs for a server named WSRV2022 that is providing remote desktop (RDP) services over the default port TCP 3389 registers the following two SPNs in its own AD computer object:

```
TERMSRV/WSRV2022

TERMSRV/WSRV2022.contoso1.com
```

If you need to specify a nonstandard SPN configuration, see [Name Formats for Unique SPNs](/windows/win32/ad/name-formats-for-unique-spns).

## Prerequisites

- The **Active Directory Domain Services** (AD DS) role must be installed on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- The devices in your environment must be domain-joined.

- You must be a member of the **Domain Admins** or **Enterprise Admins** group.

  - If you aren't a member of either the Domain Admins or Enterprise Admins groups, you must have *read* and *write* permissions on the `servicePrincipalName` attribute of the object in AD.

## Manage SPNs

Configuring SPNs in your environment can be performed using an elevated command prompt or elevated PowerShell window. See the following steps in configuring SPNs for your environment.

### Command prompt method

# [Add SPNs](#tab/add)

To add an SPN, run the following command. Replace *service/name* with the SPN you want to add and *hostname* with the host name of the computer object you want to update:

```
setspn -S <service/name> <hostname>
```

For example, if there's an AD DC with the host name server1.contoso.com that requires an SPN for the Lightweight Directory Access Protocol (LDAP), type:

```
setspn -S ldap/server1.contoso.com server1
```

# [View SPNs](#tab/view)

To display the SPNs registered to a computer in AD, run the following command, replacing *hostname* with the name of the computer object you want to query:

```
setspn –L <hostname>
```

> [!TIP]
> To find the host name for a computer from a command prompt, type `hostname`, then press **Enter**.

The following example lists the SPNs of a domain controller (DC) named *WSRV2022* in the *Contoso1.com* domain:

```output
Registered ServicePrincipalNames for CN=WSRV2022,OU=Domain Controllers,DC=contoso1,DC=com:

ldap/WSRV2022.contoso1.com/ForestDnsZones.contoso1.com

ldap/WSRV2022.contoso1.com/DomainDnsZones.contoso1.com

NtFrs-88f5d2bd-b646-11d2-a6d3-00c04fc9b232/WSRV2022.contoso1.com

DNS/WSRV2022.contoso1.com

GC/WSRV2022.contoso1.com/contoso1.com

HOST/WSRV2022.contoso1.com/CONTOSO1

HOST/WSRV2022

HOST/WSRV2022.contoso1.com

HOST/WSRV2022.contoso1.com/contoso1.com

E3514235-4B06-11D1-AB04-00C04FC2DCD2/70906edd-c8a5-4b7d-8198-4f970f7b9f52/contoso1.com

ldap/70906edd-c8a5-4b7d-8198-4f970f7b9f52.\_msdcs.contoso1.com

ldap/WSRV2022.contoso1.com/CONTOSO1

ldap/WSRV2022

ldap/WSRV2022.contoso1.com

ldap/WSRV2022.contoso1.com/contoso1.com
```

The globally unique identifier (GUID) 70906edd-c8a5-4b7d-8198-4f970f7b9f52 identifies the NTDS settings object of the DC, known as the NTDS-DSA, which is unique for each DC. The other two GUIDs, NtFrs-88f5d2bd-b646-11d2-a6d3-00c04fc9b232 and E3514235-4B06-11D1-AB04-00C04FC2DCD2, identify the File Replication Service (NTFRS) and the Directory Replication Service (DRS) remote procedure call (RPC), respectively, and they're standard SPNs for all DCs.

# [Reset SPNs](#tab/reset)

If the SPNs that you see for your server displays what seems to be incorrect names, consider resetting the computer to use the default SPNs. To reset the default SPN values, run the following command where *hostname* is the actual host name of the computer object that you want to update:

```
setspn -R <hostname>
```

Once the SPN is successfully reset, confirmation is provided through the command prompt.

To verify that the SPNs are displaying correctly, type:

```
setspn -L <hostname>
```

# [Remove SPNs](#tab/remove)

To remove an SPN, run the following command. Replace *service/name* with the SPN you want to remove and *hostname* with the host name of the computer object you want to update:

```
setspn -D <service/name> <hostname>
```

For example, to remove an incorrect SPN for a web service on a computer named `Server1.contoso.com`, use the following command:

```
setspn -D http/server1.contoso.com server1
```

---

### PowerShell method

In PowerShell, the `Set-ADUser` cmdlet is used for user accounts and `Set-ADComputer` for the computer name.

# [Add SPNs](#tab/add)

To add an SPN, run the following command. Replace `UserName`, `ComputerName`, and `$spn = " "` with the appropriate values for the user account or computer name:

```powershell
$userID = "UserName"
$spn = "HTTP/webserver.domain.com"

Set-ADUser -Identity $userID -Add @{ServicePrincipalName=$spn}
```

```powershell
$computerID = "ComputerName"
$spn = "HTTP/computerserver.domain.com"

Set-ADComputer -Identity $computerID -Add @{ServicePrincipalName=$spn}
```

# [View SPNs](#tab/view)

To see a list of SPNs from a user account or computer name, run the following command:

```powershell
Get-ADUser -Identity UserName -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName
```

```powershell
Get-ADComputer -Identity ComputerName -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName
```

# [Reset SPNs](#tab/reset)

To remove an SPN from a user account or computer name, run the following command:

```powershell
Set-ADUser -Identity UserName -ServicePrincipalNames @{Replace="NewSPNValue"}
```

```powershell
Set-ADComputer -Identity ComputerName -ServicePrincipalNames @{Replace="NewSPNValue"}
```

# [Remove SPNs](#tab/remove)

To remove an SPN from a user account or computer name, run the following command:

```powershell
Set-ADUser -Identity UserName -ServicePrincipalNames @{Remove="SPNValue"}
```

```powershell
Set-ADComputer -Identity ComputerName -ServicePrincipalNames @{Remove="SPNValue"}
```

---

## Grant SPN permissions to non admins

For users who aren't part of the Domain Admins or Enterprise Admins group, they need the proper permissions to modify the SPNs. Granting these permissions can be performed through Active Directory Users and Computers (ADUC) or PowerShell. See the following steps.

# [ADUC](#tab/aduc)

1. In **Server Manager**, select **Tools**, then select **Active Directory Users and Computers**.

1. Select the **View** tab, then select **Advanced Features**.

1. In the left pane, right-click on the domain where you want to allow a disjoint namespace, then select **Properties**.

1. Select the **Security** tab, select **Advanced**.

1. Under the **Permissions** tab, select **Add**.

1. Select **Select a principal**, under **Enter the object names to select**, type the group or user account name to which you want to delegate permission, then select **OK**.

   To view all available groups and user accounts in your domain, select **Advanced**, then select **Find Now**.

1. Under **Applies to**, select **Descendant Computer objects**.

1. Under **Permissions**, select **Validated write to service principal name** checkbox, then select **OK** on the three open dialog boxes to apply your changes.

# [PowerShell](#tab/powershell)

Run the following command to grant appropriate permissions for the user account or computer name:

```powershell
$userDN = (Get-ADUser -Identity UserName).DistinguishedName

& dsacls.exe $userDN /G "MyDomain\UserName:CA;servicePrincipalName"
```

```powershell
$computerDN = (Get-ADComputer -Identity ComputerName).DistinguishedName

& dsacls.exe $computerDN /G "MyDomain\UserName:CA;servicePrincipalName"
```

---

## See also

- [Service principal names](/windows/win32/ad/service-principal-names)

- [Service Logons Fail Due to Incorrectly Set SPNs](/previous-versions/windows/it-pro/windows-server-2003/cc772897(v=ws.10))

- [SetSPN command reference](/windows-server/administration/windows-commands/setspn)


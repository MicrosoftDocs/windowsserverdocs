---
title: DNSSEC Key Master
description: Learn about how Key Master in Windows DNSSEC is the DNS server responsible for key generation and key management for any DNSSEC-signed zone.
ms.topic: conceptual
ms.author: jgerend
author: JasonGerend
ms.date: 06/01/2023
---

# DNSSEC Key Master

The Domain Name System Security Extensions (DNSSEC) Key Master is a new concept and component of a Windows DNSSEC deployment that was introduced in Windows Server 2012.

In Windows DNSSEC, the Key Master is the DNS server responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, the local server is selected as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a given zone at a time.

The Key Master must be a primary, authoritative server for the zone capable of online zone signing. However, in a Microsoft multi-master Domain Name System (DNS) deployment environment, the following exceptions are possible:

- You can transfer the Key Master role to a different authoritative name server after zone signing. You can easily make this transfer if the current Key Master is online. If the current Key Master is offline, then transferring the role can happen as part of a disaster recovery scenario. For more information, see [Transferring the Key Master role](#transferring-the-key-master-role) and [Seizing the Key Master role](#seizing-the-key-master-role).
- One authoritative server can be the Key Master for multiple zones.
- Different authoritative servers can be Key Masters for different zones.

You can't transfer the Key Master role if a zone is file-backed. File-backed zones have only one primary authoritative DNS server.

> [!IMPORTANT]
> If a zone is Active Directory-integrated, the Key Master is a domain controller and can benefit by enhanced security considerations that are used with domain controllers. If the zone is file-backed, the Key Master might not also be a domain controller. If the Key Master isn't a domain controller, take additional security precautions to protect the Key Master from attack and to protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed to limit its attack surface.

The name of the Key Master displays in DNS Manager when you select **Forward Lookup Zones** or **Reverse Lookup Zones**, and it's displayed on the **Key Master** tab of the DNSSEC properties page. You can also use the **Get-DnsServerDnsSecZoneSetting** Windows PowerShell cmdlet to view the Key Master, as shown in the following example:

```powershell
Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer
```

The Key Master generates all keys for the zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

> [!IMPORTANT]
> You can also assign a Key Master to an unsigned zone. All zones that have ever been signed have a Key Master setting whether they're currently signed or not. A zone that has never been signed typically doesn't have a Key Master, but you can use PowerShell to configure it with a Key Master in preparation for zone signing.

## Transferring the Key Master role

An unsigned zone can also be assigned a Key Master. All zones that have been signed have a Key Master setting, whether they're currently signed or not. A zone that has never been signed typically doesn't have a Key Master, but you can use PowerShell to configure it with a Key Master in preparation for zone signing.

To transfer the Key Master role using DNS Manager:

1. Open DNS Manger and view the DNSSEC properties of the zone.

1. Select the **Key Master** tab.

1. Select **Use the following DNS server as the Key Master**.

1. When you open the drop-down list, a dialog box appears. Select **OK**, choose a server from the list, and then select **OK** again when you're finished.

<!--These images need to be saved to a media folder in this repo and follow the image formatting guidelines in the contributor guide. They also must have alt text.-->

![](RackMultipart20230503-1-ivry2q_html_a2e44bbb5acf0683.png)

![](RackMultipart20230503-1-ivry2q_html_5978b18cedefcd2f.png)

> [!IMPORTANT]
> The signed-in user must have Domain Admins group rights, or equivalent, on a DNS server in order for it to be displayed in the list.

You can also perform this operation using Windows PowerShell by running the **Reset-DnsServerZoneKeyMasterRole** cmdlet, as shown in the following example.

```powershell
Reset-DnsServerZoneKeyMasterRole -ZoneName secure.contoso.com -KeyMasterServer dc2.contoso.com -force
Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer
```

In the previous example, the **Get-DnsServerDnsSecZoneSetting** cmdlet also verifies that the Key Master role transferred successfully.

## Seizing the Key Master role

The server that's designated as the Key Master should be online and highly available to ensure uninterrupted service for key signing operations. If the Key Master goes offline, restoring it to online status is difficult. It's possible to forcibly transfer the Key Master role to another qualifying DNS server using a process called *seizing*. However, we don't recommend using the seizing method to transfer the Key Master role unless it's necessary.

### Private key material

> [!IMPORTANT]
> The Key Master must have access to private key material for a DNSSEC-signed zone. If the current Key Master is offline, other DNS servers might have access to private key material if it's stored in a shared location, such as Active Directory. If private key material isn't stored in Active Directory, and the new Key Master can't access the private keys for a zone through other means, which means the Key Master must generate new keys and re-sign the zones with them. After re-signing with new keys, all trust anchors that exist on other DNS servers will be invalid and must be updated.

To store private key material in Active Directory:

1. Select the **Replicate this private key to all DNS servers authoritative for this zone** check box in KSK settings for all KSKs you use, as shown in the following screenshot.

  <!--Images must be saved to a media folder in this repo and follow the image formatting guidelines in the contributor guide. They also must have alt text.-->

  ![](RackMultipart20230503-1-ivry2q_html_d967ceef7a4ec266.png) 

1. If you don't want to store private key material in Active Directory, you can provide access to private key material using a certificate or hardware storage module (HSM) device. This storage media must be accessible to the DNS server that's selected as the new Key Master.

1. If the private key material isn't stored in Active Directory or an external device, you can run the following PowerShell command to store this material in a certificate on the local computer.

  ```powershell
  MakeCert -ss MS-DNSSEC -sr LocalMachine
  ```

  To use the [MakeCert](https://msdn.microsoft.com/library/windows/desktop/aa386968.aspx) command, you must first download and install the Windows SDK from [https://go.microsoft.com/fwlink/p/?linkid=84091](https://go.microsoft.com/fwlink/p/?linkid=84091).

1. If the new Key Master can't access private key material for the zone, a dialog box appears to tell you private key material isn't accessible and that you need to generate new keys, as shown in the following image.

  <!--Images must be saved to a media folder in this repo and follow the image formatting guidelines in the contributor guide. They also must have alt text.-->

  ![](RackMultipart20230503-1-ivry2q_html_d092dac40daf0fb7.png)

  > [!IMPORTANT]
  > If you select **Yes** and continue seizing the Key Master role, the service won't automatically generate new ZSKs and KSKs for you. In order to generate new keys, you must re-sign the zone so that private key material is available. If trust anchors were distributed for the zone before you seized the role, you must also replace them. If the original Key Master becomes available before the zone is re-signed, you can transfer the Key Master role back to this server without the requirement to re-sign the zone and redistribute trust anchors.

  If the private key material is in Active Directory, you can seize the Key Master role on another primary, authoritative Active Directory-integrated DNS server and have full access to private key material. In this case, you don't need to replace the signing keys (ZSKs and KSKs).

1. If you use DNS Manager to access an Active Directory-integrated authoritative DNS server with a primary copy of the zone when the Key Master is offline, a notification appears when you view DNSSEC properties of the zone. The dialog box tells you that the service can't load the DNSSEC settings, as shown in the following screenshot.

  <!--Images must be saved to a media folder in this repo and follow the image formatting guidelines in the contributor guide. They also must have alt text.-->

  ![](RackMultipart20230503-1-ivry2q_html_3ce7c487e3eb9ba1.png)

  If you see this dialog, you need to load the DNSSEC settings with the local server by selecting **OK**. The settings that load are the same settings configured during the last successful replication.

1. In the **Key Master** tab, you can choose a new Key Master from a list of available DNS servers, similar to the procedure described in [Transferring the Key Master role](#transferring-the-key-master-role).

1. After you choose a new Key Master, select **OK**. A a dialog box appears with information about the changes to be made.

1. Select **OK** again to proceed with the seizing operation. Another dialog box appears to show the status of the role transfer, as shown in the following screenshots.

  <!--Images must be saved to a media folder in this repo and follow the image formatting guidelines in the contributor guide. They also must have alt text.-->

  ![](RackMultipart20230503-1-ivry2q_html_f1825d7cc6d3626d.png)

  ![](RackMultipart20230503-1-ivry2q_html_3cf61127949b5a69.png)

Information about the new Key Master replicates in Active Directory to all primary DNS servers. After seizing the Key Master role on another server, if the old Key Master comes online, it detects that it's no longer the Key Master, which means you don't need to configure any other settings.

## Next steps

<!--Did you forget to put something here?--->

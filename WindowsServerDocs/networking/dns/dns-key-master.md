---
title: dnssec key master
description: Learn about how Key Master in Windows DNSSEC is the DNS server responsible for key generation and key management for any DNSSEC-signed zone.
ms.topic: conceptual
ms.author: jgerend
author: JasonGerend
ms.date: 06/01/2023
---

# DNSSEC Key Master

The DNSSEC Key Master is a new concept and component of a Windows DNSSEC deployment that was introduced in Windows Server 2012.

In Windows DNSSEC, the Key Master is the DNS server that is responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, the local server is selected as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a given zone at a given time.

The Key Master must be a primary, authoritative server for the zone capable of online zone signing. However, in a Microsoft multi-master DNS deployment environment, the following is possible:

- The Key Master role can be transferred to a different authoritative name server after zone signing. This transfer can be performed easily if the current Key Master is online. If the current Key Master is offline, transfer can be performed as part of a disaster recovery scenario. For more information, see [Transferring the Key Master role](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593674(v=ws.11)) and [Seizing the Key Master role](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593674(v=ws.11)) later in this article.
- One authoritative server can be the Key Master for multiple zones.
- Different authoritative servers can be Key Masters for different zones.

You can't transfer the Key Master role if a zone is file-backed. File-backed zones have only one primary authoritative DNS server.

    > [!IMPORTANT]
    > If a zone is Active Directory-integrated, the Key Master is a domain controller and can benefit by enhanced security considerations that are used with domain controllers. If the zone is file-backed, the Key Master might not also be a domain controller. If the Key Master isn't a domain controller take additional security precautions to protect the Key Master from attack and to protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed to limit its attack surface.

The name of the Key Master is displayed in DNS Manager when you click  **Forward Lookup Zones**  or  **Reverse Lookup Zones** , and it's displayed on the  **Key Master**  tab of the DNSSEC properties page. You can also use the  **Get-DnsServerDnsSecZoneSetting**  Windows PowerShell cmdlet to view the Key Master. See the following example:

``

PS C:\\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer

KeyMasterServer

---------------

DC1.contoso.com

``

The Key Master generates all keys for the zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

    > [!IMPORTANT]
    > An unsigned zone can also be assigned a Key Master. All zones that have been signed have a Key Master setting, whether they are currently signed or not. A zone that has never been signed typically doesn't have a Key Master but can be configured with a Key Master in preparation for zone signing with Windows PowerShell.

## Transferring the Key Master role

If the Key Master is online, you can readily transfer the Key Master role to another DNS server. Another qualifying DNS server must be available on the network.

To transfer the Key Master role using DNS Manager, view the DNSSEC properties of the zone, click the  **Key Master**  tab, and then choose  **Use the following DNS server as the Key Master**. When you click the drop-down list, a pop-up alert asks if you want the local server to build a list of available, qualifying DNS servers that can be the Key Master. Click  **OK** , choose a server from the list, and then click  **OK**. See the following examples:

![](RackMultipart20230503-1-ivry2q_html_a2e44bbb5acf0683.png)

![](RackMultipart20230503-1-ivry2q_html_5978b18cedefcd2f.png)

    > [!IMPORTANT]
    > The signed-in user must have Domain Admins group rights, or equivalent, on a DNS server in order for it to be displayed in the list.

You can also perform this operation using Windows PowerShell with the  **Reset-DnsServerZoneKeyMasterRole**  cmdlet. See the following example.

``

PS C:\\> Reset-DnsServerZoneKeyMasterRole -ZoneName secure.contoso.com -KeyMasterServer dc2.contoso.com -force

PS C:\\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer

KeyMasterServer

---------------

DC2.contoso.com

``

In this example, the  **Get-DnsServerDnsSecZoneSetting**  cmdlet is also used to verify that the Key Master role was transferred successfully.

## Seizing the Key Master role

The server that's designated as the Key Master should be online and highly available to ensure uninterrupted service for key signing operations. If the Key Master goes offline it can't easily be restored to online status. It's possible to forcibly transfer the Key Master role to another qualifying DNS server using a process called seizing. Don't seize the Key Master role unless it is unavoidable. An easy online transfer of the Key Master role is always preferred.

### Private key material

    > [!IMPORTANT]
    > The Key Master must have access to private key material for a DNSSEC-signed zone. If the current Key Master is offline, other DNS servers might have access to private key material if it's stored in a shared location such as Active Directory. If private key material isn't stored in Active Directory, and the new Key Master can't access the private keys for a zone through other means, then new keys must be generated, and the zone must be re-signed with these new keys. After re-signing with new keys, all trust anchors that exist on other DNS servers will be invalid and must be updated.

To store private key material in Active Directory, select the  **Replicate this private key to all DNS servers authoritative for this zone**  check box in KSK settings for all KSKs that are used. See the following example.

![](RackMultipart20230503-1-ivry2q_html_d967ceef7a4ec266.png) 

If you don't want to store private key material in Active Directory, you might also be able to provide access to private key material using a certificate or hardware storage module (HSM) device. This storage media must be accessible to the DNS server that's selected as the new Key Master.

If private key material isn't stored in Active Directory or an external device, you can use the following command to store this material in a certificate on the local computer.

``

MakeCert -ss MS-DNSSEC -sr LocalMachine

``

To use the [MakeCert](https://msdn.microsoft.com/library/windows/desktop/aa386968.aspx) command, you must first download and install the Windows SDK from [https://go.microsoft.com/fwlink/p/?linkid=84091](https://go.microsoft.com/fwlink/p/?linkid=84091).

If the new Key Master cannot access private key material for the zone, a notification is displayed that indicates that private key material isn't accessible and that new keys must be generated. See the following example.

![](RackMultipart20230503-1-ivry2q_html_d092dac40daf0fb7.png)

    > [!IMPORTANT]
    > If you click  **Yes**  and continue seizing the Key Master role, new ZSKs and KSKs are not automatically generated. You must re-sign the zone so that private key material is available. If trust anchors were distributed for the zone, these trust anchors must also be replaced. If the original Key Master becomes available before the zone is re-signed, you can transfer the Key Master role back to this server without the requirement to re-sign the zone and redistribute trust anchors.
If private key material is stored in Active Directory, you can seize the Key Master role on another primary, authoritative Active Directory-integrated DNS server and have full access to private key material. In this case, the signing keys (ZSKs and KSKs) don't have to be replaced.

If you use DNS Manager to access an Active Directory-integrated authoritative DNS server with a primary copy of the zone when the Key Master is offline, a notification is displayed when you view DNSSEC properties of the zone, which indicates that DNSSEC settings couldn't be loaded. See the following example.

![](RackMultipart20230503-1-ivry2q_html_3ce7c487e3eb9ba1.png)

Select  **OK**  to load DNSSEC settings using the local server. These settings will be the settings that were configured during the last successful replication.

On the  **Key Master**  tab, you can choose a new Key Master from a list of available DNS servers, similar to the procedure that's used for routine transfer of the Key Master role, described earlier in this topic.

After choosing a new Key Master, select  **OK**. A notification is displayed with information about the changes to be made. Click  **OK**  again to proceed with the seizing operation. Another notification is displayed with the status of the role transfer. See the following examples:

![](RackMultipart20230503-1-ivry2q_html_f1825d7cc6d3626d.png)

![](RackMultipart20230503-1-ivry2q_html_3cf61127949b5a69.png)

Information about the new Key Master replicates in Active Directory to all primary DNS servers. After seizing the Key Master role on another server, if the old Key Master comes online, it detects that it is no longer the Key Master. You do not have to modify settings further.

## Related links
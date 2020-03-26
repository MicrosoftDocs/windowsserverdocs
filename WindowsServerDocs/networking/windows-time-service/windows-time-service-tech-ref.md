---
ms.assetid: e34622ff-b2d0-4f81-8d00-dacd5d6c215e
title: Windows Time Service Technical Reference
description: The W32Time service provides network clock synchronization for computers without the need for extensive configuration. The W32Time service is essential to the successful operation of Kerberos V5 authentication and, therefore, to AD DS-based authentication.
author: eross-msft
ms.author: dacuo
ms.date: 05/08/2018
ms.topic: article
ms.prod: windows-server
ms.technology: networking
---

# Windows Time Service Technical Reference
>Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10 or later

The W32Time service provides network clock synchronization for computers without the need for extensive configuration. The W32Time service is essential to the successful operation of Kerberos V5 authentication and, therefore, to AD DS-based authentication. Any Kerberos-aware application, including most security services, relies on time synchronization between the computers that are participating in the authentication request. AD DS domain controllers must also have synchronized clocks to help to ensure accurate data replication.

> [!NOTE]  
> In Windows Server 2003 and Microsoft Windows 2000 Server, the directory service is named Active Directory directory service. In  Windows Server 2008 R2  and  Windows Server 2008 , the directory service is named Active Directory Domain Services (AD DS). The rest of this topic refers to AD DS, but the information is also applicable to Active Directory Domain Services in Windows Server 2016.

The W32Time service is implemented in a dynamic link library called W32Time.dll, which is installed by default in **%Systemroot%\System32**. W32Time.dll was originally developed for Windows 2000 Server to support a specification by the Kerberos V5 authentication protocol that required clocks on a network to be synchronized. Starting with Windows Server 2003, W32Time.dll provided increased accuracy in network clock synchronization over the Windows Server 2000 operating system. Additionally, in Windows Server 2003, W32Time.dll supported a variety of hardware devices and network time protocols using time providers.

Although originally designed to provide clock synchronization for Kerberos authentication, many current applications use timestamps to ensure transactional consistency, record the time of important events, and other business-critical, time-sensitive information.  These applications benefit from time synchronization between computers that are provided by the Windows Time service.

## Importance of Time Protocols
Time protocols communicate between two computers to exchange time information and then use that information to synchronize their clocks. With the Windows Time service time protocol, a client requests time information from a server and synchronizes its clock based on the information that is received.
  
The Windows Time service uses NTP to help synchronize time across a network. NTP is an Internet time protocol that includes the discipline algorithms necessary for synchronizing clocks. NTP is a more accurate time protocol than the Simple Network Time Protocol (SNTP) that is used in some versions of Windows; however, W32Time continues to support SNTP to enable backward compatibility with computers running SNTP-based time services such as Windows 2000.
## Where to find Windows Time service configuration-related information  
This guide does **not** discuss configuring the Windows Time service. There are several different topics on Microsoft TechNet and in the Microsoft Knowledge Base that do explain procedures for configuring the Windows Time service. If you require configuration information, the following topics should help you locate the appropriate information.  
-   To configure the Windows Time service for the forest root primary domain controller (PDC) emulator, see:
  
    -   [Configure the Windows Time service on the PDC emulator in the Forest Root Domain](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731191%28v=ws.10%29) 
  
    -   [Configuring a time source for the forest](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc794823%28v%3dws.10%29) 
  
    -   Microsoft Knowledge Base article 816042, [How to configure an authoritative time server in Windows Server](https://go.microsoft.com/fwlink/?LinkID=60402), which describes configuration settings for computers running Windows Server 2008 R2, Windows Server 2008, Windows Server 2003, and Windows Server 2003 R2.  
  
-   To configure the Windows Time service on any domain member client or server, or even domain controllers that are not configured as the forest root PDC emulator, see [Configure a client computer for automatic domain time synchronization](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc816884%28v%3dws.10%29).  
  
    > [!WARNING]  
    > Some applications may require their computers to have high-accuracy time services. If that is the case, you may choose to configure a manual time source, but be aware that the Windows Time service was not designed to function as a highly accurate time source. Ensure that you are aware of the support limitations for high-accuracy time environments as described in Microsoft Knowledge Base article 939322, [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md).  
  
-   To configure the Windows Time service on any Windows-based client or server computers that are configured as workgroup members instead of domain members see [Configure a manual time source for a selected client computer](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc816656%28v%3dws.10%29).  
  
-   To configure the Windows Time service on a host computer that runs a virtual environment, see Microsoft Knowledge Base article 816042, [How to configure an authoritative time server in Windows Server](https://go.microsoft.com/fwlink/?LinkID=60402). If you are working with a non-Microsoft virtualization product, be sure to consult the documentation of the vendor for that product.  
  
-   To configure the Windows Time service on a domain controller that is running in a virtual machine, it is recommended that you partially disable time synchronization between the host system and guest operating system acting as a domain controller. This enables your guest domain controller to synchronize time for the domain hierarchy, but protects it from having a time skew if it is restored from a Saved state. For more information, see Microsoft Knowledge Base article 976924, [You receive Windows Time Service event IDs 24, 29, and 38 on a virtualized domain controller that is running on a Windows Server 2008-based host server with Hyper-V](https://go.microsoft.com/fwlink/?LinkID=192236) and [Deployment Considerations for Virtualized Domain Controllers](https://go.microsoft.com/fwlink/?LinkID=192235).  
  
-   To configure the Windows Time service on a domain controller acting as the forest root PDC emulator that is also running in a virtual computer, follow the same instructions for a physical computer as described in [Configure the Windows Time service on the PDC emulator in the Forest Root Domain](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731191%28v=ws.10%29).  
  
-   To configure the Windows Time service on a member server running as a virtual computer, use the domain time hierarchy as described in [Configure a client computer for automatic domain time synchronization](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc816884%28v%3dws.10%29).


> [!IMPORTANT]  
> Prior to Windows Server 2016, the W32Time service was not designed to meet time-sensitive application needs.  However, updates to Windows Server 2016 now allow you to implement a solution for 1ms accuracy in your domain.  For more information about, see  [Windows 2016 Accurate Time](accurate-time.md) and [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md) for more information.

## Related topics
- [Windows 2016 Accurate Time](accurate-time.md)
- [Time Accuracy Improvements for Windows Server 2016](windows-server-2016-improvements.md)  
- [How the Windows Time Service Works](How-the-Windows-Time-Service-Works.md)  
- [Windows Time Service Tools and Settings](Windows-Time-Service-Tools-and-Settings.md)  
- [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md)
- [Microsoft Knowledge Base article 902229](https://go.microsoft.com/fwlink/?LinkId=186066)

---
title: AD Forest Recovery - Redeploy remaining DCs  
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adds
---
# AD Forest Recovery - Redeploy remaining DCs

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

The steps up to this point apply to all forests: find a valid backup for each domain, recover the domains in isolation, reconnect them, reset the global catalog, and clean up. In this next step you will redeploy the forest. The way to do this will greatly depend on your forest design, your service level agreements, site structure, available bandwidth, and numerous other factors. You will need to design your own redeployment plan based on the principles and suggestions in this section, in a way that is best suited to your business requirements.  
  
The next step is to install AD DS on all DCs that were present before the forest recovery took place. If the DCs still exist, the AD DS service will need to be removed forcibly, or the DCs can be reinstalled. Any existing backups for these DCs cannot be reused, because the corresponding metadata has been removed during forest recovery. In an uncomplicated environment this redeployment process can be as simple as reconnecting the recovered DCs to the production network, and promoting new DCs as needed.  
  
In a large enterprise faced with a worldwide infrastructure, a more sophisticated plan is needed. The first phase is usually to restore the AD as a service; this means to install strategically placed DCs such that all critical business divisions and applications can start working again. It may be acceptable for branch offices to temporarily have reduced performance as a result of this. As a second phase, all remaining and less critical DCs are redeployed.  
  
 There are two methods to install additional DCs, both of which can be automated:  
  
- Cloning  
   - For virtualized environments that run Windows Server 2012, cloning is the fastest and simplest way to recover a large number of DCs. You can automate the recovery of all virtualized DCs in a domain after you restore a single virtualized DC from backup.  
   - For more information about cloning and prerequisites, see [Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)](https://technet.microsoft.com/library/hh831734.aspx).  
- Re-install AD DS by using Windows PowerShell on servers that run Windows Server 2012 (or Dcpromo.exe on servers that run earlier versions of Windows Server) or by using the user interface  
   - To expedite re-installing AD DS, you can use Install from Media (IFM) option to reduce replication traffic during the installation. For more information about using the **ntdsutil ifm** command to create installation media, see [Installing AD DS from Media](https://technet.microsoft.com/library/cc770654\(WS.10\).aspx).  

Consider the following additional points for each replica DC that is recovered in the forest by virtualized DC cloning or by installing AD DS (as opposed to restoring from backup):  
  
- All software on a DC that is used as the source for cloning must be able to be cloned. Applications and services that cannot be cloned should be removed before cloning is initiated. If that is not possible, an alternative virtualized DC should be chosen as the source.  
- If you clone additional virtualized DCs from the first virtualized DC to be restored, the source DC will need to be shut down while its VHDX file is copied. Then it will need to be running and available online when the clone virtual DCs are first started. If the downtime required by the shutdown is not acceptable for the first recovered DC, deploy an additional virtualized DC by installing AD DS to act as the source for cloning.  
- There is no restriction on the host name of the cloned virtualized DC or the server on which you want to install AD DS. You can use a new host name or the host name that was in use previously. For more information about DNS host name syntax, see [Creating DNS Computer Names](https://technet.microsoft.com/library/cc785282.aspx) ([https://go.microsoft.com/fwlink/?LinkId=74564](https://go.microsoft.com/fwlink/?LinkId=74564)).  
- Configure each server with the first DNS server in the forest (the first DC that was restored in the root domain) as the preferred DNS server in the TCP/IP properties of its network adapter. For more information, see [Configure TCP/IP to use DNS](https://technet.microsoft.com/library/cc779282.aspx).  
- Redeploy all RODCs in the domain, either by virtualized DC cloning if several RODCs are deployed in a central location, or by the traditional method of rebuilding them by removing and reinstalling AD DS if they are deployed individually in isolated located locations such as branch offices.  
   - Rebuilding RODCs ensures that they do not contain any lingering objects and can help prevent replication conflicts from occurring later. When you remove AD DS from an RODC, *choose the option to retain DC metadata*. Using this option retains the krbtgt account for the RODC and retains the permissions for the delegated RODC administrator account and the Password Replication Policy (PRP), and prevents you from having to use Domain Admin credentials to remove and reinstall AD DS on an RODC. It also retains the DNS server and global catalog roles if they are installed on the RODC originally.  
   - When you rebuild DCs (RODCs or writeable DCs), there may be increased replication traffic during their reinstallation. To help reduce that impact, you can stagger the schedule of the RODC installations, and you can use the Install From Media (IFM) option. If you use the IFM option, run the **ntdsutil ifm** command on a writeable DC that you trust to be free of damaged data. This helps prevent possible corruption from appearing on the RODC after the AD DS reinstallation is complete. For more information about IFM, see [Installing AD DS from Media](https://technet.microsoft.com/library/cc770654\(WS.10\).aspx).  
   - For more information about rebuilding RODCs, see [RODC Removal and Reinstallation](https://technet.microsoft.com/library/cc835490\(WS.10\).aspx).  
- If a DC was running the DNS Server service before the forest malfunction, install and configure the DNS Server service during the installation of AD DS. Otherwise, configure its former DNS clients with other DNS servers.  
- If you require additional global catalogs to share authentication or query load for users or applications, you can either add the global catalog to the source virtualized DC before cloning or you can make a DC a global catalog server during the installation of AD DS.  
  
## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md)

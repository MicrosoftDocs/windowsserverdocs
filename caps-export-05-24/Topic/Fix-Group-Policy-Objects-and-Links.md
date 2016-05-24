---
title: Fix Group Policy Objects and Links
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 501803ab-a896-461f-baf7-951d2784efa6
author: Femila
---
# Fix Group Policy Objects and Links
  You can use this procedure to fix Group Policy objects \(GPOs\) and links after a domain rename operation. In this procedure, you use the Gpfixup.exe command\-line tool to repair GPOs as well as GPO references in each renamed domain. It is necessary to repair the GPOs and the Group Policy links after a domain rename operation to update the old domain name that is embedded in these GPOs and their links. This procedure is necessary so that Group Policy continues to function normally in the new forest after the domain rename operation is complete. The Gpfixup.exe tool also repairs any Group Policy–based Software Installation and Maintenance data \(such as Software Distribution Point network paths\), if they are present in Active Directory Domain Services \(AD DS\), so that managed software deployment continues to work in your environment. The GPO and link fix\-up tool must be run once in each renamed domain. There is no GPO and link fix\-up required that corresponds to renamed application directory partitions because you cannot apply Group Policy to an application directory partition.  
  
> [!IMPORTANT]  
>  The GPO\/link fix\-up procedure does not fix any interdomain GPO links that might exist in your forest. Any existing interdomain GPO links must be either removed or reconfigured so that they can work properly. In addition, this fix\-up procedure does not repair network paths for Software Distribution Points \(present in AD DS\) that are external to the domain. As a best practice, do not use GPO links that cross domain boundaries.  
  
 Before you repair GPOs, ensure that the following conditions are satisfied:  
  
-   All procedures that are described in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md), that include the automatic domain controller restart, must have been completed on all domain controllers in the renamed domains.  
  
-   The domain controller with the primary domain controller \(PDC\) emulator operations master role in a renamed domain must have successfully completed the domain rename operation, and it must have reached the final "Done" state as described in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md).  
  
-   The control station computer must have been restarted twice, as described in [Unfreeze the Forest Configuration](../Topic/Unfreeze-the-Forest-Configuration.md).  
  
-   All member servers in the domain that host Software Distribution Points \(network locations from which users deploy managed software in your environment\) must have been restarted twice, as described in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md). This prerequisite step is extremely important and necessary for the Software Installation and Maintenance data fix\-up to work correctly.  
  
 Membership in the **Enterprise Admins** group in the target forest is the minimum required to complete these procedures. The access check that you perform in this procedure requires that you have write access to the **gpLink** attribute on the site, domain, and organizational unit \(OU\) objects, as well as write access to the GPOs themselves.  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **gpfixup**, as described in [Appendix B: Command-Line Syntax for the Gpfixup Tool](../Topic/Appendix-B--Command-Line-Syntax-for-the-Gpfixup-Tool.md).  
  
### To fix up GPOs and GPO references  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  From within the working directory, type the following command, and then press ENTER. The entire command must be typed on a single line, although it is shown on multiple lines for clarity.  
  
    ```  
    gpfixup /olddns:OldDomainDnsName   
            /newdns:NewDomainDNSName  
            /oldnb:OldDomainNetBIOSName  
            /newnb:NewDomainNetBIOSName  
            /dc:DcDnsName 2>&1 >gpfixup.log  
    ```  
  
    > [!NOTE]  
    >  The command\-line parameters `/oldnb` and `/newnb` are required only if the NetBIOS name of the domain changed. Otherwise, you can omit these parameters from the command line for `Gpfixup`.  
  
     The output of the command—both status or error output—is saved to the file Gpfixup.log, which you can display periodically to monitor the progress of the command.  
  
4.  To force replication of the Group Policy fix\-up changes that are made at the domain controller that is named in `DcDNSName` in step 3 of this procedure to the rest of the domain controllers in the renamed domain, type the following command, and then press ENTER:  
  
    ```  
    repadmin /syncall /d /e /P /q DcDnsName NewDomainDN   
    ```  
  
     Where:  
  
    -   `DcDnsName` is the Domain Name System \(DNS\) host name of the domain controller that was targeted by the `gpfixup` command.  
  
    -   `NewDomainDN` is the distinguished name that corresponds to the new DNS name of the renamed domain.  
  
5.  Repeat steps 2 and 3 in this procedure for every renamed domain. You can enter the commands in sequence for each renamed domain.  
  
     For example, using the sample forest and domain name changes in [Specify the New Forest Description](../Topic/Specify-the-New-Forest-Description.md), you run the **gpfixup** command twice—once for the renamed cohovineyard.com domain and once for the sales.cohovineyard.com domain, as indicated in the following example:  
  
    ```  
    gpfixup /olddns:cohovineyard.com  /newdns:cohowinery.com  
    /oldnb:cohovineyard  /newnb:cohowinery  
    /dc:dc1.cohovineyard.com  2>&1 >gpfixup1.log  
    repadmin /syncall /d /e /P /q dc1.cohovineyard.com dc=cohowinery,dc=com  
    gpfixup /olddns:sales.cohovineyard.com  /newdns:sales.cohowinery.com    
    /dc:dc3.sales.cohovineyard.com  2>&1 >gpfixup2.log  
    repadmin /syncall /d /e /P /q dc3.sales.cohovineyard.com  
    dc=sales,dc=cohowinery,dc=com  
    ```  
  
    > [!IMPORTANT]  
    >  Run the **gpfixup** command only once for each renamed domain. Do not run it for renamed application directory partitions.  
  
    > [!NOTE]  
    >  The DNS host names for the domain controllers in the renamed domains that are used in these command invocations still reflect the old DNS name for the domain. As mentioned earlier, the DNS host name of a domain controller in a renamed domain does not change automatically as a result of the domain name change.  
  
|Parameter|Description|  
|---------------|-----------------|  
|gpfixup|Fixes domain name dependencies in Group Policy objects and Group Policy links after a domain rename operation.|  
|\/olddns:OldDomainDnsName|Specifies the old DNS name of the renamed domain.|  
|\/newdns:NewDomainDNSName|Specifies the new DNS name of the renamed domain.|  
|\/oldnb:OldDomainNetBIOSName|Specifies the old NETBIOS name of the renamed domain.|  
|\/newnb:NewDomainNetBIOSName|Specifies the new NETBIOS name of the renamed domain.|  
|\/dc:DcDnsName 2\>&1 \>gpfixup.log|Contains status or error output of the command.|  
  
  
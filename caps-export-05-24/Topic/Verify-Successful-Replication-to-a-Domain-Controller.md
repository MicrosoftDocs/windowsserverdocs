---
title: Verify Successful Replication to a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7701b515-568c-427a-b32d-2ccde31b2894
author: Femila
---
# Verify Successful Replication to a Domain Controller
    
> [!TIP]  
>  This topic explains how to use Repadmin.exe to verify replication and format the command output using Microsoft Excel. Repadmin.exe is installed  on all domain controllers that run Windows Server 2008 or later and can be run from an elevated command prompt. For a UI\-based alternative, you can run the [Active Directory Replication Status Tool \(ADREPLSTATUS\)](http://www.microsoft.com/download/details.aspx?id=30005) to check replication status of domain controllers. ADREPLSTATUS displays output in a similar format but with significant improvements.  
  
 You can use the **repadmin \/showrepl** command to verify successful replication to a specific domain controller. If you are not running Repadmin on the domain controller whose replication you are checking, you can specify a destination domain controller in the command. Repadmin lists **INBOUND NEIGHBORS** for the current or specified domain controller. **INBOUND NEIGHBORS** shows the distinguished name of each directory partition for which inbound directory replication has been attempted, the site and name of the source domain controller, and whether replication succeeded or not, as follows:  
  
-   `Last attempt @ <YYYY-MM-DD HH:MM.SS> was successful.`  
  
-   `Last attempt @ [Never] was successful.`  
  
 If `@ [Never]` appears in the output for a directory partition, replication of that directory partition has never succeeded from the identified source replication partner over the listed connection.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify successful replication to a domain controller  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /showrepl <servername> /u:<domainname>\<username> /pw:*`  
  
    > [!NOTE]  
    >  The user credential parameters \(`/u:<domainname>\<username> /pw:*`\) are not required for the domain of the user if the user has opened the Command Prompt as an administrator with Domain Admins credentials or is logged on to the domain controller as a member of Domain Admins or equivalent. However, if you run the command for a domain controller in a different domain in the same Command Prompt session, you must provide credentials for an account in that domain.  
  
    |Value|Description|  
    |-----------|-----------------|  
    |repadmin \/showrepl|Displays the replication status for the last time that the domain controller that is named in \<servername\> attempted inbound replication of Active Directory partitions.|  
    |\<servername\>|The name of the destination domain controller.|  
    |\/u:|Specifies the domain name and user name, separated by a backslash, for a user who has permissions to perform operations in AD DS.|  
    |\<domainname\>|The single\-label name of the domain of the destination domain controller. \(You do not have to use a fully qualified Domain Name System \(DNS\) name.\)|  
    |\<username\>|The name of an administrative account in that domain.|  
    |\/pw:\*|Specifies the domain password for the user named in \<username\>. \* provides a **Password:** prompt when you press ENTER.|  
  
3.  At the **Password:** prompt, type the password for the user account that you provided, and then press ENTER.  
  
 You can also use **repadmin** to generate the details of replication to and from all replication partners in a Microsoft Excel spreadsheet. The spreadsheet displays data in the following columns:  
  
 **Showrepl\_COLUMNS**  
  
 **Destination DC Site**  
  
 **Destination DC**  
  
 **Naming Context**  
  
 **Source DC Site**  
  
 **Source DC**  
  
 **Transport Type**  
  
 **Number of Failures**  
  
 **Last Failure Time**  
  
 **Last Success Time**  
  
 **Last Failure Status**  
  
 The following procedure creates this spreadsheet and sets column headings for improved readability.  
  
### To generate a repadmin \/showrepl spreadsheet for all replication partners  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /showrepl * /csv >showrepl.csv`  
  
3.  Open Excel.  
  
4.  Click the **Office** button, click **Open**, navigate to **showrepl.csv**, and then click **Open**.  
  
5.  Hide or delete column **A** as well as the **Transport Type** column, as follows:  
  
6.  Select a column that you want to hide or delete.  
  
    -   To hide the column, right\-click the column, and then click **Hide**.  
  
         Or  
  
    -   To delete the column, right\-click the selected column, and then click **Delete**.  
  
7.  Select row 1 beneath the column heading row. On the **View** tab, click **Freeze Panes**, and then click **Freeze Top Row**.  
  
8.  Select the entire spreadsheet. On the **Data** tab, click **Filter**.  
  
9. In the **Last Success Time** column, click the down arrow, and then click **Sort Ascending**.  
  
10. In the **Source DC** column, click the filter down arrow, point to **Text Filters**, and then click **Custom Filter**.  
  
11. In the **Custom AutoFilter** dialog box, under **Show rows where**, click **does not contain**. In the adjacent text box, type **del** to eliminate from view the results for deleted domain controllers.  
  
12. Repeat step 11 for the **Last Failure Time** column, but use the value **does not equal**, and then type the value **0**.  
  
13. Resolve replication failures.  
  
 The last successful attempt should agree with the replication schedule for intersite replication, or the attempt should be within the last hour for intrasite replication.  
  
 If Repadmin reports any of the following conditions, see Troubleshooting Active Directory Replication Problems \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93582](http://go.microsoft.com/fwlink/?LinkID=93582)\):  
  
-   The last successful intersite replication was before the last scheduled replication.  
  
-   The last intrasite replication was longer than one hour ago.  
  
-   Replication was never successful.  
  
  
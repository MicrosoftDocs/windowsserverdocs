---
title: Turn on Inbound Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a2243be1-5d61-4302-902f-5c3c230686d3
author: Femila
---
# Turn on Inbound Replication
  You can use the **repadmin** command\-line tool in this procedure to turn on inbound Active Directory replication after it has been turned off manually.  
  
 You can manage the inbound replication state by setting a **repadmin** option to change the value in **DISABLE\_INBOUND\_REPL**. You change the state by using a plus \(**\+**\) to enable the disabled state \(turn off inbound replication\) and a minus \(**–**\) to disable \(reverse\) the disabled state \(turn on inbound replication\). When you apply the option, the command output confirms only that the **DISABLE\_INBOUND\_REPL** option is either new or current. It does not indicate “on” or “off.”  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To turn on inbound replication  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if requested, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /options <ServerName> -DISABLE_INBOUND_REPL`  
  
     Where `<ServerName>` is the NetBIOS name of the domain controller.  
  
3.  Verify that the DISABLE\_INBOUND\_REPL option is not in effect. The following message should appear:  
  
     `Current DSA options: DISABLE_INBOUND_REPL`  
  
     `New DSA Options: <none>`  
  
     `Current DSA Options` displays the conditions that were in effect at the time that you ran the command. `New DSA Options` shows the effect of the command, which is that the `DISABLE_INBOUND_REPL` option is not in effect \(does not appear\).  
  
## Additional references  
  
-   [Turn Off Inbound Replication](../Topic/Turn-Off-Inbound-Replication.md)  
  
  
---
title: Turn Off Inbound Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 962cb10f-2eba-4b23-8589-721d72a3a9d0
author: Femila
---
# Turn Off Inbound Replication
  You can use this procedure and the **repadmin** command to turn off inbound replication so that Active Directory objects on a domain controller cannot be updated by replication from another domain controller.  
  
 You can manage the inbound replication state by setting a **repadmin** option to change the value in **DISABLE\_INBOUND\_REPL**. You change the state is by using a plus \(**\+**\) to enable the disabled state \(turn off inbound replication\) and a minus \(**–**\) to disable \(reverse\) the disabled state \(turn on inbound replication\). When you apply the option, the command output confirms only that the **DISABLE\_INBOUND\_REPL** option is either new or current. It does not indicate “on” or “off.”  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To turn off inbound replication  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if requested, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /options <ServerName> +DISABLE_INBOUND_REPL`  
  
     where `<ServerName>` is the NetBIOS name of the domain controller.  
  
3.  Verify that the `DISABLE_INBOUND_REPL` option is in effect. The following message should appear:  
  
     `Current DSA options: <Whatever options are set>`  
  
     `New DSA Options: DISABLE_INBOUND_REPL`  
  
     `Current DSA Options` displays the conditions that were in effect at the time that you ran the command. `New DSA Options` shows the effect of the command, which is that the `DISABLE_INBOUND_REPL` option is now in effect.  
  
## Additional references  
  
-   [Turn on Inbound Replication](../Topic/Turn-on-Inbound-Replication.md)  
  
  
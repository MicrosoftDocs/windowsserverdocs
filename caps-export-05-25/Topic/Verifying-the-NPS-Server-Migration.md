---
title: Verifying the NPS Server Migration
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bfc55d7-2c34-4e8a-a5df-475b5964fae9
---
# Verifying the NPS Server Migration
After the migration of your Network Policy Server \(NPS\) server is complete, you can perform some tasks to verify that the migration was successful.  
  
## Verifying NPS Migration  
To verify the functionality of NPS on the destination server, confirm that the service is running, that the correct configuration was migrated, and that client computers can authenticate successfully.  
  
#### To verify NPS migration  
  
1.  To verify that the NPS service is running on the destination server, type the following command at an elevated command prompt on the destination server and then press ENTER.  
  
    ```  
    sc query ias  
  
    ```  
  
    In the command output, verify that **RUNNING** is displayed next to **STATE**.  
  
2.  To verify that the source NPS configuration has been migrated to the destination server, type the following command at an elevated command prompt on the destination server and then press ENTER:  
  
    ```  
    netsh nps show config  
    ```  
  
    Verify that the destination server is not using default NPS settings. For example, default settings display a single policy under **Connection request policy configuration** with the name **Use Windows authentication for all users**.  
  
3.  To verify that the NPS console on the destination server displays the correct settings, type the following command at an elevated command prompt on the destination server and then press ENTER:  
  
    ```  
    nps.msc  
    ```  
  
    1.  The NPS console will open. In the console tree, click **Accounting**, click **Change SQL Server Logging Properties**, click **Configure**, and verify that the correct settings are displayed on the **Connection** and **Advanced** tabs.  
  
    2.  In the NPS console tree, click **Policies** and then click **Connection Request Policies**, **Network Policies**, and **Health Policies**. For each type of policy, verify that the correct policies are displayed.  
  
    3.  In the NPS console tree, click **RADIUS Clients and Servers** and then click **RADIUS Clients and Remote RADIUS Server Groups**. Verify that the correct RADIUS clients and remote RADIUS server groups are displayed.  
  
    4.  In the NPS console tree, click **Network Access Protection**, and then click **System Health Validators** and **Remediation Server Groups**. Verify that the correct Network Access Protection \(NAP\) related settings are displayed.  
  
    5.  In the NPS console tree, click **Templates Management**. If the source server was running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], verify that the correct templates settings are displayed.  
  
    6.  In the NPS console tree, right\-click **NPS**, click **Properties**, and then click the **Ports** tab. Verify that the correct **Authentication** and **Accounting** ports are displayed.  
  
4.  To verify the configuration of authentication methods, you must manually review settings in connection request policy and network policy. Certificate based EAP methods require that the proper certificate is chosen, and might require that you provision a computer certificate on the destination server.  
  
    ###### Verifying authentication methods  
  
    1.  If you use certificate based EAP methods, your destination server might already be provisioned with a suitable certificate through autoenrollment. You might also be required to manually enroll the destination server with a computer certificate. For an overview of certificate requirements for network authentication, see [Network access authentication and certificates](http://go.microsoft.com/fwlink/?LinkId=169625) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169625\).  
  
    2.  To view certificates associated with EAP methods, click **Start**, click **Run**, type **nps.msc**, and press ENTER.  
  
    3.  In the NPS console tree, open **Policies** and then open the type of policy you are using to perform authentication. For example, if the option to **Override network policy authentication settings** is enabled on the **Settings** tab in a connection request policy, then authentication is performed in connection request policy. Otherwise, authentication is performed in network policy. Authentication can be configured in both types of policies.  
  
    4.  For connection request policy, double\-click the policy name and then click the **Settings** tab. For network policy, double\-click the policy name and then click the **Constraints** tab.  
  
    5.  Click **Authentication Methods**, and then under **EAP Types** click the name of the certificate\-based authentication method. For example: **Microsoft: Protected EAP \(PEAP\)** or Microsoft: Smart Card or other certificate.  
  
    6.  Click **Edit**, verify that the correct certificate is chosen next to **Certificate issued** or **Certificate issued to**, and then click **OK**.  
  
        > [!NOTE]  
        > Client computers using certificate based authentication methods must trust the certification path for this certificate.  
  
5.  To verify that client computers can authenticate using the destination server, attempt to connect to the network using client VPN connection, an 802.1X connection, or another connection that requires successful RADIUS authentication for network access.  
  
    ###### Verifying client connections  
  
    1.  To verify that client computers are successfully connecting to the network, click **Start**, click **Run**, type **eventvwr.msc**, and then press ENTER.  
  
    2.  In the event viewer console tree, open **Custom Views\\Server Roles\\Network Policy and Access Services**.  
  
    3.  In the details pane, verify under **Event ID** that event number 6272 is displayed.  
  
    4.  Events 6273 or 6274 indicate that client authentication attempts are unsuccessful.  
  
    5.  If no events are displayed, client connection requests are unable to reach the destination server, or the server is not logging authentication attempts.  
  

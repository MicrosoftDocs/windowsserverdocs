---
title: Issues with Synchronization
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a224c45-3a4c-4145-acf3-5fb520efea1d
author: britw
---
# Issues with Synchronization
Synchronization is the process in which the WSUS server connects to Microsoft Update or another WSUS server and downloads updates. During synchronization, WSUS determines if any new updates are available since the last time you synchronized. If it is your first time synchronizing WSUS, all updates are made available for approval. If synchronizations are failing, you can use the following information to troubleshoot the problem.  
  
## Troubleshooting synchronization  
  
#### Check the error in the synchronization's details pane  
If a synchronization has failed, in the WSUS administration console, go to the **Synchronizations** node, and in the middle pane select the failed synchronization. In the Synchronization Details pane you will see **Details**, which links to the full error description.  
  
#### Synchronization retries by downstream servers  
If the upstream WSUS server is not available for synchronization from a downstream server at the scheduled time, the downstream server will try to synchronize twice more, at approximately 15 minute intervals. If neither retry succeeds, the downstream server will try again the next day at the scheduled synchronization time.  
  
#### Check proxy server settings by using the WSUS console  
If your WSUS server is connected to Microsoft Update through a proxy server, you must use the WSUS console to configure WSUS so that it can access the Internet. For basic instructions about setting up a proxy server, see [Deploying Microsoft Windows Server Update Services](http://go.microsoft.com/fwlink/?linkid=79983). If your proxy server supports authentication, make sure that you have the correct user name, password, and domain.  
  
> [!NOTE]  
> If you use the WSUS console option for **Allow basic authentication \(password in cleartext\)**, the password for the account is sent over the network in unencrypted text.  
  
One major cause of synchronization failure is an expired password on the proxy server. Make sure that the user name and password for the proxy server are always up\-to\-date.  
  
#### Check the firewall settings  
If your network has a firewall between the WSUS server and the Internet, make sure that all the necessary ports are open and the necessary domains are allowed. For more information, see the [Windows Server Update Services 3.0 SP2 Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832).  
  
#### Check the name of the upstream WSUS server  
If your WSUS server uses another WSUS server as its update source, make sure that you are using the correct name for the upstream WSUS server and that you have spelled it correctly. For basic instruction about synchronizing two WSUS servers, see the [Windows Server Update Services 3.0 SP2 Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832). The name that you enter in the WSUS console on the downstream WSUS server must match the name of the upstream WSUS server.  
  
To determine if there is a problem with network name resolution services, use the **ping** command from the downstream WSUS server that cannot synchronize. You should use the same naming convention that is used in the WSUS console. For example, if you used a NetBIOS name in WSUS console, use the NetBIOS name of the upstream server with the **ping** command. If you cannot ping the upstream server, you might have a problem with network name resolution services. To work around this type of issue, you could use a different name resolution service or the IP address of the upstream server.  
  
###### To contact an upstream WSUS server by using the ping command  
  
1.  Click **Start**, and then click **Run**.  
  
2.  In the **Open** box, type **cmd**, and then click **OK**.  
  
3.  Type the following, and then press ENTER:  
  
    **ping** *WSUSServerName*  
  
    where *WSUSServerName* is the name of the upstream WSUS server with which you are trying to synchronize.  
  
#### Verify that users and the network service have Read permissions to the local update storage directory  
If you store update files on your WSUS server, you need to ensure that the folder to which you download update files \(by default C:\\WSUS\) has at least Read permissions for the network service and for users. This is true for both upstream and downstream WSUS servers.  
  
#### On a downstream WSUS server, check that the updates are available on the upstream WSUS server  
There are a number of situations where the updates on the upstream server no longer match the updates that are being requested at synchronization by the downstream server. Examples of when this might occur include:  
  
-   An upstream WSUS server is reinstalled and the set of classifications and products the administrator selects is smaller than the set previously selected for the earlier installation. The downstream servers might then attempt to synchronize updates that the newly rebuilt upstream server has not downloaded. Synchronization will fail for updates that do not exist on the upstream server.  
  
-   A downstream server is reconfigured to get updates from a different upstream server with different products and classifications selected.  
  
To troubleshoot this issue, make a note of the updates for which the download failed on the downstream server. These will be visible on the Updates page, and marked with a red "X." Check if these updates exist on the Updates page of the upstream server. If they do not match, do one of the following, depending on which updates you need:  
  
-   Specify the missing updates on the upstream server, and then synchronize from the update source.  
  
-   If the failed updates are not needed, cancel and then decline the updates that are not on the upstream server.  
  
-   If the missing updates are available on the upstream server, then the error is transient, and the update might have been downloaded to the upstream server after it was requested by the downstream server. This issue will resolve itself the next time the downstream server synchronizes to the upstream server.  
  
#### Restart the BITS service  
If the BITS service was disabled during synchronization, synchronization will fail. To ensure that the BITS service is properly enabled, restart the BITS service and the WSUS service.  
  
###### To restart the BITS service and the WSUS service  
  
1.  On the WSUS server, click **Start**, point to **Administrative Tools**, and then click **Services**.  
  
2.  Right\-click **Background Intelligent Transfer Service**, click **Properties**, and make sure that **Startup Type** is **Manual**. After that click **Start**.  
  
3.  Right\-click **Windows Update Service**, and then click **Restart**.  
  
4.  Retry synchronization: In the WSUS console, click **Options**, click **Synchronization Options**, and then under **Tasks**, click **Synchronize now**.  
  
    > [!NOTE]  
    > You should also ensure that the BITS service and the WSUS service are set to start automatically on reboot.  
  
#### The number of updates that are approved on a parent upstream server does not match the number of approved updates on a replica server  
This might occur if you have changed language settings on the parent upstream server after first synchronizing with the old language settings. For more information see "Listinactiveapprovals" in [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
#### The last catalog synchronization failed  
If your last catalog synchronization failed and you see event ID 10021 or ID 10022, check your upstream server and proxy settings in the WSUS administration console \(**Options**, then **Update Source and Proxy Server**\).  
  
#### A WSUS 2.0 replica times out when synchronizing  
In some cases WSUS 2.0 replica servers time out during synchronization. This issue has been fixed in WSUS 2.0 Service Pack 1 and in WSUS 3.0. For more information, see [article 910847](http://go.microsoft.com/fwlink/?LinkId=86496), in the Microsoft Download Center.  
  

---
title: Launch Windows Admin Center
description: Launch Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Launch Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

[this is from an end-user perspective - starting point]
[add info about tagging, etc]

## Connecting to managed nodes and clusters ##

After you have completed the installation of Windows Admin Center, you can add servers or clusters to manage from the main overview page.

 **Add a single server or a cluster as a managed node**

 1. Click **+ Add** under **All Connections**.

    ![](../../media/honolulu/screen1.png)

 2. Choose to add a Server, Failover Cluster or Hyper-Converged Cluster connection:
    
    ![](../../media/honolulu/screen2.png)

 3. Type the name of the server or cluster to manage and click **Submit**. The server or cluster will be added to your connection list on the overview page.

    ![](../../media/honolulu/screen3-add-server.png)

   **-- OR --**  

**Bulk import multiple servers**

 1. On the **Add Server Connection** page, choose the **Import Servers** tab.

    ![](../../media/honolulu/screen4-import-servers.png)

 2. Click **Browse** and select a text file that contains a comma, or new line separated, list of FQDNs for the servers you want to add.

## Authenticate with the managed node ##

Windows Admin Center supports several mechanisms for authenticating with a managed node. Single sign-on is the default.

**Single Sign-on**

You can use your current Windows credentials to authenticate with the managed node. This is the default, and Windows Admin Center attempts the sign-on when you add a server. 

**Single sign-on when deployed as a Service on Windows Server**

If you have installed Windows Admin Center on Windows Server, additional configuration is required for single sign-on.  [Configure your environment for delegation](..\configure\user-access-control.md)


**-- OR --**

**Use *Manage As* to Specify credentials**

Under **All Connections**, select a server from the list and choose **Manage As** to specify the credentials that you will use to authenticate to the managed node:

![](../../media/honolulu/manage-as.png)

If Windows Admin Center is running in service mode on Windows Server, but you do not have Kerberos delegation configured, you must re-enter your Windows credentials:

![](../../media/honolulu/spacer1.png)![](../../media/honolulu/credentials-needed.png)

You may apply the credentials to all connections, which will cache them for that
specific browser session. If you reload your browser, you must re-enter your
**Manage As** credentials.

**Local Administrator Password Solution (LAPS)**

If your environment uses [LAPS](https://technet.microsoft.com/en-us/mt227395.aspx), you can use LAPS credentials to authenticate with the managed node. **If you test this scenario, please** [provide feedback](http://aka.ms/HonoluluFeedback).

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

> [!Tip]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../understand/windows-admin-center.md) or [Download now](https://aka.ms/wacdownload).

## Selecting a client certificate

After you install Windows Admin Center on Windows 10, you will be prompted to select a certificate on first launch.

In Microsoft Edge, when you are prompted with this dialog:
 
1. Click **More choices**

    ![](../media/launch-cert-1.png)

2. Select the certificate labeled **Windows Admin Center Client** and click **OK**

    ![](../media/launch-cert-2.png)

3. Make sure **Always Allow Access** is selected and click **Allow**

    ![](../media/launch-cert-3.png)

## Connecting to managed nodes and clusters ##

After you have completed the installation of Windows Admin Center, you can add servers or clusters to manage from the main overview page.

 **Add a single server or a cluster as a managed node**

 1. Click **+ Add** under **All Connections**.

    ![](../media/launch-use-1.png)

 2. Choose to add a Server, Failover Cluster or Hyper-Converged Cluster connection:
    
    ![](../media/launch-use-2.png)

 3. Type the name of the server or cluster to manage and click **Submit**. The server or cluster will be added to your connection list on the overview page.

    ![](../media/launch-use-3.png)

   **-- OR --**  

**Bulk import multiple servers**

 1. On the **Add Server Connection** page, choose the **Import Servers** tab.

    ![](../media/launch-use-4.png)

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

![](../media/launch-use-6.png)

If Windows Admin Center is running in service mode on Windows Server, but you do not have Kerberos delegation configured, you must re-enter your Windows credentials:

![](../media/launch-use-7.png)

You may apply the credentials to all connections, which will cache them for that
specific browser session. If you reload your browser, you must re-enter your
**Manage As** credentials.

**Local Administrator Password Solution (LAPS)**

If your environment uses [LAPS](https://technet.microsoft.com/en-us/mt227395.aspx), you can use LAPS credentials to authenticate with the managed node. **If you use this scenario, please** [provide feedback](http://aka.ms/WACFeedback).

## Using Tags with server connections ##

You can use tags to identify and filter related servers in your connection list.  This allows you to see a subset of your servers in the connection list.  This is especially useful if you have many connections.

## Add or remove a tag

* Select a server in the Server Connections list
* Under **Server Connections**, click **Edit Tags**

![](../media/launch/tags-5.png)

The **Edit Connection Tags** dialog allows you to add or remove tags from your server connection.

To add a new tag to a server connection:

* Start entering a tag by clicking **Add Tags** under **Tags to Add**
* Add entries for one or more tags you would like to add
* Click **Save**

To remove an existing tag from a server connection:

* Start entering a tag by clicking **Add Tags** under **Tags to Remove**
* Add entries for one or more tags you would like to remove
* Click **Save**

![](../media/launch/tags-4.png)

## Filter connections by tag

Once tags have been added to one or more server connections, you can view the tags on the connection list, and filter the connection list by tags.

* To filter by a tag, enter the tag in the filter text box.  Entries appearing in the Server Connection list will be filtered to include that tag.

![](../media/launch/tags-2.png)


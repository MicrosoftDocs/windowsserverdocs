---
title: Create an Alias (CNAME) Record in DNS for WEB1
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: bfae23f0-ae12-486b-94fe-50a137e141a5
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Create an Alias \(CNAME\) Record in DNS for WEB1

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to add an Alias canonical name \(CNAME\) resource record for your Web server to a zone in DNS on your domain controller. With CNAME records, you can use more than one name to point to a single host, making it easy to do such things as host both a File Transfer Protocol \(FTP\) server and a Web server on the same computer.   
  
Because of this, you are free to use your Web server to host the certificate revocation list \(CRL\) for your certification authority \(CA\) as well as to perform additional services, such as FTP or Web server.  
  
When you perform this procedure, replace **Alias name** and other variables with values that are appropriate for your deployment.  
  
To perform this procedure, you must be a member of **Domain Admins**.  
  
## To add an alias \(CNAME\) resource record to a zone  
  
>[!NOTE]  
>To perform this procedure by using Windows PowerShell, see [Add-DnsServerResourceRecordCName](https://technet.microsoft.com/library/jj649894(v=wps.630).aspx).  
  
1.  On DC1, in Server Manager, click **Tools** and then click **DNS**. The DNS Manager Microsoft Management Console (MMC) opens.  
  
2.  In the console tree, double-click **Forward Lookup Zones**, right-click the forward lookup zone where you want to add the Alias resource record, and then click **New Alias \(CNAME\)**. The **New Resource Record** dialog box opens.  
  
3.  In **Alias name**, type the alias name **pki**.  
  
4.  When you type a value for **Alias name**, the **Fully qualified domain name \(FQDN\)** auto-fills in the dialog box. For example, if your alias name is "pki" and your domain is corp.contoso.com, the value **pki.corp.contoso.com** is auto-filled for you.  
  
5.  In **Fully qualified domain name \(FQDN\) for target host**, type the FQDN of your Web server. For example, if your Web server is named WEB1 and your domain is corp.contoso.com, type **WEB1.corp.contoso.com**.  
  
6.  Click **OK** to add the new record to the zone.  
  


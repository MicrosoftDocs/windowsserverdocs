---
title: Set up email discovery to subscribe to your RDS feed
description: Learn how to integrate Azure AD Domain Services into your RDS deployment.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: chrimo
ms.date: 10/02/2017
ms.localizationpriority: medium
ms.topic: article
author: christianmontoya
---
# Set up email discovery to subscribe to your RDS feed 

Have you ever had trouble getting your end users connected to their published RDS feed, either becuase of a single missing character in the feed URL or because they lost the email with the URL? Nearly all Remote Desktop client applications support finding your subscription by entering your email address, making it easier than ever to get your users connected to their RemoteApps and desktops. 
 
Before you set up email discovery, do the following:

- Register the domain associated with your email addresses 
- Have rights to add a TXT record to your registered domain 
- Create an RD Web feed URL (https://\<rdweb-dns-name\>.domain/RDWeb/Feed/webfeed.aspx, such as https://rdweb.contoso.com/RDWeb/Feed/webfeed.aspx) 
 
Now, use these steps to set up email discovery:

1. In your browser, connect to the website of the domain name registrar where your domain is registered. 
2. Navigate to the appropriate page for your registered domain where you can view, add, and edit DNS records. 
3. Enter a new DNS record with the following properties:  
   - **Host:** _msradc 
   - **Text:** \<RD Web Feed URL\> 
   - **TTL:** 300 

   The names of the DNS records fields vary by domain name registrar, but this process will result in a TXT record named _msradc.\<domain_name\> (such as _msradc.contoso.com) that has a value of the full RD Web feed. 
 
That’s it! Now, launch the Remote Desktop application on your device and subscribe yourself! 
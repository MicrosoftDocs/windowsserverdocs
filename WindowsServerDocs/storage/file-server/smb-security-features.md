---
title: SMB security hardening
description: Learn about SMB security enhancements, such as encryption and the new signing algorithm, in Windows Server and Azure Stack HCI, version 21H2.
ms.topic: article
author: robinharwood
ms.author: wscontent
ms.date: 05/18/2023
---

# SMB security hardening

The latest SMB (Server Message Block) features introduced in Windows 11 24H2 and Windows Server 2025 are designed to enhance the security of your data, users, and organization. Most of these features are automatically enabled by default. These SMB features aim to provide a safer and more secure computing environment by reducing the risk of cyberattacks and data breaches in your environment.

To preview these security features prior to our major Operating System (OS) release, the following versions are available for users to download:

- [Windows 11 Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewiso)

- [Windows Server 2025 Insider Preview](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver)

## SMB security features

By learning about SMB security features, users can better understand how to protect their sensitive data and prevent unauthorized access to shared resources. The following section describes a brief synopsis of these features.

### SMB alternative ports

The SMB client can be used to establish connections with alternative ports for TCP, QUIC, and RDMA. These ports may differ from the default ports assigned by the Internet Assigned Numbers Authority (IANA) and the Internet Engineering Task Force (IETF), which are 445, 5445, and 443 for TCP, QUIC, and RDMA respectively.

In Windows Server, it's possible to host an SMB over QUIC connection on a firewall port that is permitted, but not necessarily the default port 443. However, it's important to note that connecting to alternative ports is only possible if the SMB server has been configured to listen on that specific port. Additionally, it's possible to configure the deployment to disallow the use of alternative ports or to restrict their usage to certain servers.

### SMB auditing improvements



### SMB authentication rate limiter



### SMB client encryption mandate now supported



### SMB Firewall default port changes



### SMB insecure guest authentication



### SMB NTLM blocking



### SMB over QUIC client access control



### SMB over QUIC in Windows Server



### SMB Remote Mailslots deprecation



### SMB signing

---
title: STEP 8 Configure INET1
description: Learn how to configure a DNS entry for 2-EDGE1 on INET1.
ms.topic: article
ms.assetid: 693acb5c-dffc-4484-8286-163bb67724c9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 08/07/2020
---

# STEP 8: Configure INET1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

To enable client computers to connect to Remote Access servers over the Internet, you must configure a DNS entry for 2-EDGE1 on INET1.

### To create the 2-EDGE1 DNS entry

1.  On the **Start** screen, type**dnsmgmt.msc**, and then press ENTER.

2.  In the console tree, open **Forward Lookup Zones**, click **contoso.com**, then right-click **contoso.com**, and then click **New Host (A or AAAA)**.

3.  In **Name**, type **2-EDGE1**. In **IP address**, type **131.107.0.20**. Click **Add Host**, click **OK**, and then click **Done**.




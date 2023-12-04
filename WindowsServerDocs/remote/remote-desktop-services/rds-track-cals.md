---
title: Track your Remote Desktop Services client access licenses (RDS CALs)
description: Learn how to track CALs across your RDS deployment.
ms.topic: article
ms.assetid: 80d82d30-3ad0-4a8c-9a9b-2773c47eee19
author: lizap
ms.author: elizapo
ms.date: 05/11/2017
manager: dongill
---
# Track your Remote Desktop Services client access licenses (RDS CALs)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use the Remote Desktop Licensing Manager tool to create reports to track the RDS Per User CALs that have been issued by a Remote Desktop license server.

> [!NOTE]
>  If you're using Microsoft Entra Domain Services in your environment, the Remote Desktop Licensing Manager tool won't work to obtain Per User CALs. Instead, you need to track licensing manually, either through logon events, polling active Remote Desktop connections through the Connection Broker, or another mechanism that works for you.

Use the following steps to generate a per User CALs report:

1. In Remote Desktop Licensing Manager right-click the license server, click **Create Report**, and then click **CAL Usage**.

2. The report is created and a message appears to confirm that the report was successfully created. Click **OK** to close the message.

The report that you created appears in the Reports section under the node for the license server. The report provides the following information:

- Date and time the report was created
- The scope of the report (e.g., Domain, OU=Sales, or All trusted domains)
- The number of RDS Per User CALs that are installed on the license server
- The number of RDS Per User CALs that have been issued by the license server specific to the scope of the report

You can also save the report as a CSV file to a folder location on the computer. To save the report, right-click the report that you want to save, click Save As, and then specify the file name and location to save the report.

Reports that you create are listed in the Reports node under the node for the license server in Remote Desktop Licensing Manager. If you no longer need a report, you can delete it.

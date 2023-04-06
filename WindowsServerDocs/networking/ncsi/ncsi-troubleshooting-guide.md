---
title: Network Connectivity Status Indicator Troubleshooting Guide
description: 'This guide demonstrates how to perform diagnostics using the Network Connectivity Status Indicator (NCSI) to troubleshoot and determine Internet connectivity.'
ms.topic: article
ms.date: 04/06/2023
ms.author: alalve
author: rnitsch
---

# How to collect data to diagnose NCSI issues

Troubleshooting NCSI (Network Connectivity Status Indicator) issues are generally performed with packet capture data but NCSI event logs can also be a useful tool when correlated with the packet traffic. This guide serves to assist users on how diagnosing NCSI issues from common scenarios.

## View NCSI data using Event Viewer

1. To open the **Event Viewer**, right-click on **Start** > **Event Viewer**. <br>_Alternatively_, open the Run prompt by pressing **Win+R** and typing eventviewer.exe.
![Screenshot of the Start button context menu with Event Viewer highlighted.](../media/NCSI/ncsi-event-viewer-1.jpg)

1. Expand **Applications and Service Logs** > **Microsoft** > **Windows** > **NCSI**.
![Screenshot of the Event Viewer with expanded Applications and Service Logs, Microsoft, Windows, and NCSI highlighted.](../media/NCSI/ncsi-event-viewer-2.jpg)

1. Right-click **NCSI**, select **View** > **Show Analytic and Debug Logs**.
![Screenshot of the Event Viewer with NCSI highlighted with Show Analytic and Debug Logs enabled.](../media/NCSI/ncsi-event-viewer-3.jpg)

1. Right-click on **Analytic** under the **NCSI** folder, select **Enable Log**.
<br>_A dialog box may notify you that you may lose Analytic and Debug log events when logging is enabled. Select **Ok** to proceed._
![Screenshot of the Event Viewer with the NCSI Analytic event logging enabled.](../media/NCSI/ncsi-event-viewer-4.jpg)

## Retrieve NCSI data using Event Viewer

Performing the actions mentioned above will facilitate in data retrieval. For easier analysis, convert the generated logs to text format. While in the **Event Viewer**, follow these steps:

1. Expand **Applications and Service Logs** > **Microsoft** > **Windows** > **NCSI**.
1. Right-click on **Analytic**, select **Save All Events As**.
![Screenshot of the Event Viewer with the NCSI Analytic event with save all events being enabled.](../media/NCSI/ncsi-event-viewer-5.jpg)

1. The "Save As" dialog box opens. Set the "save as type" to text (*.txt), name your file and select your location. Select **Save**.
![Screenshot of the save as dialog window with NCSI logs being saved to the documents folder.](../media/NCSI/ncsi-event-viewer-6.jpg)

Here's an example of the text file output:

```
Information    3/7/2023 10:21:06 AM    Microsoft-Windows-NCSI    4013    Internet Connectivity Detection    Active Internet Probe started on interface {704d7e27-9607-48df-b5b4-cffe0ab27000}
Information    3/7/2023 10:21:06 AM    Microsoft-Windows-NCSI    4017    Internet Connectivity Detection    Active Internet Probe (HTTP) started on interface {704d7e27-9607-48df-b5b4-cffe0ab27000}
Information    3/7/2023 10:21:17 AM    Microsoft-Windows-NCSI    4018    Internet Connectivity Detection    Active Internet Probe (HTTP) finished on interface {704d7e27-9607-48df-b5b4-cffe0ab27000}
```

Correlate both the **Analytic** and **Operational** NCSI events with the packet capture timestamps to determine whether the active probe was fired, if it completed, and why it failed.

## How to reproduce a problem scenario

You can troubleshoot an issue by forcing an active probe to see if it completes. The easiest way to do this is to cause a network change event. The following demonstrates this on both wired and wireless connections:

**Wired**
1. Disconnect the Ethernet cable. (Alternatively, you can disable the network adapter in Advanced network settings).
1. Start the packet capture and wait 30 seconds.
1. Reconnect the Ethernet cable. (Or enable the network adapter in Advanced network settings if it was previously disabled).
1. Wait 60 seconds before stopping the capture to ensure ample time for active probe to be attempted.

**Wireless**
1. Start the packet capture prior to the connection.
1. Connect to the wireless network.
1. Wait 60 seconds to ensure the active probe activity has fully transpired.
1. Stop the network capture.

## Additional references

[NCSI Overview](ncsi-overview.md)
[NCSI FAQ](ncsi-frequently-asked-questions.md)

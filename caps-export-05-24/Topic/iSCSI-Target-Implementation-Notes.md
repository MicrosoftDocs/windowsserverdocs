---
title: iSCSI Target Implementation Notes
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 52b98ba3-22ec-442b-8b7e-791cb918c4c2
---
# iSCSI Target Implementation Notes
iSCSI Target Server was implemented in compliance with the industry standards that are specified by RFC 3720 and RFC 5048. To verify this compliance, iSCSI Target Server was tested by a compliance testing organization.  
  
This document lists the issues that were found during testing of iSCSI Target Server on Windows Server 2012. For the previous version – Microsoft iSCSI Software Target version 3.3 \- known issues are listed at [Microsoft iSCSI Software Target 3.3 Implementation Notes](http://technet.microsoft.com/library/gg983494(v=ws.10)) \(http:\/\/technet.microsoft.com\/library\/gg983494\(v\=ws.10\)\).  
  
## Known Issues  
The following are the known issues with Windows® Server 2012 iSCSI Target Server.  
  
### SCSI Response Excess Immediate Data  
RFC 3720, section 3.2.4.2, specifies the following:  
  
It is also an error for an initiator to send more unsolicited data, whether immediate or as separate PDUs, than FirstBurstLength.  
  
The behavior exhibited by ISCSI Target Server:  
  
When responding to a **Write** command with more immediate data than specified by the FirstBurstLength, iSCSI Target Server sends a SCSI Response PDU with a status of **Good**.  
  
### SCSI Response to Incorrect Amount of Data Condition  
RFC 3720, section 10.4.7.2, specifies the following:  
  
The target reports the ‘Incorrect amount of data’ condition if during data output the total data length to output is greater than FirstBurstLength and the initiator sent unsolicited non\-immediate data but the total amount of unsolicited data is different than FirstBurstLength. The target reports the same error when the amount of data sent as a reply to an R2T does not match the amount requested.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server responds with status of 0x00 \(good\) after receiving more than 512 bytes of data when FirstBurstLength\=512.  
  
The iSCSI Target Server responds with status of 0x00 \(good\) after receiving data less than specified ExpectedDataTranserLength and F bit set to 1.  
  
### SCSI Response to Unexpected Unsolicited Data  
RFC 3720, section 12.11, specifies the following:  
  
If ImmediateData is set to No and InitialR2T is set to Yes, then the initiator MUST NOT send unsolicited data and the target MUST reject unsolicited data with the corresponding response code.  
  
The behavior exhibited by ISCSI Target Server:  
  
When the ImmediateData is set to No, and InitialR2T is set to Yes, iSCSI Target Server was observed to respond with the status Good when it received a Write command with unexpected unsolicited data.  
  
### Handling Text Response Text Field in Discovery Session  
RFC 3720, section 10.11.1, specifies the following:  
  
A Text Response with the F bit set to 1 in response to a Text Request with the F bit set to 0 is a protocol error.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to send a Text Response with:TargetTransferTag \= 0xFFFFFFFF while the F bit was not set.  
  
### Handling Text Request During Normal Session  
RFC 3720, section 3.5.3.1, specifies the behavior of Text Request and Text Response as follows:  
  
Text requests and responses are designed as a parameter negotiation vehicle and as a vehicle for future extension.  
  
In the data segment, Text Requests\/Responses carry text information using a simple "key\=value" syntax.  
  
Text Request\/Responses may form extended sequences using the same Initiator Task Tag. The initiator uses the F \(Final\) flag bit in the text request header to indicate its readiness to terminate a sequence. The target uses the F \(Final\) flag bit in the text response header to indicate its consent to sequence termination.  
  
Text Request and Responses also use the Target Transfer Tag to indicate continuation of an operation or a new beginning. A target that wishes to continue an operation will set the Target Transfer Tag in a Text Response to a value different from the default 0xffffffff.  
  
An initiator willing to continue will copy this value into the Target Transfer Tag of the next Text Request. If the initiator wants to restart the current target negotiation \(start fresh\) will set the Target Transfer Tag to 0xffffffff.  
  
Although a complete exchange is always started by the initiator, specific parameter negotiations may be initiated by the initiator or target.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to disconnect the session after it received a Text Request during a normal session, when the following conditions existed:  
  
F bit was set to 0  
  
There was an attached MaxRecvDataSegmentLengthKey  
  
This happens with or without a valid ITT \(Initiator Task tag\).  
  
### Handling Text Request During Discovery Session  
RFC 3720, section 3.3, specifies the following:  
  
Discovery\-session \- a session only opened for target discovery. The target MUST ONLY accept text requests with the SendTargets key and a logout request with the reason "close the session". All other requests MUST be rejected.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to disconnect after receiving a text request with an attached MaxRecvDataSegmentLength key during a Discovery session.  
  
### Handling Text Request with SendTargets\=  
RFC 3720, Appendix D, specifies the following:  
  
If the SendTargets value is nothing in the Text Request, “The session should only respond with addresses for the target to which the session is logged in. This MUST be supported on operational sessions, and MUST NOT return targets other than the one to which the session is logged in.”  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to disconnect after receiving a text request with an attached “SendTargets\=” key during a discovery session and during a normal session.  
  
### Handling Text Request with SendTargets\=All during Normal Session  
RFC 3720, Appendix D, specifies the following:  
  
If the SendTargets value is “All” in the Text Request, “The initiator is requesting that information on all relevant targets known to the implementation be returned. This value MUST be supported on a discovery session, and MUST NOT be supported on an operational session.”  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to disconnect after receiving a text request with an attached “SendTargets\=All” key during a normal session.  
  
### Text Response Negotiation Failure  
RFC 3720, Section 6.10, specifies the following:  
  
A negotiation failure is considered to be one or more of the following:  
  
None of the choices, or the stated value, is acceptable to one of the sides in the negotiation.  
  
The text request timed out and possibly terminated.  
  
The text request was answered with a Reject PDU.  
  
The behavior implemented by the ISCSI Software Target in Windows Server 2012:  
  
The iSCSI Target Server was observed to disconnect the session after receiving a text request with the F bit set to 0, and an attached MaxRecvDataSegmentLengthKey.  
  
### Handling Text Request with C bit  
RFC 3720, Section 5.2, specifies the following:  
  
A target receiving a Text or Login Request with the C bit set to 1 MUST answer with a Text or Login Response with no data segment \(DataSegmentLength 0\).  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to disconnect after receiving a text request with C bit set to 1.  
  
### Standard Login Key Negotiation  
RFC 3720, section 10.13.3, specifies the following:  
  
For a new session, the target MUST generate a non\-zero TSIH and ONLY return it in the Login Final\-Response.  
  
The behavior exhibited by ISCSI Target Server:  
  
When the iSCSI initiator performed a standard login and negotiated the login parameters, the iSCSI Target Server was observed to set the TSIH field in the first Login Response PDU.  
  
### Duplicate or Out of Order CmdSN  
RFC 3720, section 3.2.2.1 specifies the following:  
  
The target MUST silently ignore any non\-immediate command outside of this range or non\-immediate duplicates within the range.  
  
For non\-immediate commands, the CmdSN field can take any value from ExpCmdSN to MaxCmdSN inclusive.The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server does not send an R2T in response to a WRITE command which was followed by a duplicate WRITE. It silently ignores any PDU which CmdSN is not the next sequential CmdSN.  
  
> [!NOTE]  
> Since the iSCSI Target Server supports one connection per session, it currently silently ignores any PDU which CmdSN is not the next sequential CmdSN.  
  
### Task Management Response for Non\-Existent Task  
RFC 3720, section 10.6.1, specifies the following:  
  
If the Referenced Task Tag does not identify an existing task and if the CmdSN indicated by the RefCmdSN field in the Task Management function request is outside the valid CmdSN window, then targets must return the "Task does not exist" response.  
  
The target provides a Response, which may take on the following values:  
  
```  
a)    0 - Function complete.  
b)    1 - Task does not exist.  
c)    2 - LUN does not exist.  
d)    3 - Task still allegiant.  
e)    4 - Task allegiance reassignment not supported.  
  
```  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to respond with 0 \(function complete\) when receiving a non\-existent RefrencedTaskTag and a RefCmdSN outside the valid CmdSN window.  
  
### Incorrect Logout Reason Code Being Accepted During Discovery  
RFC 3720, section 3.3, specifies the following:  
  
Discovery\-session \- a session only opened for target discovery. The target MUST ONLY accept text requests with the SendTargets key and a logout request with the reason "close the session". All other requests MUST be rejected.  
  
The behavior exhibited by ISCSI Target Server:  
  
During the discovery session, the iSCSI Target Server sends a response code of 0x00 \(success\) in response to a logout request with reason code 2 \(remove connection with recovery\).  
  
### Logout Response Non\-existent Connection  
RFC 3720, section 10.14, specifies the following:  
  
When receiving a Logout Request with the reason code of "close the connection" or "close the session", the target MUST terminate all pending commands, whether acknowledged via ExpCmdSN or not, on that connection or session respectively.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server sends a response code of 0x00 \(success\) in response to a logout request with reason code 1 \(closes the connection\) for a non\-existent CID.  
  
> [!NOTE]  
> The iSCSI Target Server supports one session per connection and currently ignores CID value.  
  
### Handling Not Understood for Required Keys  
RFC 3720, section 5.2, specifies the following:  
  
If the acceptor sends "Reject" as an answer the negotiated key is left at its current value \(or default if no value was set\).  If the current value is not acceptable to the proposer on the connection or to the session it is sent, the proposer MAY choose to terminate the connection or session.  
  
All keys in this document, except for X extension formats, MUST be supported by iSCSI initiators and targets when used as specified here. If used as specified, these keys MUST NOT be answered with NotUnderstood.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to send a login success message when it received a request with the TargetPortalGroupTag\=NotUnderstood key.  
  
### Handling Re\-negotiation During Login  
RFC 3720, section 5.3, specifies the following:  
  
Neither the initiator nor the target should attempt to declare or negotiate a parameter more than once during login except for responses to specific keys that explicitly allow repeated key declarations \(e.g., TargetAddress\). An attempt to renegotiate or redeclare parameters not specifically allowed MUST be detected by the initiator and target. If such an attempt is detected by the target, the target MUST respond with Login Reject \(initiator error\).  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to allow renegotiation of the following parameters during the login phase:  
  
ImmediateData key\=value pair to yes  
  
MaxBurstLength key\=value pair to 32524  
  
DataDigest key\=value pair to CRC32C  
  
Double negotiation of DataDigest key\=value pair in the same PDU  
  
When it receives the previous parameters twice in the negotiation phase, the iSCSI Target Server proceeds with the login request.  
  
### Reject SNACK  
RFC 3720, section 10.17.3, specifies the following:  
  
StatSN, ExpCmdSN and MaxCmdSN carry their usual values and are not related to the rejected command. StatSN is advanced after a Reject.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to send an incorrect StatSN when rejecting SNACK request.  
  
### Text mode negotiation  
RFC 3720, section 5.2, specifies the following:  
  
Any key not understood by the acceptor may be ignored by the acceptor    without affecting the basic function.  However, the answer for a key not understood MUST be key\=NotUnderstood.  
  
The behavior exhibited by ISCSI Target Server:  
  
The iSCSI Target Server was observed to ignore the vendor specific keys and continue with the Login phase when C bit is set. If C bit is not set, iSCSI Target Server will comply with the standard.  
  

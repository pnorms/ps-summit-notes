<#
9:00 am → 90 min
Creating a PowerShell 7.4 Feedback Provider
Justin Grote
#>

# REQUIRES PS7.4+ !!!!

# Docs
# https://learn.microsoft.com/en-us/powershell/scripting/dev-cross-plat/create-feedback-provider?view=powershell-7.4

# Command not found runner
# IE Running
grip
<#
grip: The term 'grip' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

[general]
  The most similar commands are:
    ➤ gip
#>

# It is writter in c#
# [iFeedbackProvider] is the class

# 100ms timeout

# 20ms id for predictors

# Justin wrote a module to expose this via PowerShell called: ScriptFeedbackProvider
# https://github.com/JustinGrote/ScriptFeedbackProvider
Install-Module ScriptFeedbackProvider
# This should really be a dependancy in another module, put in required, not in the psm1
Import-Module ScriptFeedbackProvider

# Need to do:
Enable-ExperimentalFeature PSFeedbackProvider, PSCommandNotFoundSuggestion


# Uses script block and modles how argumnet completers are built
Register-ScriptFeedbackProvider -Name 'Generic Error' {
    param($context)
    if ($context.LastError.ErrorDetails.RecommendedAction) {
        [FeedbackItem]::new(
            'The last error has a recommended action:',
            @('this', 'and this', 'and this')
        )
    }
}
Write-Error 'test'

Register-ScriptFeedbackProvider -Name 'Error Recommended Action' {
    param($context)
    if ($context.LastError.ErrorDetails.RecommendedAction) {
        [FeedbackItem]::new(
            'The last error has a recommended action:',
            $context.LastError.ErrorDetails.RecommendedAction
        )
    }
}
# Actually show the param -RecommendedAction
Write-Error 'test' -RecommendedAction 'testing'

Write-Error 'test' -RecommendedAction 'testing'
<# RETURNS:
    Write-Error: test
    [Error Recommended Action]
    The last error has a recommended action:
        ➤ testing
#>


# A ton of overlap of SA rules, should be able to lint on each
# Check out:
[System.Management.Automation.Subsystem.Feedback.FeedbackItem]::new
<#
OverloadDefinitions
-------------------
System.Management.Automation.Subsystem.Feedback.FeedbackItem new(string header, System.Collections.Generic.List[string] actions)
System.Management.Automation.Subsystem.Feedback.FeedbackItem new(string header, System.Collections.Generic.List[string] actions,
System.Management.Automation.Subsystem.Feedback.FeedbackDisplayLayout layout)
System.Management.Automation.Subsystem.Feedback.FeedbackItem new(string header, System.Collections.Generic.List[string] actions, string footer,
System.Management.Automation.Subsystem.Feedback.FeedbackDisplayLayout layout)
#>

# Do you have any idea how much latency you are adding? Runspace spin up / resusing them etc?
# Things are warmed up. Latency should be only a few MS


# Uses script block and modles how argumnet completers are built
Register-ScriptFeedbackProvider -Name 'Send context back' {
    param($context)
    $context | Convertto-Json
}

# Run some command
Send-MailMessage -To sfd -From ds

# Have a look at the AST result
<#
  {
    "Trigger": 6,
    "CommandLine": "Send-MailMessage -To sfd -From ds",
    "CommandLineAst": {
      "Attributes": [],
      "UsingStatements": [],
      "ParamBlock": null,
      "BeginBlock": null,
      "ProcessBlock": null,
      "EndBlock": {
        "Unnamed": true,
        "BlockKind": 130,
        "Statements": "Send-MailMessage -To sfd -From ds",
        "Traps": null,
        "Extent": "Send-MailMessage -To sfd -From ds",
        "Parent": "Send-MailMessage -To sfd -From ds"
      },
      "CleanBlock": null,
      "DynamicParamBlock": null,
      "ScriptRequirements": null,
      "Extent": {
        "File": null,
        "StartScriptPosition": "System.Management.Automation.Language.InternalScriptPosition",
        "EndScriptPosition": "System.Management.Automation.Language.InternalScriptPosition",
        "StartLineNumber": 1,
        "StartColumnNumber": 1,
        "EndLineNumber": 1,
        "EndColumnNumber": 34,
        "Text": "Send-MailMessage -To sfd -From ds",
        "StartOffset": 0,
        "EndOffset": 33
      },
      "Parent": null
    },
    "CommandLineTokens": [
      {
        "Value": "Send-MailMessage",
        "Text": "Send-MailMessage",
        "TokenFlags": 524288,
        "Kind": 7,
        "HasError": false,
        "Extent": "Send-MailMessage"
      },
      {
        "ParameterName": "To",
        "UsedColon": false,
        "Text": "-To",
        "TokenFlags": 0,
        "Kind": 3,
        "HasError": false,
        "Extent": "-To"
      },
      {
        "Text": "sfd",
        "TokenFlags": 0,
        "Kind": 6,
        "HasError": false,
        "Extent": "sfd"
      },
      {
        "ParameterName": "From",
        "UsedColon": false,
        "Text": "-From",
        "TokenFlags": 0,
        "Kind": 3,
        "HasError": false,
        "Extent": "-From"
      },
      {
        "Text": "ds",
        "TokenFlags": 0,
        "Kind": 6,
        "HasError": false,
        "Extent": "ds"
      },
      {
        "Text": "",
        "TokenFlags": 32768,
        "Kind": 11,
        "HasError": false,
        "Extent": ""
      }
    ],
    "CurrentLocation": {
      "Drive": {
        "CurrentLocation": "temp\\PSConf24",
        "Name": "C",
        "Provider": "Microsoft.PowerShell.Core\\FileSystem",
        "Root": "C:\\",
        "Description": "Local Disk",
        "MaximumSize": null,
        "Credential": "System.Management.Automation.PSCredential",
        "DisplayRoot": null,
        "VolumeSeparatedByColon": true
      },
      "Provider": {
        "ImplementingType": "Microsoft.PowerShell.Commands.FileSystemProvider",
        "HelpFile": "System.Management.Automation.dll-Help.xml",
        "Name": "FileSystem",
        "PSSnapIn": "Microsoft.PowerShell.Core",
        "ModuleName": "Microsoft.PowerShell.Core",
        "Module": null,
        "Description": "",
        "Capabilities": 52,
        "Home": "C:\\Users\\user",
        "Drives": "C Temp",
        "VolumeSeparatedByColon": true,
        "ItemSeparator": "\\",
        "AltItemSeparator": "/"
      },
      "ProviderPath": "C:\\temp\\PSConf24",
      "Path": "C:\\temp\\PSConf24"
    },
    "LastError": {
      "Exception": {
        "TargetSite": "Boolean TryReadCfwsAndThrowIfIncomplete(System.String, Int32, Int32 ByRef, Boolean)",
        "Message": "The specified string is not in the form required for an e-mail address.",
        "Data": "System.Collections.ListDictionaryInternal",
        "InnerException": null,
        "HelpLink": null,
        "Source": "System.Net.Mail",
        "HResult": -2146233033,
        "StackTrace": "   at System.Net.Mail.MailAddressParser.TryReadCfwsAndThrowIfIncomplete(String data, Int32 index, Int32& outIndex, Boolean throwExceptionIfFail)\r\n   at System.Net.Mail.MailAddressParser.TryParseDomain(String data, Int32& index, String& domain, Boolean throwExceptionIfFail)\r\n   at System.Net.Mail.MailAddressParser.TryParseAddress(String data, Boolean expectMultipleAddresses, Int32& index, ParseAddressInfo& parseAddressInfo, Boolean throwExceptionIfFail)\r\n   at System.Net.Mail.MailAddressParser.TryParseAddress(String data, ParseAddressInfo& parsedAddress, Boolean throwExceptionIfFail)\r\n   at System.Net.Mail.MailAddress.TryParse(String address, String displayName, Encoding displayNameEncoding, ValueTuple`4& parsedData, Boolean throwExceptionIfFail)\r\n   at System.Net.Mail.MailAddress..ctor(String address)\r\n   at Microsoft.PowerShell.Commands.SendMailMessage.BeginProcessing()"
      },
      "TargetObject": "ds",
      "CategoryInfo": {
        "Category": 9,
        "Activity": "Send-MailMessage",
        "Reason": "FormatException",
        "TargetName": "ds",
        "TargetType": "String"
      },
      "FullyQualifiedErrorId": "FormatException,Microsoft.PowerShell.Commands.SendMailMessage",
      "ErrorDetails": null,
      "InvocationInfo": {
        "MyCommand": "Send-MailMessage",
        "BoundParameters": "System.Collections.Generic.Dictionary`2[System.String,System.Object]",
        "UnboundArguments": "",
        "ScriptLineNumber": 1,
        "OffsetInLine": 1,
        "HistoryId": 28,
        "ScriptName": "",
        "Line": "Send-MailMessage -To sfd -From ds",
        "Statement": "Send-MailMessage -To sfd -From ds",
        "PositionMessage": "At line:1 char:1\r\n+ Send-MailMessage -To sfd -From ds\r\n+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
        "PSScriptRoot": "",
        "PSCommandPath": null,
        "InvocationName": "Send-MailMessage",
        "PipelineLength": 0,
        "PipelinePosition": 0,
        "ExpectingInput": false,
        "CommandOrigin": 1,
        "DisplayScriptPosition": null
      },
      "ScriptStackTrace": "at <ScriptBlock>, <No file>: line 1",
      "PipelineIterationInfo": []
    }
  }
#>


## Unregister all the providers we added
Get-ScriptFeedbackProvider | Unregister-ScriptFeedbackProvider

# Do a success
# Uses script block and modles how argumnet completers are built
Register-ScriptFeedbackProvider -Trigger Error -Name 'Send context back' {
    param($context)
    if ($context.CommandLine -match 'Send-MailMessage') {
        'Do you not be using Send-MailMessage, use XYZ'
    }
}
# Run some command
Send-MailMessage -To sfd -From dss

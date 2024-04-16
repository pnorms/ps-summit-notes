# 2:00 pm → 45 min
# Interactive Enhancements to PowerShell
# Steven Bucher
# rm 405

<#
PSReadline already gives some predicors
  - History is simple, just show based on what you have already written
  - PlugIn Predictors - Predications you have never types based on what you have just done


# Pressing F2, will show list of predictors
    It will stick for the session

# Alt+A will allow you to move between values

# Install to your profile
install-Module ScriptPredictor, CompletionPredictor

# Exmplae predictors:
Find-Module | ft name, version, author
Name                                   Version Author
----                                   ------- ------
Az.Tools.Predictor                     1.1.3   Microsoft Corporation
CompletionPredictor                    0.1.1   PowerShell
PnP.PowerShell.Predictor               1.1.1   PnP
SPO.PowerShell.Predictor               2.1.1   Anoop T
DirectoryPredictor                     0.0.5   Justin Quinn
CLI.Microsoft365.PowerShell.Predictor  1.0.0   Microsoft 365 Patterns and Practices
PowerPlatform.CLI.PowerShell.Predictor 0.0.4   Anoop T
ScriptPredictor                        0.0.2   Justin Grote @JustinWGrote
VagrantPredictor                       1.0.0   nixuno
EwsPredictors                          0.2.0   Bartek Bielawski


# Add custom psreadline handlers
# You can add a scriptblock with set-psreadlineoption

# You can make your prompt change 
# You need to set a key bindoing handler
# Checkout Get-PSReadLineKeyHandler


######################
Feedback providers
Can trigger or success and errors, very extensible

Get-ExperimentalFeature

Name                                Enabled Source                              Description
----                                ------- ------                              -----------
PSCommandNotFoundSuggestion           False PSEngine                            Recommend potential commands based on …
PSFeedbackProvider                    False PSEngine                            Replace the hard-coded suggestion fram…

> PowerShell 7.4.1
PS C:\Users\user> Enable-ExperimentalFeature -Name PSFeedbackProvider
WARNING: Enabling and disabling experimental features do not take effect until next start of PowerShell.
PS C:\Users\user> Enable-ExperimentalFeature -Name PSCommandNotFoundSuggestion
WARNING: Enabling and disabling experimental features do not take effect until next start of PowerShell.

> It will try and tell you what went wrong, IE:
    PS C:\Users\user> dt
    dt: The term 'dt' is not recognized as a name of a cmdlet, function, script file, or executable program.
    Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

    [general]
    The most similar commands are:
        > ft, D:, It


# Get event more suggestions:
Install-Module command-not-found

# Check out PSAdaptersModule, which will suggest a way to run a native command and get a PS friendly results
# Not available yet

# Install jc.exe which can take native commands and make the results into JSOM
Install-Module microsoft.powershell.psadapter


#>
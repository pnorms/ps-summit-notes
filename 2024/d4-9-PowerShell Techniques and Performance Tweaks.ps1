<#
9:00 am → 90 min
PowerShell Techniques and Performance Tweaks - The Full Show
Christian Ritter
https://github.com/HCRitter
#>

# Talked about no back tick usage

# Use SPlatting

# Make use of PSDefaultParameterValues
    # Can be used with scope and wildcards!!!

# 

# Many ways to read a file of course
    # Switch has a file read parameter, system.io.file is still the fastest generally

    # Look into switch -file default read ability

# Talked about finally block always running no matter what

# Checkout: https://psframework.org/

# Talked about validate sets
# Talked about using enums as validate sets
# But you must respectic the type with default param assignments

# Talked about filtering techniques:
    # Where-object, name value or with {}
    # .Where Method
    # Foreach (), Foreach()
    # .Where is generaly the fastest

# Look into like vs match for speed while inside a condition

# Clever use of paramset name being used as the switch name
function Verb-Noun {
    [CmdletBinding()]
    param (
        [parameter(parametersetname='user')]
        [switch]
        $user,
        [parameter(parametersetname='device')]
        [switch]
        $device
    )

    "someapi/$($pscmdlet.parametersetname)/someid"
}
Verb-Noun -User
<#
PS C:\temp\PSConf24> function Verb-Noun {
>>     [CmdletBinding()]
>>     param (
>>         [parameter(parametersetname='user')]
>>         [switch]
>>         $user,
>>         [parameter(parametersetname='device')]
>>         [switch]
>>         $device
>>     )
>> 
>>     "someapi/$($pscmdlet.parametersetname)/someid"
>> }
PS C:\temp\PSConf24> Verb-Noun -User
someapi/user/someid
#>

function Verb-Noun {
    [CmdletBinding()]
    param (
        [parameter(parametersetname='/User/{0}/Info')]
        [switch]
        $user,
        [parameter(parametersetname='/Device/SomethingDifferent/{0}/Info')]
        [switch]
        $device,
        [int]
        $id
    )

    "$($pscmdlet.parametersetname -f $ID)/someid"
}
Verb-Noun -User -ID 1
Verb-Noun -Device -ID 1

<#
PS C:\temp\PSConf24> function Verb-Noun {
>>     [CmdletBinding()]
>>     param (
>>         [parameter(parametersetname='/User/{0}/Info')]
>>         [switch]
>>         $user,
>>         [parameter(parametersetname='/Device/SomethingDifferent/{0}/Info')]
>>         [switch]
>>         $device,
>>         [int]
>>         $id
>>     )
>>
>>     "$($pscmdlet.parametersetname -f $ID)/someid"
>> }
PS C:\temp\PSConf24> Verb-Noun -User -ID 1
/User/1/Info/someid
PS C:\temp\PSConf24> Verb-Noun -Device -ID 1
/Device/SomethingDifferent/1/Info/someid
#>

# Talked about dynamic params

# Talked about updating type data
# Shows ps7 ternary operator

# Showed a very clever usage of extending system.io.fileinfo with a custom
# script property so a vanilla Get-ChildItem can be called and the custom property
# would be shown

# Showed a get value or default implementation

# Compared math::max vs measure -max, for large sets math wins, small sets measure wins

# Showed a JSON Schema Validation Example
# Talked about this versus param validation, json schema validation will show everything that
# is wrong with ALL params, while vaildate set will show all issue, but it is much slower
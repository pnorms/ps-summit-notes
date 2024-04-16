<#
1:00 pm → 45 min
Improving Your Attributes
James Ruskin
rm 404
#>

# Talked about the built in parameter attributes: IE Mandatory, Validators etc and how
# they are typically called and used was arguments

# Went over argument completers

# Showed control space to show all available options for an argument completer tab out

# Use can use CommandAst as an argument completers as well
# Also FakeBoundParameters can be used as well

# You can use an argument transformation as a class that will modify the data

class ValidatePathExistsAttribute : System.Management.Automation.ValidateArgumentsAttribute
{
    [void]  Validate([object]$arguments, [System.Management.Automation.EngineIntrinsics]$engineIntrinsics)
    {
        $path = $arguments
        if([string]::IsNullOrWhiteSpace($path))
        {
            Throw [System.ArgumentNullException]::new()
        }
        if(-not (Test-Path -Path $path))
        {
            Throw [System.IO.FileNotFoundException]::new()
        }        
    }
}

function Test-Something
{
    [cmdletbinding()]
    param(
        [ValidatePathExists()]
        $Path
    )
    return $Path
}	


Test-Something -Path 'C:\Windows'
Test-Something -Path 'c:\notThere'
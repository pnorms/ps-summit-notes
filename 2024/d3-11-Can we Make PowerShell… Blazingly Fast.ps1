# 11:00 am → 45 min
# Can we Make PowerShell… Blazingly Fast?!
# Rob Pleau
# rm 406

# Foreach
# foreach-object, unless parralle, is generally the slowest
# .foreach() magic method is usally right in the middle, on most collections
# foreach ($i in $n), is generally the fastest for seqential

# Where
# Generally the where {} is the slowest, but can do multiple filters
# where Value -in Name, is a bit quicker, but it limited to a single check
# .Where() magic method is the fastest

# Arrays, by deffinition is fixed
# += is tearing dow the old array and rebuilding it each time
# Tend to use generic lists ith .Add
[arraylist]::new
# Even faster is [list[TYPE]] IE: [list[int]]

# Functions vs CmdLets
# Functions are code
# Cmdlets are compiled c# code from a module, faster

# Get Content
# Generially [System.IO.Read] will be faster than Get-Content


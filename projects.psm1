# This file is built to be generic MAIN for a powershell module
# it prints out what was loaded
# it exposes all functions within .ps1 files inside the Public folder
# all functions in public and private are globally available to eachother within
#  ^ be careful of function naming clashes, they're in the same 'namespace'

#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import file $($import.fullname): $_"
    }
}

# This pulls out the function names within the public folder
$PublicFunctions = sls -Path $public -Pattern '^function' |%{($_.Line -split '\s+')[1]} | sort

Export-ModuleMember -Function $PublicFunctions -Alias *

[string[]] $helps = $PublicFunctions |%{man $_ | select -skip 5 -first 1 | %{$_.trim()} } 

# Write out info on imported methods
Write-Host "IMPORTED" (Split-Path $PSScriptRoot -Leaf) -ForegroundColor cyan
$i = 0
$PublicFunctions | %{
  Write-Host "  $_" -ForegroundColor White
  if(!($helps[$i] -match "^$_") )
  {
      Write-Host ("  | " + $helps[$i]) -ForegroundColor Gray
  }
  $i++
  #Write-Host ((man $_) | select -skip 5 -first 1 | %{$_.trim()})
  # Write Known Alias
  foreach ($alias in @(get-alias -definition $_ -ErrorAction Ignore).Name)
  {
    write-host "  | alias: $alias" -ForegroundColor Gray
  }
}
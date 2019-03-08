function Get-Projects
{
  ls "$PSScriptRoot\..\..\Projects\" -Directory |% {$_.Name}
}
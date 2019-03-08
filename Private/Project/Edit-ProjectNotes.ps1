function Edit-ProjectNotes
{
  param(
    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({@(Get-Projects) -contains $_})]
    [string] $ProjectName
  )

  vi "$PSScriptRoot\..\..\Projects\$ProjectName\notes.ls"
}
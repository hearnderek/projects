function Edit-ProjectTasks
{
  param(
    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({@(Get-Projects) -contains $_})]
    [string] $ProjectName
  )

  emacs "$PSScriptRoot\..\..\Projects\$ProjectName\tasks.ls"
}
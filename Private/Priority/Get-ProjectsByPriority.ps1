function Get-ProjectsByPriority
{
  [string[]] $projects = Get-Projects
  [string[]] $priority = Get-Priority

  [string[]] $missingProjects =  $projects |? {$priority -notcontains $_}
  [string[]] $union = $priority + $missingProjects 
  return $union |? {$_}
}
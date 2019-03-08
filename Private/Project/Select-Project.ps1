function Select-Project
{
  [string[]] $projects = Get-ProjectsByPriority
  if($projects.length -eq 0)
  {
    return;
  }

  if($projects.length -eq 1)
  {
    return $projects[0];
  }
  
  Write-Projects
  [int]$index = read-host "Enter Project Index"

  $selectedProject = $projects[$index]
  return $selectedProject
}
function Read-Priority
{
  $string = Get-ProjectsByPriority -join "`n"
  $string | Out-File -FilePath (Get-PriorityFile)
  
  vi (Get-PriorityFile)
}

function Write-Projects
{
  write-host "Projects ---" -ForegroundColor green
  Get-ProjectsByPriority | %{$i=0}{
    write-host "[$i] " -ForegroundColor Yellow -NoNewline 
    write-host "$_" -ForegroundColor white
    $i++
  }
}
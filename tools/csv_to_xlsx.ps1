param(
    [Parameter(Mandatory=$true)]
    [string]$CsvPath,
    [Parameter(Mandatory=$true)]
    [string]$XlsxPath
)

# Ensure paths are full
$CsvFull = [System.IO.Path]::GetFullPath($CsvPath)
$XlsxFull = [System.IO.Path]::GetFullPath($XlsxPath)

# Create Excel COM object (requires Excel installed)
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

try {
    $wb = $excel.Workbooks.Open($CsvFull)
    # 51 = xlOpenXMLWorkbook (.xlsx)
    $wb.SaveAs($XlsxFull, 51)
}
finally {
    if ($null -ne $wb) { $wb.Close($false) }
    if ($null -ne $excel) { $excel.Quit() }
    if ($null -ne $wb) { [System.Runtime.InteropServices.Marshal]::ReleaseComObject($wb) | Out-Null }
    if ($null -ne $excel) { [System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null }
}

Write-Output "Saved: $XlsxFull"
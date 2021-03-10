#Modified from https://gist.github.com/jsmcnair/d852258509e4c75751ffebf35e9947a5


function ScreenShot1 {
    #Modified from https://www.reddit.com/r/PowerShell/comments/9y9689/take_a_screenshot_with_powershell/

    $File = '.\singleBench.bmp'

    Add-Type -AssemblyName System.Windows.Forms
    Add-type -AssemblyName System.Drawing

    # Gather Screen resolution information
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

    # Create bitmap using the top-left and bottom-right bounds
    $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height

    # Create Graphics object
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)

    # Capture screen
    $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size)

    # Save to file
    $bitmap.save($File)
    Write-Output "Screenshot saved to:"
    Write-Output $File
}

function ScreenShot2 {
    #Modified from https://www.reddit.com/r/PowerShell/comments/9y9689/take_a_screenshot_with_powershell/

    $File = '.\multiBench.bmp'

    Add-Type -AssemblyName System.Windows.Forms
    Add-type -AssemblyName System.Drawing

    # Gather Screen resolution information
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

    # Create bitmap using the top-left and bottom-right bounds
    $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height

    # Create Graphics object
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)

    # Capture screen
    $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size)

    # Save to file
    $bitmap.save($File)
    Write-Output "Screenshot saved to:"
    Write-Output $File
}

function Get-CinebenchScoreSingle {
    $cbfolder = "C:\Users\Jacob\Desktop\NerdCrap\Cinebench\CinebenchR23\"
    $cbpath = Join-Path $cbfolder "cinebench.exe"
    $log1 = ".\log1.txt"

    # Run cinebench
    Start-Process -FilePath "C:\Users\Jacob\Desktop\NerdCrap\Cinebench\CinebenchR23\cinebench.exe" -ArgumentList "g_CinebenchCpu1Test=true g_acceptDisclaimer=true" -RedirectStandardOutput $log1 -Wait
    #Take screen shot
    ScreenShot1

    return ((Get-Content $Log1 -Tail 5 |
        Where-Object { $_ -like "CB*" }) -split "Single-Benchmark ")[1]

}

function Get-CinebenchScoreDouble {
    $cbfolder = "C:\Users\Jacob\Desktop\NerdCrap\Cinebench\CinebenchR23\"
    $cbpath = Join-Path $cbfolder "cinebench.exe"
    $log2 = ".\log2.txt"
   
    # Run cinebench
    Start-Process -FilePath "C:\Users\Jacob\Desktop\NerdCrap\Cinebench\CinebenchR23\cinebench.exe" -ArgumentList "g_CinebenchCpuXTest=true g_acceptDisclaimer=true" -RedirectStandardOutput $log2 -Wait
    #Take ScreenShot
    ScreenShot2




  return ((Get-Content $Log2 -Tail 5 |
        Where-Object { $_ -like "CB*" }) -split "Multi-BenchMark ")[1]
}

 Get-CinebenchScoreSingle
 Get-CinebenchScoreDouble

cineBenchHW.ps1 > output.txt
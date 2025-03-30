# First part is just initializing stuff

using namespace System.Collections.Generic # Initializing Lists

# Constants here
$scriptModes = @(1, 2, 3) # 1 is for Station Tracker, 2 is for Child ID Maker, 3 is for Inventory Checker
$childIdModes = @(1, 2) # 1 is for creating Child IDs and then displaying a list to send to someone else, 2 is for printing an existing list, 3 is for 1 then 2 sequentially
$childIdCreatorModes = @(1, 2) # 1 is for Normal Mode, 2 is for Quick Mode
$inputTypes = @(1, 2) # 1 is for IDs, 2 is for Numbers-within-a-range

# Define paths
$dllDir = "$PSScriptRoot\Lib"
$driverDir = "$PSScriptRoot\Drivers"

# Create directories if they don't exist
if (-not (Test-Path $dllDir)) { New-Item -ItemType Directory -Path $dllDir }
if (-not (Test-Path $driverDir)) { New-Item -ItemType Directory -Path $driverDir }

# Download Selenium DLLs
# Add part here to check if there are already working Selenium DLLs
$seleniumNuGetUrl = "https://www.nuget.org/api/v2/package/Selenium.WebDriver/4.10.0"
$tempZip = "$env:TEMP\selenium.zip"
Invoke-WebRequest -Uri $seleniumNuGetUrl -OutFile $tempZip
Expand-Archive -Path $tempZip -DestinationPath "$env:TEMP\selenium" -Force
Copy-Item -Path "$env:TEMP\selenium\lib\net45\WebDriver.dll" -Destination "$dllDir\WebDriver.dll"
Copy-Item -Path "$env:TEMP\selenium\lib\net45\WebDriver.Support.dll" -Destination "$dllDir\WebDriver.Support.dll"
Remove-Item -Path $tempZip -Force
Remove-Item -Path "$env:TEMP\selenium" -Recurse -Force

# Download EdgeDriver
# Add part here to check if there is already a working EdgeDriver
$edgeVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo.ProductVersion
$majorVersion = $edgeVersion.Split('.')[0]
$driverUrl = "https://msedgedriver.azureedge.net/$majorVersion.0.0.0/edgedriver_win64.zip"
$tempZip = "$env:TEMP\edgedriver.zip"
Invoke-WebRequest -Uri $driverUrl -OutFile $tempZip
Expand-Archive -Path $tempZip -DestinationPath $driverDir -Force
Remove-Item -Path $tempZip -Force

# Load Selenium DLLs
Add-Type -Path "$dllDir\WebDriver.dll"
Add-Type -Path "$dllDir\WebDriver.Support.dll"

# Start EdgeDriver
$service = [OpenQA.Selenium.Edge.EdgeDriverService]::CreateDefaultService($driverDir)
$options = New-Object OpenQA.Selenium.Edge.EdgeOptions
$driver = New-Object OpenQA.Selenium.Edge.EdgeDriver($service, $options)

# Actual logic starts here-----

# Functions 

function InputChecker {
    param (
        $uncheckedInput,
        $inputType
    )

}

function LogInHandler {
    param (

    )

}

function FormFiller {
    param (
        $formData,
        $targetField
    )

}

function InfoGet {
    param (
        $targetData
    )
}

<# 
    Open website and handle log in
        Will have to make a temporary version that just opens the HTML file for the dummy site
        Also should make and comment a verstion that just goes to a link for a real website
    How programatic can logins be? 
        Do I have to open the website and ask the user to do it? 
            If so, this probably can't be headless, and there needs to be logic to detect when someone logs in/is logged in
        Could I log in for them?
            Maybe perform some action that pulls up autofill?
                Like in browsers when you click a login menu. Can Selenium do this? Could it be headless?
                    If it could, what if there's more than one saved password?
                        I could probably ask the user to choose
            Maybe I can directly access their saved edge passwords?
                Would this be illegal?
            What if user doesn't have saved credentials?
                Probably couldn't make this headless if they don't. Don't wanna make both a headless and non-headless version, might get complicated
    TODO: Figure this shit out 
 #>

# Main logic flow
 
# Prompt user for intended usage
$scriptMode = Read-Host "What part of the script would you like to use?'n'n'tEnter 1 for Station Tracker'n'n'tEnter 2 for Child ID handler'n'n'tEnter 3 for Inventory Checker'n"

# Case switch statement to determine which function of the script will be used in this window
switch ($scriptMode) {
    # Station Tracker
    $scriptModes[0] {

    }

    # Child ID Handler
    $scriptModes[1] {
        $childIdMode = Read-Host "Would you like to:'n'n't1. Create children'n'n't2. Print an existing list of labels'n'n"

        switch ($childIdMode) {
            # Child ID Creator
            $childIdModes[0] {

                
            }

            # Label printer
            $childIdModes[1] {

            }
        }
        $parentID = Read-Host "Enter the Parent ID: "
        $serialNums = Read-Host "Please enter the Serial Numbers separated by spaces:'n" -split
        $childIdCreatorMode = Read-Host "Enter 1 for Normal Mode'n'nEnter 2 for Quick Mode'n"
    }

    # Inventory Checker
    $scriptModes[2] {

    }
}
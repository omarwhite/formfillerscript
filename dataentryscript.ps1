# First part is just initializing stuff

# Global variables here
$StationTrackerMode = 1
$ChildIDMode = 2

# Define paths for necessary dependencies
$dllPath = "$PSScriptRoot\Lib"
$edgeDriverPath = "$PSScriptRoot\Drivers\msedgedriver.exe"

# Load Selenium DLLs
Add-Type -Path "$dllPath\WebDriver.dll"
Add-Type -Path "$dllPath\WebDriver.Support.dll"

# Start EdgeDriver service
$service = [OpenQA.Selenium.Edge.EdgeDriverService]::CreateDefaultService($edgeDriverPath)
$service.HideCommandPromptWindow = $true  # Hide the console window

# Configure Edge options
$options = New-Object OpenQA.Selenium.Edge.EdgeOptions
$options.AddArgument("--headless")  # Do I want this to be headless? Maybe only part of it?

# Actual logic starts here-----

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

# Prompt user for intended usage
$ScriptMode = Read-Host "What part of the script would you like to use? 'r'nEnter 1 for Station Tracker'r'nEnter 2 for Child ID creation"
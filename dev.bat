@echo off
setlocal
setlocal enabledelayedexpansion

@rem Declare variable
set VENV=%cd%\cache\venv

@rem Create python virtual environment
python -m venv %VENV%

@rem Install packaga
%VENV%\Scripts\pip install -r requirements.txt
%VENV%\Scripts\pip list

@rem endlocal before start python virtaul environmnet
endlocal
endlocal enabledelayedexpansion

@rem Startup python virtual environment
call %VENV%\Scripts\activate.bat

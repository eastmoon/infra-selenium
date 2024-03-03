@echo off

@rem Declare variable
set VENV=%cd%\cache\venv

@rem Create python virtual environment
python -m venv %VENV%

@rem Install packaga
%VENV%\Scripts\pip install -r requirements.txt
%VENV%\Scripts\pip list

@rem Execute demo script with python virtual environment
%VENV%\Scripts\python %cd%\src\demo.py

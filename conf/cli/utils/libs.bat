@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:common-up-docker-prepare
    echo ^> Build docker compose environment file
    @rem Create .env for compose
    echo Current Environment %PROJECT_ENV%
    echo PROJECT_NAME=%PROJECT_NAME% > %CONF_FILE_PATH%

    @rem Setting ocelot project and cache directory
    set TARGET_DIR=%CLI_DIRECTORY%\cache\video
    IF NOT EXIST %TARGET_DIR% (
        mkdir %TARGET_DIR%
    )
    echo VIDEO_CACHE_PATH=%TARGET_DIR% >> %CONF_FILE_PATH%

    goto end

@rem ------------------- End method-------------------

:end

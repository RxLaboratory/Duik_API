@echo off
REM build reference
echo Building reference
cmd /c jsdoc -c jsdoc_conf.json
xcopy /Y ..\docs\reference\Duik.html ..\docs\reference\index.html
echo Reference built
REM add CSS
xcopy /Y jsdoc.css ..\docs\reference
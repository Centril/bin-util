@ECHO OFF
SET RealCMDPath=git config --global

SET cmdparams=%1
shift
:addparams
SET cmdparams=%cmdparams% %1
SHIFT
IF NOT %1.==. GOTO addparams

:runcmd
%RealCMDPath% %cmdparams%

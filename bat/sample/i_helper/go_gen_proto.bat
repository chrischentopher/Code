REM 协议合并助手，拷贝协议到指定目录（svn先更新该目录）且生成pb文件，最后打开目录，暂不做自动提交
echo off
set branch_name=%1
set svn_path=D:\Projects\branch_code\project_I\branch_%branch_name:~0,-4%
start %svn_path%
cd %svn_path%
svn up
copy /Y %2 %svn_path%\Tools\protocol_buffers\protos\PB\net_common.proto
cd %svn_path%\Tools\protocol_buffers
call gen.bat

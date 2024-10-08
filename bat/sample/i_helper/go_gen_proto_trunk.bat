REM 协议合并助手，拷贝协议到指定目录（svn先更新该目录）不生成pb文件（trunk需要筛选），最后打开protocol_buffers目录
echo off
set trunk_path=F:\trunk
set pro_path=%trunk_path%\Tools\protocol_buffers
cd %pro_path%
svn up
copy /Y "%1" %pro_path%\protos\PB\net_common.proto
start %pro_path%
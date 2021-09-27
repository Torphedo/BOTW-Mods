@echo off
del PatchedRPX\*.rpx
mkdir PatchedRPX
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/0CBH0/wiiurpxtool/releases/latest ^| find "browser_download_url"') do (
    curl -kL -s -o wiiurpxtool.zip %%B
)
powershell -command "Expand-Archive wiiurpxtool.zip ."
del wiiurpxtool.zip
wiiurpxtool -d U-King.rpx PatchedRPX\U-King-decompressed.rpx
curl -s -o xdelta.exe https://raw.githubusercontent.com/marco-calautti/DeltaPatcher/master/xdelta.exe
for %%x in (%*) do (
   xdelta -d -n -s PatchedRPX\U-King-decompressed.rpx "%%~x" PatchedRPX\U-King-decompressed-patched.rpx
   del PatchedRPX\U-King-decompressed.rpx
   ren PatchedRPX\U-King-decompressed-patched.rpx U-King-decompressed.rpx
)
del xdelta.exe
wiiurpxtool -c PatchedRPX\U-King-decompressed.rpx PatchedRPX\U-King.rpx
del wiiurpxtool.exe
del PatchedRPX\U-King-decompressed.rpx
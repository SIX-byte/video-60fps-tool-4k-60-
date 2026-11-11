@echo off
setlocal
chcp 65001 >nul

set INPUT_VIDEO=input.mp4

echo [1/4] 正在提取原视频帧和音频...
if exist frames_in rd /s /q frames_in
if exist frames_out rd /s /q frames_out
mkdir frames_in
mkdir frames_out

ffmpeg -y -i "%INPUT_VIDEO%" -qscale:v 1 -qmin 1 -qmax 1 frames_in/frame_%%08d.png
ffmpeg -y -i "%INPUT_VIDEO%" -vn -acodec copy audio.aac

if not exist frames_in\frame_00000001.png (
    echo 【错误】视频拆帧失败，请检查 ffmpeg 是否正常！
    pause
    exit /b
)

echo [2/4] 正在使用核显进行 RIFE 2x 补帧 (30帧补到60帧)...
rife-ncnn-vulkan.exe -i frames_in -o frames_out -m rife-v4.6

if not exist frames_out\00000001.png (
    echo 【错误】补帧未生成图片，请检查 rife-ncnn-vulkan.exe 与模型文件夹是否在当前目录！
    pause
    exit /b
)

echo [3/4] 正在压制合成 60fps 最终视频...
ffmpeg -y -r 60 -i frames_out/%%08d.png -i audio.aac -c:v libx264 -crf 18 -pix_fmt yuv420p -c:a aac -shortest "output_60fps.mp4"

echo [4/4] 清理临时图片...
rd /s /q frames_in frames_out
if exist audio.aac del audio.aac

echo =====================================
echo 处理大功告成！生成文件为：output_60fps.mp4
echo =====================================
pause
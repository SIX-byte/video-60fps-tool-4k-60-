# Lightweight Video 60FPS Frame Interpolator

基于 RIFE-ncnn-vulkan 与 FFmpeg 的轻量级视频补帧/画质优化工具，利用 Vulkan API 实现核显/低配电脑的平滑 60fps 转换。

## 快速开始

1. 下载依赖工具：
   - [FFmpeg](https://www.gyan.dev/ffmpeg/builds/)
   - [rife-ncnn-vulkan](https://github.com/nihui/rife-ncnn-vulkan/releases)
2. 将 `ffmpeg.exe`、`rife-ncnn-vulkan.exe` 和模型文件夹解压放置在本项目根目录。
3. 把要处理的视频重命名为 `input.mp4`。
4. 双击运行 `run_fix.bat`，等待生成 `output_60fps.mp4`。

## 致谢与依赖 (Credits)
- [rife-ncnn-vulkan](https://github.com/nihui/rife-ncnn-vulkan) by @nihui
- [RIFE](https://github.com/megvii-research/ECCV2022-RIFE)
- [FFmpeg](https://ffmpeg.org/)

## 开源协议
[MIT License](LICENSE)

#!/bin/sh

# === 配置区域 ===
# 目标路径
DEST_PATH="/tmp/config.yaml"

# 你指定的配置文件的原始 GitHub Raw 地址
# 注意：这里必须是 raw 地址，不能是 blob 地址
TARGET_URL="https://raw.githubusercontent.com/qq540187000/bin7788/2fd950051ead4a95ef0c1994a5887363309ec9c7/config.yaml"

# 使用 ghproxy 代理加速下载 (解决国内无法连接 GitHub 问题)
PROXY_URL="https://ghproxy.net/"
FINAL_URL="${PROXY_URL}${TARGET_URL}"

# === 开始执行 ===
echo "正在下载配置文件..."

# 判断系统只有 wget 还是 curl，并执行下载
# -k / --no-check-certificate 用于忽略路由器的 SSL 证书错误
if command -v curl >/dev/null 2>&1; then
    curl -L -k -o "$DEST_PATH" "$FINAL_URL"
    STATUS=$?
else
    wget --no-check-certificate -O "$DEST_PATH" "$FINAL_URL"
    STATUS=$?
fi

# === 结果验证 ===
if [ $STATUS -eq 0 ] && [ -s "$DEST_PATH" ]; then
    echo "✅ 成功！配置文件已下载至: $DEST_PATH"
    ls -lh "$DEST_PATH"
else
    echo "❌ 失败！请检查网络连接。"
    exit 1
fi

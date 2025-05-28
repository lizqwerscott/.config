#!/bin/bash

# 检查 xrandr 是否可用
if type "xrandr" >/dev/null; then
  # 获取主显示器名称（标记为 "primary" 的）
  PRIMARY=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

  # 获取其他已连接的非主显示器（按连接顺序，取第一个）
  SECONDARY=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1 | head -n1)

  # 在主显示器启动 main bar
  if [ -n "$PRIMARY" ]; then
    MONITOR=$PRIMARY polybar main &
    echo "主显示器 $PRIMARY 启动 main bar"
  fi

  # 在第二显示器启动 secondary bar（如果存在且不是主显示器）
  if [ -n "$SECONDARY" ] && [ "$SECONDARY" != "$PRIMARY" ]; then
    MONITOR=$SECONDARY polybar secondary &
    echo "第二显示器 $SECONDARY 启动 secondary bar"
  fi
else
  # 如果没有 xrandr，回退到单显示器模式
  polybar main &
fi

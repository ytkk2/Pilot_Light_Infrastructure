#!/bin/bash

URL="http://tokyo-web-alb-734063537.ap-northeast-1.elb.amazonaws.com"

# 1秒に2回のリクエストを60秒間実行
for i in {1..60}; do
  for j in {1..2}; do
    curl -s $URL > /dev/null &
  done
  sleep 1
done


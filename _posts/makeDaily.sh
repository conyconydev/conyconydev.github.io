#!/bin/sh
if [ $# -eq 0 ]; then
	echo "use >> makePost [포스트이름]"
	exit
fi

date="$(date +%Y-%m-%d)"
time="$(date +%H:%M:%S)"

file_name="$date-$1.md"

echo "---
layout: post
title:  $1
date:  $date $time
category: daily
tags: [태그명, ]
---
" > $file_name

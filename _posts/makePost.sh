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
category: post
tags: [(swift,ios,etc,memo,study), 서브 태그명(부연설명)]
---

<pre><code class="swift">
//소스코드 작성.
// class = "사용 언어" -> 큰 따옴표 꼭 다시 확인해서 붙이기 큰따옴표가 없으면 인식안됨
// class = "plaintext"  -> 그냥 텍스트 상자일 경우 이걸 사용할꺼다.
</code></pre>
" > $file_name

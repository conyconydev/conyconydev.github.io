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
// class = "사용 언어"
// class = "plaintext"
</code></pre>
" > $file_name

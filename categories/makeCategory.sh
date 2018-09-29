#!/bin/sh
if [ $# -eq 0 ]; then
	echo "use >> makeCategory [카테고리이름]"
	exit
fi

echo "---
layout: page
title: $1
---

<div class=\"tags-expo\">
	<div class=\"tags-expo-list\">
		<a href=\"{{ site.url }}/categories/\" class=\"post-tag\">All Categories</a>
		{% for tag in site.categories %}
			<a href=\"../{{ tag[0] | slugify }}\" class=\"post-tag\">{{ tag[0] }}</a>
		{% endfor %}
	</div>
	<hr/>
	<div class=\"tags-expo-section\">
		<ul class=\"tags-expo-posts\">
			{% for post in site.categories.$1 %}
				<a class=\"post-title\" href=\"{{ site.baseurl }}{{ post.url }}\">
					<li>
						{{ post.title }}
						<small class=\"post-date\">{{ post.date | date_to_string }}</small>
					</li>
				</a>
			{% endfor %}
		</ul>
	</div>
</div>" > $1.html

echo "> 카테고리 파일이 생성되었습니다."
echo "> 추가하려는 카테고리를 로컬에서 확인하려면 Jekyll 서버를 다시 실행해야 합니다."
echo "> 생성된 카테고리 파일을 \"깃허브-프로젝트파일/categories/\"에 추가해주세요."
echo "> 카테고리 파일을 추가한 후 _config.yml의 파일을 nav의 Categories 부분에 다음과 같이 추가해주세요."
echo "----------------------------------------------------------------------"
echo "  nav:"
echo "    Home:"
echo "      - '/'"
echo "    Categories:"
echo "      ..."
echo "      - { $1: '/categories/$1.html/' }"
echo "      ..."
echo "    Github Project:"
echo "      ..."
echo "----------------------------------------------------------------------"

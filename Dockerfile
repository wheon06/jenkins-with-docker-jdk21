# Jenkins LTS + JDK 21 베이스 (공식 태그)
FROM jenkins/jenkins:lts-jdk21

USER root

# 필수 유틸
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl gnupg lsb-release git \
 && rm -rf /var/lib/apt/lists/*

# Docker 공식 APT 리포지토리 추가
RUN install -m 0755 -d /etc/apt/keyrings \
&& curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo $ID)/gpg \
   | tee /etc/apt/keyrings/docker.asc > /dev/null \
&& chmod a+r /etc/apt/keyrings/docker.asc \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
   https://download.docker.com/linux/$(. /etc/os-release; echo $ID) \
   $(. /etc/os-release; echo $VERSION_CODENAME) stable" \
   > /etc/apt/sources.list.d/docker.list

# Docker CLI + Compose v2 플러그인 설치 (엔진은 설치 X, 호스트의 docker.sock 사용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-ce-cli docker-compose-plugin \
 && rm -rf /var/lib/apt/lists/*

 # docker 그룹에 jenkins 사용자 추가 (소켓 권한 이슈 예방)
 RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

USER jenkins

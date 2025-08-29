# 실행 (호스트 도커 데몬 사용을 위해 소켓 마운트 필수)
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-with-docker-jdk21

# 先选择maven基础镜像作为编译服务镜像
# 3.6.3-springboot2.1 用的是本人自定义的maven镜像, 有空的话这个会继续更新
# 3.6.3指的是maven版本(已经修改settings.xml指向阿里镜像库), springboot2.1指的是镜像已经包含springboot2.1的基础依赖
FROM wangxgh/maven:3.6.3-springboot2.1 AS builder
# 源码添加
ADD . /app
WORKDIR /app
# 在基础镜像中进行操作  maven打包编译 --> 删除多余文件夹 --> 查看操作结果
RUN mvn clean package -Dmaven.test.skip=true \
  && cd target \
  && rm -rf classes \
  && rm -rf generated-sources \
  && rm -rf maven-archiver \
  && rm -rf maven-status \
  && rm -rf *.jar \
  && ls -l

# 最终执行制作的镜像
FROM openjdk:8u92-alpine
# 声明作者
MAINTAINER xiaogangWang0612
# 从基础镜像中拷贝制作内容
COPY --from=builder /app/target/ /app/server/
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /usr/share/zoneinfo/Asia/Shanghai
WORKDIR /app/server/
# 准备工作  时区修正 --> 查看验证拷贝内容
RUN rm -f /etc/localtime \
  && ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && ls -l
# 暴露8000端口
EXPOSE 8000
# 启动执行命令, 不推荐nohup启动, 直接启动方便使用docker命令或者辅助软件查看日志
ENTRYPOINT ["java","-jar","apps/application.jar"]

Docker部署基于Nodejs的Web应用

vue init nuxt-community/koa-template

在你的项目根目录下，添加Dockerfile文件内容如下
# 指定我们的基础镜像是node，版本是v8.0.0
 FROM node:8.0.0
 # 指定制作我们的镜像的联系人信息（镜像创建者）
 MAINTAINER EOI

 # 将根目录下的文件都copy到container（运行此镜像的容器）文件系统的app文件夹下
 ADD . /app/
 # cd到app文件夹下
 WORKDIR /app

 # 安装项目依赖包
 RUN npm install
 RUN npm rebuild node-sass --force

 # 配置环境变量
 ENV HOST 0.0.0.0
 ENV PORT 8000

 # 容器对外暴露的端口号
 EXPOSE 8000

 # 容器启动时执行的命令，类似npm run start
 CMD ["npm", "start"]

在项目根目录下添加.dockerignore文件，此文件的作用类似.gitignore文件，可以忽略掉添加进镜像中的文件，写法、格式和.gitignore一样，一行代表一个忽略。
 .DS_Store
  npm-debug.log*
  selenium-debug.log
  .nuxt/
  /package-lock.json
  *.tar
  *.md

  # Editor directories and files
  .idea
  *.suo
  *.ntvs*
  *.njsproj
  *.sln

构建镜像cd 到项目根目录下，执行以下命令
docker build -t deploy:1.0 .   deploy是镜像名，1.0是镜像的版本号，到此你已经成功构建了一个新的镜像，你可以通过docker images，查看你的镜像。（注意后面还有一个.）

启动镜像，测试是否成功。
docker run -d -p 9000:8000 deploy:1.0

上传镜像
docker login --username=lswleecc --password=qweqwe123... registry.cn-zhangjiakou.aliyuncs.com

docker tag <name:tag> <namespace>/<name:tag>上传之前必须给镜像打上tag，namespace可以指定为你的docker Id
docker tag [ImageId] registry.cn-zhangjiakou.aliyuncs.com/lswleecc/docker-damon:[镜像版本号]

docker push <namespace>/<name:tag>将镜像上传至docker的公共仓库
docker push registry.cn-zhangjiakou.aliyuncs.com/lswleecc/docker-damon:[镜像版本号]

通过docker pull <namespace>/<name:tag>下载我们的镜像。
docker pull registry.cn-zhangjiakou.aliyuncs.com/lswleecc/docker-damon:[镜像版本号]



pull下来镜像后通过docker run -d -p 9000:8000 deploy:1.0中-d表示后台运行，-p 9000:8000表示指定本地的9000端口隐射到容器内的8000端口。 deploy:1.0为我们要运行的镜像。

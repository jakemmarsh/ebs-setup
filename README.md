# ebs-setup

Custom build hooks and scripts for Elastic Beanstalk:

- Optimizing NPM dependency installation, inspired by [this](http://stackoverflow.com/a/21260702/880859) StackOverflow anwer
- Customizing nginx proxy settings
- Installing and starting redis-server

## Usage

In order to use these build hooks in your application, all you need to do is add the following `env.config` file in a `.ebextensions/` directory in the root of your project:

```yaml
packages:
  yum:
    git: []
    gcc: []
    gcc-c++: []
    libxml2: []
    libxml2-devel: []
    make: []
    openssl-devel: []

option_settings:
  - option_name: NODE_ENV
    value: production
  - namespace: aws:elasticbeanstalk:container:nodejs
    option_name: NodeVersion
    value: 4.3.0

files:
  "/tmp/deployment/config/etc#nginx#nginx.conf" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/nginx.conf
  "/opt/elasticbeanstalk/env.vars" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/env.vars
  "/opt/elasticbeanstalk/hooks/configdeploy/pre/40install_node.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/predeploy/40install_node.sh
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/50npm.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/predeploy/50npm.sh
  "/opt/elasticbeanstalk/hooks/configdeploy/pre/50npm.sh" :
    mode: "000666"
    owner: root
    group: users
    content: |
       #no need to run npm install during configdeploy
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/40install_node.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/predeploy/40install_node.sh
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/70install_redis.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/predeploy/70install_redis.sh
  "/opt/elasticbeanstalk/hooks/appdeploy/post/00redis_server.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/postdeploy/00redis_server.sh
```

# ebs-build-hooks

Custom build hooks for Elastic Beanstalk for optimizing NPM dependency installation, inspired by [this](http://stackoverflow.com/a/21260702/880859) StackOverflow anwer.

## Usage

In order to use these build hooks in your application, all you need to do is add the following `env.config` file in a `.ebextensions/` directory in the root of your project:

```yaml
packages:
  yum:
    git: []
    gcc: []
    make: []
    openssl-devel: []

option_settings:
  - option_name: NODE_ENV
    value: production
  - namespace: aws:elasticbeanstalk:container:nodejs
    option_name: NodeVersion
    value: 0.12.7

files:
  "/opt/elasticbeanstalk/hooks/configdeploy/pre/40install_node.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-build-hooks/master/40install_node.sh
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/50npm.sh" :
    mode: "000775"
    owner: root
    group: users
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-build-hooks/master/50npm.sh
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
    source: https://raw.githubusercontent.com/jakemmarsh/ebs-build-hooks/master/40install_node.sh
```

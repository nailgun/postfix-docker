# postfix-docker

Lightweight [highly configurable](http://www.postfix.org/postconf.5.html) postfix image
based on Alpine.


## Usage

```
docker run -p 25:25 nailgun/postfix -e myhostname=mail.example.com mynetworks=0.0.0.0/0 
```

All arguments are passed to [postconf](http://www.postfix.org/postconf.1.html) utility
(`-e myhostname=mail.example.com mynetworks=0.0.0.0/0` from example above).

postconf also can be run multiple times before starting the server, just split arguments
with colon `:`, e.g.

```
docker run -p 25:25 nailgun/postfix -e myhostname=mail.example.com : -e mynetworks=0.0.0.0/0 
```

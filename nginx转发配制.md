# 内部重定向
    location /old-path {
        #internal进行内部重定向
        internal;
        proxy_pass http://backend-server/new-path;
    }
# 59法议
## 律所页
```
    location /law-firm { 
        proxy_pass http://127.0.0.1:5898/law-firm;
    }
```
## 律师页
```
    location /lawyer { 
        proxy_pass http://127.0.0.1:5898/lawyer;
    }
```

# 正则表达式匹配 URL
` 
server {
    listen 80;

    location ~* ^/old-path/(.*)$ {
        set $target "/new-path/$1";
        proxy_pass http://backend-server$target;
    }
}
`

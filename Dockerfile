FROM nginx:alpine

WORKDIR /tmp/pwdashboard/

COPY . .

RUN mv -f config/default.conf /etc/nginx/conf.d/

RUN apk add nodejs && \
    apk add npm && \
    npm install && \
    npm run build && \
    apk del npm && \
    apk del nodejs

WORKDIR /tmp/

RUN rm -rf /usr/share/nginx/html/ && \
    mv pwdashboard/build/ /usr/share/nginx/html/ && \
    rm -rf pwdashboard/

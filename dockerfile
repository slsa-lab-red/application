FROM nginx:alpine

ARG TEAM="slsa-lab-red"
ARG COLOR="#D32F2F"

LABEL maintainer="slsa-lab@example.com"
LABEL team=${TEAM}

# Update packages to fix CVE-2025-58050
RUN apk update && apk upgrade pcre2 && rm -rf /var/cache/apk/*

RUN mkdir -p /usr/share/nginx/html
RUN printf '\
<!doctype html>\n\
<html lang="en">\n\
<head>\n\
  <meta charset="utf-8"/>\n\
  <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"/>\n\
  <title>%s</title>\n\
  <style>\n\
    html,body { height:100%%; margin:0; }\n\
    body {\n\
      background: %s;\n\
      display:flex; align-items:center; justify-content:center;\n\
      font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial;\n\
    }\n\
    h1 {\n\
      color: white;\n\
      font-size: 8vw;\n\
      text-shadow: 0 2px 6px rgba(0,0,0,0.4);\n\
      margin:0; padding: 10px 20px; border-radius: 8px; background: rgba(0,0,0,0.12);\n\
    }\n\
    @media (min-width:700px) { h1 { font-size: 64px; } }\n\
  </style>\n\
</head>\n\
<body>\n\
  <h1>%s</h1>\n\
</body>\n\
</html>\n' "${TEAM}" "${COLOR}" "${TEAM}" > /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
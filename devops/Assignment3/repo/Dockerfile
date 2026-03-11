# Base Image: nginx:alpine
FROM nginx:alpine

# Copy Files: index.html, style.css, image.jpg to correct locations in /usr/share/nginx/html/
COPY index.html style.css image.jpg /usr/share/nginx/html/

# Update Nginx to listen on port 8085
# Replacing 'listen       80;' with 'listen       8085;' in default.conf
RUN sed -i 's/listen       80;/listen       8085;/g' /etc/nginx/conf.d/default.conf

# Expose port 8085
EXPOSE 8085

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

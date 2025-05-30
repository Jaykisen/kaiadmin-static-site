# Use lightweight nginx image
FROM nginx:alpine

# Copy all site files into nginx's html folder
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Default command to run nginx
CMD ["nginx", "-g", "daemon off;"]

# Use an official Nginx image to serve the built Flutter web app
FROM nginx:alpine

# Copy the build output to the Nginx HTML directory
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

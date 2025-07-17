FROM 471112907169.dkr.ecr.us-east-1.amazonaws.com/node-base:latest
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 80

CMD ["npm", "start"]

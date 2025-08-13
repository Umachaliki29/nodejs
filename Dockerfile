FROM 471112907169.dkr.ecr.us-east-1.amazonaws.com/node-base@sha256:b2973ca2cd64fd171284647a65ba36ceb386feb9409a4df8d90f055922cd4f80
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 80

CMD ["npm", "start"]

const http = require('http');
const port = 80;
const server = http.createServer((req, res) => {
  res.end('Hello World from Node.js on Docker Swarm!');
});
server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

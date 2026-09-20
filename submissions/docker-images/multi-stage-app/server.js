const express = require("express");

const app = express();
const PORT = process.env.PORT || 8080;

app.get("/", (req, res) => {
  res.send(
    "<!doctype html><html><head><title>Multi-stage</title></head>" +
      "<body><h1>Hello World from Docker multi-stage build</h1></body></html>"
  );
});

app.listen(PORT, () => console.log(`Multi-stage app listening on port ${PORT}`));

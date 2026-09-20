const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("<!doctype html><html><body><h1>Hello World from Node.js!</h1></body></html>");
});

app.listen(PORT, () => console.log(`Node.js app listening on port ${PORT}`));

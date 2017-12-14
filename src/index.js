"use strict";

import "./styles.scss";
import "./index.html";

var Elm = require("./Main.elm");
var mountNode = document.getElementById("main");

const LS_KEY = "simple-elm-trello";

function readStoredData() {
  const serializedData = window.localStorage.getItem(LS_KEY);
  return serializedData ? JSON.parse(serializedData) : { boards: [] };
}

var app = Elm.Main.embed(mountNode, readStoredData());
app.ports.storeBoards.subscribe(function(boards) {
  window.localStorage.setItem(LS_KEY, JSON.stringify({ boards: boards }));
});

import "./index.css";
import { ElmApp } from "./ports";

const { Elm } = require("./Main.elm");

const app: ElmApp = Elm.Main.init({
  node: document.getElementById("app"),
  flags: {},
});

app.ports.log.subscribe((txt: string) => alert(txt));

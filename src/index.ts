import "./index.css";
import { ElmApp } from "./ports";
import { pure } from "./sui_types";

import { Transaction } from "@mysten/sui/transactions";
import { SuiClient, SuiHTTPTransport } from "@mysten/sui/client";

const { Elm } = require("./Main.elm");

const client = new SuiClient({
  transport: new SuiHTTPTransport({
    url: "https://fullnode.testnet.sui.io:443",
  }),
});

const app: ElmApp = Elm.Main.init({
  node: document.getElementById("app"),
  flags: {},
});

app.ports.log.subscribe((txt: string) => console.log(txt));

app.ports.dryRunTx.subscribe((params) =>
  (async () => {
    const tx = new Transaction();
    const xs = params.arguments.map(([a, b]) => pure(tx, a, b));
    tx.moveCall({
      target: params.functionPath,
      arguments: xs,
    });
    const res = await client.devInspectTransactionBlock({
      transactionBlock: tx,
      sender: "0x0",
    });
    console.log(res);
  })().catch(console.error)
);

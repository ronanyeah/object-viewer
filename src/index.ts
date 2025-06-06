import "./index.css";
import { ElmApp } from "./ports";
import { pure } from "./sui_types/util";
import * as reified from "./sui_types/reified";

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
      sender: params.packageId,
    });
    console.log(res.effects.status);
    if (res.error) {
      return console.log(res.error);
    }
    const data = (res.results || []).flatMap((x) => x.returnValues || []);
    console.log("returnValues:", data);
    for (const [bytes, tag] of data) {
      const decoder = reified.toBcs(tag as any);
      const unit = decoder.parse(new Uint8Array(bytes));
      console.log(tag, unit);
    }
  })().catch(console.error)
);

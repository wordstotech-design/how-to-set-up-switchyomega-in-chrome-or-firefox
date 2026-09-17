/**
 * SwitchyOmega setup: verify a proxy profile's credentials with Node,
 * independent of the browser extension.
 *
 * Match these values to what you entered in the SwitchyOmega profile's
 * Server, Port, and Authentication fields.
 *
 *     npm install https-proxy-agent node-fetch@2
 */

const { HttpsProxyAgent } = require("https-proxy-agent");
const fetch = require("node-fetch");

const USERNAME = "USERNAME";
const PASSWORD = "PASSWORD";
const GATEWAY = `http://${USERNAME}:${PASSWORD}@proxy-us.proxy-cheap.com:5959`;

async function check() {
  const agent = new HttpsProxyAgent(GATEWAY);
  const resp = await fetch("https://api.ipify.org?format=json", { agent });
  const data = await resp.json();
  console.log("Exit IP:", data);
}

check().catch((err) => console.error(err));

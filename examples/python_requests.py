"""
SwitchyOmega setup: verify a proxy profile's credentials from a script,
independent of the browser extension.

Match these values to what you entered in the SwitchyOmega profile's
Server, Port, and Authentication fields. A 407 response means the
credentials are wrong, a timeout usually means the wrong host or port,
or an IP whitelist that does not include your current address.

    pip install requests
"""

import requests

USERNAME = "USERNAME"
PASSWORD = "PASSWORD"
GATEWAY = f"http://{USERNAME}:{PASSWORD}@proxy-us.proxy-cheap.com:5959"


def check():
    resp = requests.get(
        "https://api.ipify.org?format=json",
        proxies={"http": GATEWAY, "https": GATEWAY},
        timeout=15,
    )
    resp.raise_for_status()
    print("Exit IP:", resp.json())


if __name__ == "__main__":
    check()

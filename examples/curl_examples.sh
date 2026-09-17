#!/usr/bin/env bash
# SwitchyOmega setup: verify proxy credentials outside the browser.
# Replace USERNAME and PASSWORD with the values from your dashboard.
# Useful when a SwitchyOmega profile does not seem to be routing traffic,
# since this bypasses the extension entirely and tests the proxy directly.

# Your real IP, no proxy
curl https://api.ipify.org; echo

# Through the rotating residential gateway (US), same host/port you would
# enter in a SwitchyOmega proxy profile
curl -x proxy-us.proxy-cheap.com:5959 -U USERNAME:PASSWORD https://api.ipify.org; echo

# EU gateway
curl -x proxy-eu.proxy-cheap.com:5959 -U USERNAME:PASSWORD https://api.ipify.org; echo

# SOCKS5 instead of HTTP, matching the protocol dropdown in a SwitchyOmega profile
curl --socks5 USERNAME:PASSWORD@proxy-us.proxy-cheap.com:5959 https://api.ipify.org; echo

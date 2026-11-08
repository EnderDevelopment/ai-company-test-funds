# Roblox Studio Test Money Script

AI Company Test Funds is a Roblox script for Studio-only economy testing. This Roblox server script gives players a large test balance, maintains the `Money` value during playtests, supports common Roblox value objects, and avoids changing balances in published game servers.

## Install

1. Open your game in Roblox Studio.
2. In Explorer, open `ServerScriptService`.
3. Insert a standard `Script`.
4. Copy the contents of `InfiniteTestMoney.server.lua` into the Script.
5. Keep the Script in `ServerScriptService`.
6. Start a Studio test session with Play, Play Here, or Start Server.

The script must run on the server. Do not place it in `StarterPlayerScripts`, `StarterGui`, or a `LocalScript`.

## Use

1. Start a Roblox Studio playtest.
2. The script finds `leaderstats.Money` for each player when available.
3. If no matching value exists, it creates `leaderstats.Money` as an `IntValue`.
4. The value is set to `2,000,000,000`.
5. If another server script changes the value during the test, the script restores it to the test amount.
6. To change the balance, edit `TEST_MONEY` near the top of the script.
7. To use a different value name, change `MONEY_NAME`, such as from `Money` to `Cash`.

The script supports `IntValue`, `NumberValue`, and `StringValue`. It runs only when `RunService:IsStudio()` returns true and exits immediately in published servers. It only works with Roblox `ValueBase` objects named `Money`; it does not modify money stored only inside an unrelated data table or module.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/9a30326d-444a-43cc-a2d5-2c19f63051b3?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=9a30326d-444a-43cc-a2d5-2c19f63051b3

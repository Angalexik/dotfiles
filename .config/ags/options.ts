import GLib from "gi://GLib?version=2.0";
import { createState } from "ags";
import { mkOptions } from "./util/option";
const configDir = GLib.get_user_config_dir();
const configFile = `${configDir}/my-dock/config.json`;

const config = mkOptions(configFile, {
  transparent: false,
  pinnedApps: ["firefox", "chromium"] as string[],
});

export default config;

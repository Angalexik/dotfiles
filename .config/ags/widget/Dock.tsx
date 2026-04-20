import app from "ags/gtk4/app";
import config from "../options";
import AstalNiri from "gi://AstalNiri";
import AstalApps from "gi://AstalApps";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { createBinding, createComputed, createState, For } from "ags";
import { execAsync } from "ags/process";
import { createPoll } from "ags/time";

const niri = AstalNiri.get_default();
const application = new AstalApps.Apps();

function findAppInfo(appId: string): AstalApps.Application | null {
  const searchTerm = appId.toLowerCase();
  const appList = application.get_list();

  for (const app of appList) {
    if (
      app.entry?.toLowerCase() === searchTerm ||
      app.iconName === appId ||
      app.name === appId ||
      app.wm_class === appId
    ) {
      return app;
    }
  }

  for (const app of appList) {
    if (app.entry?.toLowerCase().includes(searchTerm)) {
      return app;
    }
  }

  return null;
}

type DockApp = { appId: string; windows: AstalNiri.Window[] };

function AppButton({ appId, windows }: DockApp) {
  const appInfo = appId ? findAppInfo(appId) : null;
  const iconName = appInfo?.iconName ?? "question-round-outline";
  return (
    <overlay>
      <button
        class="AppButton flat"
        onClicked={() => {
          if (windows[0] !== undefined) {
            windows[0].focus(windows[0].id);
          } else {
            appInfo.launch();
          }
          const overview = niri.overview;
          if (overview.is_open) {
            overview.toggle(() => {});
          }
        }}
      >
        <image class="app-icon" iconName={iconName} pixelSize={64} />
      </button>
      <box
        $type="overlay"
        valign={Gtk.Align.END}
        halign={Gtk.Align.CENTER}
        spacing={5}
      >
        {windows.map((w) => {
          return <box class="indicator" width-request={5} height-request={5} />;
        })}
      </box>
    </overlay>
  );
}

export default function Dock(gdkmonitor: Gdk.Monitor) {
  const windows = createBinding(niri, "windows");
  const pinnedApps = createComputed(() => {
    return config.pinnedApps.map((appId) => {
      return {
        appId: appId,
        windows: windows().filter((w) => w.appId == appId),
      };
    });
  });
  const unpinnedApps = createComputed(() => {
    return windows()
      .filter((w) => !config.pinnedApps.includes(w.appId))
      .reduce((acc, curr) => {
        const thing = acc.find((x) => curr.appId && x.appId == curr.appId);
        if (thing !== undefined) {
          thing.windows.push(curr);
        } else {
          acc.push({ appId: curr.appId, windows: [curr] });
        }

        return acc;
      }, []);
  });
  const showSeparator = createComputed(() => {
    return unpinnedApps().length > 0;
  });

  const showDock = createBinding(niri.overview, "is_open");

  return (
    <window
      visible={showDock}
      name="dock"
      class="Dock"
      namespace="my-dock"
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      application={app}
      anchor={Astal.WindowAnchor.BOTTOM}
    >
      <box>
        <box>
          <For each={pinnedApps}>
            {({ appId, windows }) => {
              return <AppButton appId={appId} windows={windows} />;
            }}
          </For>
        </box>
        <Gtk.Separator visible={showSeparator}/>
        <box>
          <For each={unpinnedApps}>
            {({ appId, windows }) => {
              return <AppButton appId={appId} windows={windows} />;
            }}
          </For>
        </box>
      </box>
    </window>
  );
}

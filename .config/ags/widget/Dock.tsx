import app from "ags/gtk4/app";
import config from "../options";
import AstalNiri from "gi://AstalNiri";
import AstalApps from "gi://AstalApps";
import Gio from "gi://Gio";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { createBinding, createComputed, For } from "ags";

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

  // Open Windows (if open)
  // ----
  // Launch
  // ---
  // Launch things from desktop file (if applicable)
  // ---
  // Close (if open)
  // ---
  // Potentially pin/unpin
  const menuModel = new Gio.Menu();
  menuModel.append("Launch", "app.launch");
  // TODO: PopoverBin instead
  const rightClickMenu = (
    <Gtk.PopoverMenu
      $type="overlay"
      $constructor={() => Gtk.PopoverMenu.new_from_model(menuModel)}
    />
  );

  return (
    <overlay>
      <button
        class="AppButton flat"
        onClicked={() => {
          if (windows[0] !== undefined) {
            windows[0].focus(windows[0].id);
          } else {
            appInfo?.launch();
          }
          const overview = niri.overview;
          if (overview.is_open) {
            overview.toggle(() => {});
          }
        }}
      >
        <Gtk.GestureClick
          button={Gdk.BUTTON_SECONDARY}
          onPressed={(_source, _n_press, _x, _y) => {
            console.log("Right click!");
            rightClickMenu.popup();
          }}
        />
        <image class="app-icon" iconName={iconName} pixelSize={64} />
      </button>
      {rightClickMenu}
      <box
        $type="overlay"
        valign={Gtk.Align.END}
        halign={Gtk.Align.CENTER}
        spacing={5}
      >
        {windows.map((_) => {
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
      }, [] as DockApp[]);
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
        <Gtk.Separator visible={showSeparator} />
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

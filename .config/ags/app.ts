import app from "ags/gtk4/app";
import style from "./style.scss";
import Dock from "./widget/Dock";

app.start({
  css: style,
  main() {
    app.get_monitors().map(Dock);
  },
});

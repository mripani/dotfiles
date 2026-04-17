use std::env;
use std::fs::OpenOptions;
use std::io::{BufRead, BufReader, Write};
use std::os::unix::net::UnixStream;
use std::process::Command;
use std::thread;
use std::time::Duration;

fn main() {
    let runtime_dir = env::var("XDG_RUNTIME_DIR").expect("XDG_RUNTIME_DIR not set");
    let instance_sig =
        env::var("HYPRLAND_INSTANCE_SIGNATURE").expect("HYPRLAND_INSTANCE_SIGNATURE not set");
    let socket_path = format!("{runtime_dir}/hypr/{instance_sig}/.socket2.sock");
    let log_path = format!(
        "{}/.config/hypr/scripts/monitor_disconnect/monitor_disconnect.log",
        env::var("HOME").expect("HOME not set")
    );

    let stream = UnixStream::connect(&socket_path).expect("failed to connect to hyprland socket");
    let reader = BufReader::new(stream);

    for line in reader.lines() {
        let line = match line {
            Ok(l) => l,
            Err(_) => break,
        };
        if line.starts_with("monitorremoved>>") {
            let monitor = &line["monitorremoved>>".len()..];
            thread::sleep(Duration::from_millis(500));
            Command::new("hyprctl")
                .args(["dispatch", "forcerendererreload"])
                .status()
                .ok();

            let timestamp = Command::new("date")
                .arg("+%Y-%m-%d %H:%M:%S")
                .output()
                .ok()
                .and_then(|o| String::from_utf8(o.stdout).ok())
                .unwrap_or_default();
            let msg = format!(
                "[{}] monitor removed: {monitor}, renderer reloaded\n",
                timestamp.trim()
            );
            if let Ok(mut f) = OpenOptions::new().create(true).append(true).open(&log_path) {
                let _ = f.write_all(msg.as_bytes());
            }
        }
    }
}

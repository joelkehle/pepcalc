# pepcalc

A Python command-line tool for peptide concentration calculations and local
recordkeeping. It converts user-entered quantities into volume and syringe-unit
values, and tracks saved entries, vial inventory, supplies, suppliers, and schedules.

The calculator uses the quantities you enter. It does not choose a treatment or
determine whether a dose is appropriate.

## Features

- Concentration and volume calculations, including mg and mcg input.
- Saved entries with editable quantities and notes.
- Vial inventory, syringe and supply records, and supplier prices.
- Daily and weekly schedule views and course tracking.
- Local SQLite storage and a Windows standalone build option.

## Run from source

The CLI uses Python's standard library. Python 3.11 or later is a suitable starting
point; the Windows build also uses Python 3.11+.

```bash
python3 pepcalc --help
```

On Windows:

```powershell
py -3 pepcalc --help
```

Commands such as `mix` offer an interactive walkthrough. On macOS or Linux,
`bash install.sh` creates a `pepcalc` link in `~/.local/bin`; that directory must
be on your `PATH` to use the command by name.

See [Windows packaging](packaging/windows/README.md) to build a standalone
executable.

## Local data

- **Windows:** `%APPDATA%\pepcalc\pepcalc.db`, falling back to `%LOCALAPPDATA%`.
- **macOS/Linux:** `$XDG_CONFIG_HOME/pepcalc/pepcalc.db`, or
  `~/.config/pepcalc/pepcalc.db` when `XDG_CONFIG_HOME` is unset.

Keep personal records out of Git. The CLI can migrate its older `peptides.json`
format into SQLite when creating a new database.

## Development

The CLI tests live in [`tests/test_cli.py`](tests/test_cli.py). On Windows:

```powershell
py -3 -m unittest discover -s tests -v
```

The tests set a temporary Windows app-data path. When running them on Linux or
macOS, also point `XDG_CONFIG_HOME` at a temporary directory to keep test records
separate from your own data.

The Node.js files support the documentation index; they are not required to run
the Python CLI.

# Windows packaging

This builds a standalone `pepcalc.exe` that runs without Python installed.

## Prereqs
- Windows 10/11
- Python 3.11+ (from python.org, "Add Python to PATH" checked)

## Build
From repo root:

```powershell
powershell -ExecutionPolicy Bypass -File packaging/windows/build.ps1
```

Artifacts:
- `dist\pepcalc.exe`
- `pepcalc-windows.zip`

## If `py` isn't available

```powershell
powershell -ExecutionPolicy Bypass -File packaging/windows/build.ps1 -Python python
```

## Test

From repo root:

```powershell
py -3 -m unittest discover -s tests -v
```

The tests use a temporary app data folder and do not touch your saved peptides.

## Notes
- Data is stored at `%APPDATA%\pepcalc\pepcalc.db`.
- Older `%APPDATA%\pepcalc\peptides.json` data is migrated on first run.

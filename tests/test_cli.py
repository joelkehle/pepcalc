import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
PEPCALC = REPO_ROOT / "pepcalc"


class PepcalcCliTests(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.env = os.environ.copy()
        self.env["APPDATA"] = self.temp_dir.name
        self.env["PYTHONUTF8"] = "1"

    def tearDown(self):
        self.temp_dir.cleanup()

    def run_cli(self, *args, user_input=None):
        return subprocess.run(
            [sys.executable, str(PEPCALC), *args],
            cwd=REPO_ROOT,
            env=self.env,
            input=user_input,
            text=True,
            capture_output=True,
            check=False,
        )

    def assert_success(self, result):
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_reconstitution_calculation(self):
        result = self.run_cli("calc", "BPC-157", "5", "2", "250")

        self.assert_success(result)
        self.assertIn("Dose: 250mcg = 10 units", result.stdout)

    def test_active_course_view_uses_windows_safe_dates(self):
        self.assert_success(
            self.run_cli("save", "TestPeptide", "5", "2", "250")
        )
        self.assert_success(
            self.run_cli("course", "add", user_input="1\n\n\n\n\n\n")
        )
        self.assert_success(
            self.run_cli("course", "start", user_input="1\n\n")
        )

        result = self.run_cli("course")

        self.assert_success(result)
        self.assertIn("TestPeptide", result.stdout)
        self.assertIn("Day 1 of 30", result.stdout)


if __name__ == "__main__":
    unittest.main()

import urllib.request 
from pathlib import Path 

REPO = "lukebarousse/dbt_Analytics_Engineering_Course"
TAG = "dataset-v1"
BASE = f"https://github.com/{REPO}/releases/download/{TAG}"

MONTHS = ["2025-09","2025-10","2025-11","2025-12", "2026-01","2026-02","2026-03","2026-04","2026-05","2026-06"]

FILES = [f"raw_job_postings_{m}.parquet" for m in MONTHS] + ["raw_job_skills.parquet"]
print(FILES)

DATA_DIR = Path.cwd() / "data" / "raw"

if __name__ == "__main__":
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    for name in FILES : 
        dest_file = DATA_DIR / name 
        if dest_file.exists():
            print(f"    - already have file {dest_file}")
            continue 
        print(f"    - Downloading {name}...")
        urllib.request.urlretrieve(f"{BASE}/{name}", dest_file)
    print(f"Done. {len(FILES)} in {DATA_DIR}")
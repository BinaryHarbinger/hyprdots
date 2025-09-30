
import requests
import json
import os
import zipfile
import io
import shutil
from getpass import getuser

HOME = "/home/"+str(getuser())+"/"
CACHE_DIR = HOME+".cache/"

# -----------------------------
# Repository information
# -----------------------------
owner = "binaryharbinger"
repo = "binarydots"
api_base = f"https://api.github.com/repos/{owner}/{repo}"

# Default data structure
current_data = default_data = {
    "first_run": 0,
    "ID": "rolling",
    "latest_release": "",
    "update_later": 0,
}

# -----------------------------
# Load JSON data from file
# -----------------------------
def loadFile():
    try:
        with open('release_info.json', 'r') as file:
            data = json.load(file)
    except:
        data = default_data
    return data

# -----------------------------
# Get the latest release info from GitHub
# -----------------------------
def get_latest_release():
    url = f"{api_base}/releases/latest"
    r = requests.get(url)
    if r.status_code == 200:
        release = r.json()
        return {
            "tag_name": release.get("tag_name"),
            "published_at": release.get("published_at"),
            "zipball_url": release.get("zipball_url")  # source code zip
        }
    else:
        return None

# -----------------------------
# Get the latest commit info from GitHub
# -----------------------------
def get_latest_commit():
    url = f"{api_base}/commits"
    r = requests.get(url)
    if r.status_code == 200:
        commit = r.json()[0]
        return {
            "sha": commit["sha"],
            "message": commit["commit"]["message"],
            "author": commit["commit"]["author"]["name"],
            "date": commit["commit"]["author"]["date"]
        }
    else:
        return None

# -----------------------------
# Download and extract source code
# -----------------------------
def download_and_extract_source(zip_url, extract_dir=CACHE_DIR):
    print(f"Downloading source code from: {zip_url}")
    r = requests.get(zip_url)
    if r.status_code == 200:
        with zipfile.ZipFile(io.BytesIO(r.content)) as zip_ref:
            # Clear existing folder
            if os.path.exists(extract_dir):
                shutil.rmtree(extract_dir)
            os.makedirs(extract_dir, exist_ok=True)
            zip_ref.extractall(extract_dir)
        print(f"Source code extracted to {extract_dir}")
        return extract_dir
    else:
        print("Failed to download source code.")
        return None

# -----------------------------
# Run the install script
# -----------------------------
def run_install_script(extract_dir=CACHE_DIR):
    # GitHub zip creates a single root folder inside
    root_folders = os.listdir(extract_dir)
    if not root_folders:
        print("No extracted source folder found.")
        return
    root = os.path.join(extract_dir, root_folders[0])
    install_path = os.path.join(root, "install.sh")
    if os.path.exists(install_path):
        print("Running install.sh from source...")
        os.system(f"foot -e bash {install_path}")
    else:
        print("No install.sh found in source code.")

def update_rolling(): 
    """ 
    Download the latest install.sh script and run it in a terminal. 
    """ 
    os.system("rm -rf ./install.sh") 
    os.system("curl -fsSL -o install.sh https://raw.githubusercontent.com/BinaryHarbinger/hyprdots/main/install.sh") 
    os.system("foot --override=colors.alpha=1 --app-id=Update -e bash ./install.sh")

# -----------------------------
# Save data to JSON file
# -----------------------------
def save_to_json(data, filename="release_info.json"):
    with open(filename, "w") as f:
        json.dump(data, f, indent=4)

# -----------------------------
# Main function
# -----------------------------
def main():
    global CACHE_DIR
    current_data = loadFile()
    release_info = get_latest_release()
    commit_info = get_latest_commit()

    if release_info is None:
        print("No release info available.")
        return

    # Determine if update is needed
    update_needed = False
    if current_data.get("ID") == 'stable':
        if current_data.get("latest_release") != release_info.get("tag_name"):
            update_needed = True
    elif current_data.get("ID") == 'rolling':
        if current_data.get("latest_commit") != commit_info:
            update_needed = False
            update_rolling()


    if update_needed:
        print("New update detected, downloading source code...")
        source_dir = download_and_extract_source(release_info["zipball_url"], CACHE_DIR)
        if source_dir:
            run_install_script(source_dir)

    # Save the current release and commit info
    data = {
        "latest_release": release_info,
        "latest_commit": commit_info,
        "ID": current_data.get("ID")
    }

    save_to_json(data)
    print("Release information saved to 'release_info.json'")

# -----------------------------
# Entry point
# -----------------------------
if __name__ == "__main__":
    main()


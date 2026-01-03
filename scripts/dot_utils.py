import psutil

def is_running(process_name: str) -> bool:
    for proc in psutil.process_iter(attrs=["name"]):
        if proc.info["name"] == process_name:
            return True
    return False

def kill_process(name: str):
    for proc in psutil.process_iter(attrs=["name"]):
        if proc.info["name"] == name:
            proc.terminate()   # SIGTERM
            try:
                proc.wait(timeout=2)
            except psutil.TimeoutExpired:
                proc.kill()    # SIGKILL

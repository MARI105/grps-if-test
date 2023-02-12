"""
Sample library usage of har-transformer
"""
import transformer
from pathlib import Path


with open("locust/locustfile.py", "w") as f:
    transformer.dump(f, [Path("har/")], plugins=["har-transformer.plugins.rename_task", "har-transformer.plugins.add_client_certificate"])

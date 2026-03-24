
import os
import sys
from pathlib import Path

def get_sources(app_dir):
    """Recursively find all .cpp and .c files in the app directory"""
    app_path = Path(app_dir)
    src_path = app_path / 'src'
    
    sources = []
    
    if src_path.exists():
        for ext in ['*.cpp', '*.c']:
            sources.extend(src_path.rglob(ext))
    for source in sources:
        print(source.name)
    
    return len(sources)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: get_sources.py <app_directory>")
        sys.exit(1)
    
    get_sources(sys.argv[1])
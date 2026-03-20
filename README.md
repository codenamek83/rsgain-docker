# RSGain Docker Image

This repository hosts a Docker image for **RSGain**, providing a ready-to-run environment without needing to build or install anything manually.

## Pulling the Image

docker pull ghcr.io/codenamek83/rsgain:latest

## Running the RSGain Binary
Displays the help information and available options for the RSGain binary.
```bash
docker run -it --rm ghcr.io/codenamek83/rsgain:latest --help
```

Example of running RSGain inside Docker with a custom preset on your music directory.
```bash
rsgain easy -p custom-preset01 -S /path/to/your/music
```

```bash
docker run --rm -v "/path/to/music":/music ghcr.io/codenamek83/rsgain:latest easy -p custom-preset01 -S music
```

## Disclaimer

The **RSGain project** belongs to [complexlogic/rsgain](https://github.com/complexlogic/rsgain).  
This Docker image is **not the original project**—it only contains a **binary built from their repository**.

## Support & Documentation

For **all support, documentation, or issues**, please visit the original repository: [https://github.com/complexlogic/rsgain](https://github.com/complexlogic/rsgain)
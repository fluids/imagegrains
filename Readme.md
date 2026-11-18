# Customized ImageGrains for Grain Size Measurements Benchmark

This customized version of [ImageGrains v2.0.1](https://github.com/dmair1989/imagegrains/tree/v2.0.1) supports AI-based grain size benchmarking. It uses the fine-tuned Cellpose-SAM model [IG2_full_set_cp_SAM](https://zenodo.org/records/15728186/files/IG2_full_set_cp_SAM) to segment sediment grains, calculate grain size distributions and uncertainty, and compare CPU and GPU processing times.

The workflow processes images across multiple subfolders within a parent directory.

## Installation

Follow the guide for your system:

- [Windows 11](Install_Windows.md)
- [Ubuntu and Linux HPC](Install_Linux.md)

## Download Benchmark Data

A small dataset is included in [demo_data](demo_data) for the example notebooks.

Download the full benchmark data separately from [ESS-DIVE, DOI: 10.15485/2588483](https://doi.org/10.15485/2588483). Download all ZIP files whose names begin with `NvidiaH100_` or `IntelCoreI9_`.

| Hardware | File prefix | Example master folder |
| :--- | :--- | :--- |
| NVIDIA GPU | `NvidiaH100_` | `NvidiaH100_NoCut_12Filter` |
| CPU | `IntelCoreI9_` | `IntelCoreI9_NoCut_12Filter` |

Extract the archives into a common data directory, preserving the master folders and their image-set subfolders. For example:

```text
D:/Data/VisionAI/IntelCoreI9_NoCut_12Filter/20260430_YC_YRBCRBWAUSA/<image files>
```

Set the notebook's `DataDir` to the master folder:

```python
DataDir = r"D:\Data\VisionAI\IntelCoreI9_NoCut_12Filter"
```

On Linux, use your Linux path instead. The notebook assigns `DataDir` to `WorkDir` and automatically discovers the image-set subfolders. Process one master folder at a time.

### Images and Sources

| Image set | Contents | Source |
| :--- | :--- | :--- |
| `20260430_YC_YRBCRBWAUSA` | 10 smartphone photos and 9 drone images | [Chen et al. (2024)](https://doi.org/10.1029/2023WR036456) and [ESS-DIVE](https://doi.org/10.15485/2588483) |
| `20260430_MairD2026IG2_*` | 35 images across the image-set folders | [ImageGrains 2.0 dataset, v2](https://doi.org/10.5281/zenodo.17866827) |
| `20250916_DetertM2012_FieldValidateBaseGrain` | 1 validation image | [BASEGRAIN](https://basement.ethz.ch/download/tools/basegrain.html) |
| `20250916_MairD2024_FieldValidateMair2024K1` | 1 validation image | [ImageGrains dataset, v1](https://doi.org/10.5281/zenodo.8005771) |

## Demo Notebooks

Start with `0b_demo_data_i9.ipynb` for CPU or `0a_demo_data_h100.ipynb` for GPU. Review the parameters in **Step 1** of each notebook. Parameters not explicitly set use the ImageGrains defaults; see [`__main__.py`](https://github.com/dmair1989/imagegrains/blob/v2.0.1/src/imagegrains/__main__.py) for details.

| Notebook | Purpose |
| :--- | :--- |
| [0a_demo_data_h100.ipynb](notebooks/0a_demo_data_h100.ipynb) | Small GPU demo |
| [0b_demo_data_i9.ipynb](notebooks/0b_demo_data_i9.ipynb) | Small CPU demo |
| [2a_ig_gsd_h100_nocut_filter.ipynb](notebooks/2a_ig_gsd_h100_nocut_filter.ipynb) | GPU benchmark: uncut images with filtering |
| [2b_ig_gsd_h100_nocut_filter_Run2.ipynb](notebooks/2b_ig_gsd_h100_nocut_filter_Run2.ipynb) | GPU benchmark: run 2 |
| [2c_ig_gsd_h100_nocut_filter_Run3.ipynb](notebooks/2c_ig_gsd_h100_nocut_filter_Run3.ipynb) | GPU benchmark: run 3 |
| [2d_ig_gsd_h100_nocut_filter_singlediameter.ipynb](notebooks/2d_ig_gsd_h100_nocut_filter_singlediameter.ipynb) | GPU benchmark: single segmentation diameter |
| [2e_ig_gsd_h100_cut_filter.ipynb](notebooks/2e_ig_gsd_h100_cut_filter.ipynb) | GPU benchmark: cut images with filtering |
| [3a_ig_gsd_i9_nocut_filter.ipynb](notebooks/3a_ig_gsd_i9_nocut_filter.ipynb) | CPU benchmark: uncut images with filtering |
| [3b_ig_gsd_i9_nocut_filter_Run2.ipynb](notebooks/3b_ig_gsd_i9_nocut_filter_Run2.ipynb) | CPU benchmark: run 2 |
| [3c_ig_gsd_i9_nocut_filter_Run3.ipynb](notebooks/3c_ig_gsd_i9_nocut_filter_Run3.ipynb) | CPU benchmark: run 3 |

| Other files | Purpose |
| :--- | :--- |
| `*.executed.ipynb` | Executed notebooks containing saved outputs |
| `*.log` | Text logs from Papermill execution |
| [runcpu.sh](notebooks/runcpu.sh) | Run the listed CPU notebooks sequentially |
| [rungpu.sh](notebooks/rungpu.sh) | Run the listed GPU notebooks sequentially |

### Configure the Demo

Review these settings before running:

```python
DataDir = ""        # Empty: use demo_data; otherwise, specify a master folder
gpu = False         # True for a configured NVIDIA GPU
computer = "MyCPU"  # Label used in output filenames
```

The model downloads automatically into `models` when that folder is missing or empty. For offline HPC use, download [IG2_full_set_cp_SAM](https://zenodo.org/records/15728186) beforehand and place it in `imagegrains/models/`. Keep only the intended model file in that folder.

## Run the Code

Replace the example paths below with your repository path. Run all notebooks and scripts from the `notebooks` folder.

### Option 1 · Windows 11

Open **Anaconda PowerShell Prompt** from the Windows Start menu:

```powershell
conda activate imagegrains
cd "D:\Github\imagegrains\notebooks"
jupyter notebook
```

Open a demo, select **Python (imagegrains)** as the kernel, and run the cells in order.

### Option 2 · Linux with a Browser

Open a terminal:

```bash
conda activate imagegrains
cd /path/to/imagegrains/notebooks
jupyter notebook
```

Open a demo, select **Python (imagegrains)** as the kernel, and run the cells in order.

For remote HPC access, use your center's Jupyter service or SSH tunneling to connect from your local browser. Run the notebook within an allocated compute session.

### Option 3 · Linux Without a Browser

If a browser is unavailable or does not work on a Linux HPC, use Papermill to run the notebooks from the terminal.

Activate the environment and enter the `notebooks` folder:

```bash
conda activate imagegrains
cd /path/to/imagegrains/notebooks
export MPLBACKEND=Agg
```

**Run a single notebook:**

```bash
papermill 0b_demo_data_i9.ipynb 0b_demo_data_i9.executed.ipynb -k imagegrains --cwd . --log-output
```

For GPU execution, replace `0b_demo_data_i9` with `0a_demo_data_h100` in both filenames.

**Run multiple notebooks:**

Configure each notebook's data path and settings, then run the corresponding script.

CPU:

```bash
bash runcpu.sh
```

GPU:

```bash
bash rungpu.sh
```

The scripts use each notebook's saved kernel. Save the notebooks with **Python (imagegrains)** selected, or add `-k imagegrains` to the scripts' Papermill commands.

On HPC, run these commands inside a compute allocation or scheduler batch job. The scripts replace previous executed notebooks and logs with the same filenames.

## Outputs

Results include segmentation masks, overlays, grain measurements, uncertainty estimates, timing CSVs, and summary statistics. Image-level results are saved in each image-set's `segments_ig2` folder.

Grain sizes are reported in **pixels**. Convert them to physical units using an appropriate image scale. Papermill also saves an executed notebook containing the run's outputs.

## References and License

Please cite the original [ImageGrains 2.0 paper](https://doi.org/10.5194/esurf-14-527-2026), [Cellpose-SAM](https://doi.org/10.1101/2025.04.28.651001), and the datasets used.

See [Readme_imagegrains.md](Readme_imagegrains.md) for original documentation and [LICENSE.md](LICENSE.md) for the BSD 3-Clause license.

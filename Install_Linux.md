# Install Customized ImageGrains — Linux · (CPU and GPU)

This guide installs a [customized version](https://github.com/fluids/imagegrains) of [ImageGrains v2.0.1](https://github.com/dmair1989/imagegrains/tree/v2.0.1), adapted to support a new data structure for AI-based grain size benchmarking.

## Step 0 · Install Anaconda

Skip this step if Anaconda is already installed.

1. Download the **Linux x86_64** shell installer from the [Anaconda download page](https://www.anaconda.com/download/success).
2. Open Terminal and navigate to the download folder:

```bash
cd ~/Downloads
bash Anaconda3-<version>-Linux-x86_64.sh
```

Replace `Anaconda3-<version>-Linux-x86_64.sh` with the exact filename you downloaded.

3. Follow the installation prompts. Accept shell initialization when prompted.
4. Close and reopen Terminal.

## Step 1 · Open Terminal and check Conda

Open **Terminal**. On Ubuntu, you can press **Ctrl+Alt+T**.

## Step 2 · Create and activate the environment

```bash
conda create --name imagegrains -c conda-forge python=3.10.18 git
conda activate imagegrains
```

## Step 3 · Download the source code

Navigate to your preferred code folder, then clone the repository:

```bash
mkdir -p ~/Computation/Python/work/Mine/SFA
cd ~/Computation/Python/work/Mine/SFA
git clone https://github.com/fluids/imagegrains.git
cd imagegrains
```

Replace the example path with your own. If already cloned, navigate to the existing `imagegrains` folder.

## Step 4 · Install the packages

Run these commands from the `imagegrains` folder:

```bash
python -m pip install --upgrade pip
```

Choose **one** PyTorch installation option.

### Option A · CPU only

```bash
python -m pip install torch==2.7.1 torchvision==0.22.1 --index-url https://download.pytorch.org/whl/cpu
```

### Option B · Ubuntu with NVIDIA GPU — CUDA 13.0

Installs **PyTorch 2.11.0+cu130**:

```bash
python -m pip install torch==2.11.0 torchvision==0.26.0 --index-url https://download.pytorch.org/whl/cu130
```

Requires a compatible NVIDIA GPU and driver supporting CUDA 13.0.

### Option C · PNNL Marianas with NVIDIA GPU — CUDA 11.8

Installs **PyTorch 2.7.1+cu118**:

```bash
python -m pip install torch==2.7.1 torchvision==0.22.1 --index-url https://download.pytorch.org/whl/cu118
```

Run GPU verification and demos within an allocated GPU compute session.

### Install ImageGrains and notebook tools

After installing your selected PyTorch version:

```bash
python -m pip install -e .
python -m pip install notebook ipykernel papermill
```

The `-e .` option installs the local source in editable mode.

## Step 5 · Register the Jupyter kernel

```bash
python -m ipykernel install --user --name imagegrains --display-name "Python (imagegrains)"
```

## Step 6 · Verify the installation

```bash
python -m pip check
python -c "import imagegrains, cellpose, torch; print('PyTorch:', torch.__version__); print('CUDA version:', torch.version.cuda); print('CUDA available:', torch.cuda.is_available()); print('Device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'CPU')"
```

`python -m pip check` should report no dependency conflicts.

For GPU installations, `CUDA available: True` requires a compatible GPU and driver visible to the current session. On Marianas, check this inside your allocated GPU compute session.

# Install Customized ImageGrains — Windows 11 · CPU

This guide installs a [customized version](https://github.com/fluids/imagegrains) of [ImageGrains v2.0.1](https://github.com/dmair1989/imagegrains/tree/v2.0.1), adapted to support a new data structure for AI-based grain size benchmarking.

## 1 · Install Anaconda and Git

Skip this step if both are already installed.

- Install [Anaconda for Windows](https://www.anaconda.com/download) using the default options.
- Install [Git for Windows](https://git-scm.com/downloads/win) with command-line access enabled.

Open **Anaconda PowerShell Prompt** from the Windows Start menu.

## 2 · Create and activate the environment

```powershell
conda create --name imagegrains -c conda-forge python=3.10.18
conda activate imagegrains
```

## 3 · Download the source code

Navigate to your preferred code folder, then clone the repository:

```powershell
cd "D:\Computation\Python\work\Mine\SFA"
git clone https://github.com/fluids/imagegrains.git
cd imagegrains
```

Replace the example path with your own. If already cloned, navigate to the existing `imagegrains` folder.

## 4 · Install the packages

Run these commands from the `imagegrains` folder:

```powershell
python -m pip install --upgrade pip
python -m pip install torch==2.7.1 torchvision==0.22.1 --index-url https://download.pytorch.org/whl/cpu
python -m pip install -e .
python -m pip install notebook ipykernel papermill
```

## 5 · Register the Jupyter kernel

```powershell
python -m ipykernel install --user --name imagegrains --display-name "Python (imagegrains)"
```

## 6 · Verify the installation

```powershell
python -m pip check
python -c "import imagegrains, cellpose, torch; print('PyTorch:', torch.__version__); print('CUDA available:', torch.cuda.is_available())"
```

Expected: no dependency conflicts and `CUDA available: False`.

## 7 · Run the demos

```powershell
jupyter notebook
```

Open a demo in `notebooks`, select **Python (imagegrains)** as the kernel, and run the cells in order. Set `gpu=False` if the demo provides this option.
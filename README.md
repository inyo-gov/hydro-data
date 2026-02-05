# Owens Valley groundwater and surface water data processing

Welcome to the hydro data processing repository.

## Website

For more information and to view the website, please visit: [Hydro Data Processing Website](https://inyo-gov.github.io/hydro-data/)

## Annual Update Guide

**New water year coming up?** See [`ANNUAL_UPDATE_GUIDE.md`](ANNUAL_UPDATE_GUIDE.md) for comprehensive instructions on updating the reports and processing data for the next water year.

## R package

This repository also includes an R package under `package/` for lightweight
data access and reproducible reporting workflows. You can install it from
GitHub with:

``` r
remotes::install_github("inyo-gov/hydro-data", subdir = "package")
```

See `package/README.md` for package usage examples.

## Data provenance

Annual data releases are published as GitHub Releases with a minimal data
capsule (raw inputs, master snapshot, and outputs). The package manifest
points to those release assets so updates are reproducible without storing
large inputs directly in the repo.

## Introduction

This code automates processing the annual hydro data transfer from LADWP - extracting water levels, surface water monthly flow volumes, and groundwater pumping volumes from ZRXP ASCII data exchange format, transforming and merging updates with the County database, and exporting CSV files formatted for the [Owens Valley Groundwater Authority](https://owens.gladata.com/) data management system.

### Prerequisites

-   R and RStudio
-   Git
-   Git LFS (for handling large files)

### Installing

1.  **Clone the Repository Using RStudio:**

    -   **Open RStudio.**
    -   **Create a New Project:**
        -   Go to the `File` menu and select `New Project...`.
        -   Choose `Version Control`.
        -   Select `Git`.
    -   **Enter Repository URL:**
        -   In the `Repository URL` field, enter the URL of your GitHub repository (e.g., `https://github.com/inyo-gov/hydro-data.git`).
        -   Choose a directory on your local machine to store the repository.
        -   Click `Create Project`.

2.  **Open the Project in RStudio:**

    -   Navigate to the directory where you cloned the repository.
    -   Double-click on the `hydro-data.Rproj` file to open the project in RStudio.

3.  **Install Git LFS and Pull Large Files:**

    If your repository uses Git LFS for handling large files, make sure to install and set it up:

    -   **Install Git LFS:**

        ``` sh
        git lfs install
        ```

    -   **Pull Large Files:**

        ``` sh
        git lfs pull
        ```

## Contributing

To contribute to this project, follow these steps:

1.  **Fork the Repository:**
    -   Go to the GitHub page of the repository and click the `Fork` button at the top right to create a copy of the repository under your own GitHub account.
2.  **Clone Your Fork:**
    -   Open RStudio and create a new project from version control, using the URL of your forked repository.
3.  **Create a New Branch:**
    -   In your local repository, create a new branch to work on. For example:

        ``` sh
        git checkout -b feature-branch
        ```
4.  **Make Your Changes:**
    -   Implement your changes or additions in RStudio.
5.  **Commit and Push Your Changes:**
    -   Once you have made your changes, commit them with a descriptive message:

        ``` sh
        git add .
        git commit -m "Description of the changes"
        git push origin feature-branch
        ```
6.  **Create a Pull Request:**
    -   Go to the original repository on GitHub and you should see an option to create a pull request from your branch. Click on `Compare & pull request`, provide a detailed description of the changes, and submit the pull request.
7.  **Review Process:**
    -   One of the project maintainers will review your pull request. You might be asked to make further changes. Once everything is satisfactory, your changes will be merged into the main branch.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Dependencies

-   `lubridate`
-   `knitr`
-   `readxl`
-   `writexl` (for OVGA XLSX exports)
-   `tidyverse`
-   `here`
-   `DT`

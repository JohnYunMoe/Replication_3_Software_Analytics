# Replication of "A Large-Scale Study of Test Coverage Evolution"

## 1. Project Title and Overview

- **Paper Title**: A Large-Scale Study of Test Coverage Evolution
- **Authors**: Michael Hilton, Jonathan Bell, and Darko Marinov
- **Replication Team**: John Yun Moe & Zavier Shaikh
- **Course**: CS-UH 3260 Software Analytics, NYUAD
- **Original Paper**: [ACM/IEEE Proceedings](https://doi.org/10.1145/3238147.3238183)
- **Original Artifact**: http://www.code-coverage.org/data/

### Brief Description

**Original Paper**: This study investigates how test coverage evolves over time across 47 large-scale open-source projects. The paper examines 7,816 builds across both in vivo (Coveralls) and traditional (JaCoCo) coverage collection approaches, investigating research questions about coverage trends, the relationship between patch size and coverage, and instances where coverage appears to fluctuate unexpectedly.

**This Replication Study**: This replication reproduces the core research questions (RQ1–RQ3) from the original paper using the provided data and R analysis scripts. Additionally, this study extends the analysis by collecting new coverage data from five selected projects to compare the original dataset results against more recent project evolution.

---

## 2. Repository Structure

```
README.md                          # This file - documentation and setup instructions
data_explained.md                  # Detailed explanation of all CSV data files and their relationships
data and scripts/                  # Data, scripts, and paper artifacts
├── coverage-analysis/             # R scripts and coverage data for analysis
│   └── r_scripts.Rproj            # R project file
├── coveralls_importer/            # Java project for collecting new coverage data
│   ├── src/                       # Java source code for importing coverage data
│   ├── pom.xml                    # Maven configuration file
│   └── *.csv                      # Input files and newly collected coverage data
└── paper/                         # Paper-related files
    ├── coverage_sparklines/       # Sparkline TeX fragments (1.tex ... 47.tex)
    └── figures/                   # Generated figures used in report/paper
```

### Key Files and Folders

#### `data and scripts/coverage-analysis/` - R Analysis Scripts

| File | Purpose |
|------|---------|
| `BuildEntirePaper.R` | **Main orchestration script** - loads data and runs all analysis scripts sequentially to reproduce RQ1-RQ5 |
| `CoverallsIOdata.R` | Data loading script - imports all CSV files and merges them into unified `allData` dataframe (7,816 builds across 47 projects) |
| `coverageOfNewLines.R` | Reproduces RQ1 (Figure 2) - distribution of patch coverage across revisions |
| `patchImpactOnOverallCoverage.R` | Reproduces RQ2 (Figure 3) - impact of patches on coverage of non-patch (existing) code |
| `occluded_changes_barplot.R` | Reproduces RQ3 (Figure 4) - visualizes occluded changes where coverage appears unchanged |
| `occludedChanges.R` | Supporting script for RQ3 - computes occluded change data |
| `FlappingCovg.R` | Reproduces RQ4 (Figure 5) - examines coverage flipping (lines that flip between covered/uncovered) |
| `DriversToCoverageChange.R` | Reproduces RQ5 (Figure 6) - analyzes what factors (new lines, deletions, existing line changes) drive coverage change |
| `corrolatePatchCovWithChange.R` | Computes Kendall Tau and Pearson correlation between patch coverage and overall/non-patch coverage (statistical tests for RQ1 and RQ2) |
| `GraphAllCovgAllProjects.R` | Generates visualizations of coverage evolution across all projects |
| `PatchSummaryTable.R` | Generates summary tables of patch statistics |

#### `data and scripts/coverage-analysis/*.csv` - Coverage Data Files

See [data_explained.md](data_explained.md) for comprehensive documentation. Key files:

| File | Records | Description |
|------|---------|-------------|
| `coverage_EOL.csv` | 2,606 | Coveralls (in vivo) coverage data - 18 projects |
| `coverage_jacoco_EOL.csv` | 5,578 | JaCoCo (traditional) coverage data - 29 Java projects |
| `flapping_coveralls.csv` | 41,391 | Line-level coverage flipping data - Coveralls projects |
| `flapping_jacoco.csv` | 126,651 | Line-level coverage flipping data - JaCoCo projects |
| `project_sources.csv` | 30 | Metadata listing all Coveralls projects |
| `projects_jacoco.csv` | 29 | Metadata listing all JaCoCo projects |

#### `data and scripts/coveralls_importer/` - Java Data Collection Tool

Java Maven project for collecting new coverage data from GitHub projects. Used to gather updated patch coverage information for selected projects beyond the original dataset date range.

| Item | Purpose |
|------|---------|
| `src/main/java/.../CoverallsImporter.java` | Main entry point - imports coverage data from Coveralls API |
| `pom.xml` | Maven dependencies and build configuration |
| Input CSVs | `gitRepoList.csv`, `gitRepoList_small.csv` - repo URLs to process |
| Output CSVs | Generated coverage data in same format as original dataset |

#### `data and scripts/paper/` - Paper Artifacts

This folder stores publication-ready LaTeX outputs and figure inputs generated by the analysis pipeline.

| Item | Purpose |
|------|---------|
| `AllFlipsDist.tex` | LaTeX output summarizing coverage flip distribution statistics |
| `PatchSizeSummary.tex` | LaTeX output summarizing patch size distribution/statistics |
| `coverage_sparklines/` | 47 TeX fragments (`1.tex` ... `47.tex`) for project-level coverage sparklines |
| `figures/` | Figure assets used in the report/paper |

#### `data and scripts/paper/figures/` - Generated Visualizations

Final plot outputs are saved in `data and scripts/paper/figures/`.

Current generated figure files:
- `coverageofnewlines.pdf`
- `patchImpact.pdf`
- `occludedImpact.pdf`
- `flipFactor.pdf`
- `driverToChange.pdf`

Note: the scripts may create subfolders under `data and scripts/coverage-analysis/plots/`, but the final paper figures are written to `data and scripts/paper/figures/`.

---

## 3. Setup Instructions

### Prerequisites

#### Software Requirements

- **Windows/macOS/Linux** - Cross-platform compatible
- **R** - Version 3.5+ (tested with 3.6+)
  - Available from: https://cran.r-project.org/
- **RStudio** (recommended, not required) - https://www.rstudio.com/
- **Java** - JDK 8+ (required only for data collection with CoverallsImporter)
  - Available from: https://www.oracle.com/java/technologies/javase-downloads.html
- **Maven** - 3.6+ (if modifying/rebuilding Java project)
  - Available from: https://maven.apache.org/

#### R Package Dependencies

The following R packages are required and automatically loaded by `BuildEntirePaper.R`:

| Package | Version | Purpose |
|---------|---------|---------|
| `plyr` | Latest | Data splitting/applying functions |
| `reshape2` | Latest | Data reshaping utilities |
| `readr` | Latest | Fast CSV file reading |
| `ggplot2` | Latest | Graphics and visualization |
| `dplyr` | Latest | Data manipulation |
| `stringr` | Latest | String manipulation |
| `stargazer` | Latest | Statistical table generation |

### Installation Steps

#### 1. Install R and Required Packages

**Windows/macOS:**
1. Download R from https://cran.r-project.org/
2. Follow the installer instructions
3. Open R or RStudio and run:
```r
packages_to_install <- c("plyr", "reshape2", "readr", "ggplot2", "dplyr", "stringr", "stargazer")
install.packages(packages_to_install)
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install r-base r-base-dev
R -e "install.packages(c('plyr', 'reshape2', 'readr', 'ggplot2', 'dplyr', 'stringr', 'stargazer'))"
```

#### 2. Clone or Download This Repository

```bash
git clone https://github.com/JohnYunMoe/Replication_3_Software_Analytics.git
cd Replication_3_Software_Analytics
```

#### 3. Verify Setup

Navigate to the `data and scripts/coverage-analysis/` folder and check that all CSV files are present:
- `coverage_EOL.csv` (or `coverage.csv`)
- `coverage_jacoco_EOL.csv` (or `coverage_jacoco.csv`)
- `flapping_coveralls.csv`
- `flapping_jacoco.csv`
- `project_sources.csv`
- `projects_jacoco.csv`
- `branches_uniq.csv`
- `csvShaOrder.csv`
- `shaOrders.csv`

### Reproducing the Analysis

#### Running the Complete Analysis (RQ1-RQ5)

1. Open RStudio or R
2. Set working directory to the repository root:
```r
setwd("path/to/Replication_3_Software_Analytics")
```

3. Run the main orchestration script which loads data and executes all analyses:
```r
source("data and scripts/coverage-analysis/BuildEntirePaper.R")
```

This script will:
- Load all CSV data files using `CoverallsIOdata.R`
- Execute RQ1 analysis (drivers to coverage change)
- Execute RQ2 analysis (patch correlation)
- Execute RQ3 analysis (occluded changes)
- Execute RQ4 analysis (coverage flapping)
- Execute RQ5 analysis (additional analyses)
- Generate final plots in `data and scripts/paper/figures/`

**Expected Runtime**: 5-15 minutes depending on machine specifications

#### Running Individual Analyses

To run individual research question analyses:

```r
# First, always load and prepare the data
source("data and scripts/coverage-analysis/CoverallsIOdata.R")

# Then run specific analyses
source("data and scripts/coverage-analysis/DriversToCoverageChange.R")        # RQ1
source("data and scripts/coverage-analysis/corrolatePatchCovWithChange.R")    # RQ2
source("data and scripts/coverage-analysis/occludedChanges.R")                # RQ3
source("data and scripts/coverage-analysis/FlappingCovg.R")                   # RQ4
```

#### Collecting New Coverage Data (Java Project)

To extend the dataset with new coverage data:

1. Navigate to the Java project:
```bash
cd "data and scripts/coveralls_importer"
```

2. Build the project:
```bash
mvn clean package
```

3. Run the Coveralls importer:
```bash
java -jar target/CoverallsImporter-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```

The tool will read `gitRepoList.csv` or `gitRepoList_small.csv` and output new coverage data in the same CSV format as the original dataset.

### Verifying Reproducibility

After running the analysis, you should find:

1. **Generated Plots** in `data and scripts/paper/figures/`:
   - Coverage evolution graphs
   - Patch impact visualizations
   - Distribution plots
   - Stacked bar plots

2. **Console Output** showing:
   - Summary statistics for each RQ
   - Number of projects and builds analyzed
   - Data validation messages

3. **Comparison with Paper Table 1**:
   - Original paper reports 7,816 builds across 47 projects
   - Your reproduced analysis should also report exactly 7,816 builds
   - Summary statistics (mean coverage, coverage changes, etc.) should closely match reported values

---

## 4. GenAI Usage

This replication study utilized **GitHub Copilot** as an AI-assisted coding tool. Copilot was used for:

- **Script Understanding**: Helping interpret R script logic and functions to understand analysis flow
- **Documentation**: Generating and refining documentation for data structures and file relationships
- **Data Exploration**: Assisting in understanding CSV column meanings and data relationships described in `data_explained.md`
- **README Assistance**: Assistance with refining structured documentation based on the project requirements

The use of Copilot accelerated comprehension of the existing codebase and documentation processes, but all analysis decisions, research reproducibility, and data interpretation were performed by the replication team.

---

## 5. Key Findings from Original Paper (For Reference)

The original paper's research questions investigated:

- **RQ1**: What factors drive changes to test coverage? (Analyzes impact of code changes on coverage)
- **RQ2**: What is the relationship between patch size and coverage? (Examines correlation between lines changed and coverage impact)
- **RQ3**: When does coverage not change despite code changes? (Identifies "occluded changes")
- **RQ4**: How often does coverage flap between covered and uncovered? (Quantifies coverage instability)
- **RQ5**: How do these patterns differ between in vivo and traditional coverage collection? (Compares Coveralls vs JaCoCo)

See the paper reference for complete results and interpretation: https://doi.org/10.1145/3238147.3238183

---

## 6. Troubleshooting

### Common Issues

**Issue**: `Error: could not find function "source"`
- **Cause**: Working directory not set correctly
- **Solution**: Ensure you are running from repository root and paths are relative or absolute correctly

**Issue**: `Package 'plyr' not found`
- **Cause**: R packages not installed
- **Solution**: Run `install.packages("plyr")` (and other missing packages) in R

**Issue**: CSV files not found/different row counts
- **Cause**: Wrong working directory or modified data files
- **Solution**: Verify you're in `data and scripts/coverage-analysis/` and haven't modified the CSV files

**Issue**: Java compilation fails for CoverallsImporter
- **Cause**: Missing JDK or Maven
- **Solution**: Install Java JDK and Maven from their official sources

---

## References

- Original Paper: Hilton, M., Bell, J., & Marinov, D. (2018). A large-scale study of test coverage evolution. In Proceedings of the 33rd ACM/IEEE International Conference on Automated Software Engineering (ASE '18).
- Artifact Repository: http://www.code-coverage.org/data/

---

**Last Updated**: April 2026

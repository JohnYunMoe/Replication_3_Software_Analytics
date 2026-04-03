# What is Provided

The artifact provides 11 CSV files and R scripts that together represent the complete dataset and analysis pipeline used in the paper. The CSV files fall into 4 categories:

---

## Category 1 — Build-Level Coverage Data (The Core Data)

### `coverage_EOL.csv` and `coverage.csv`

These are the same data with different line endings for cross-platform compatibility. They contain coverage data collected from the **in vivo (Coveralls)** projects — the 18 projects whose coverage was collected directly from the Coveralls service rather than compiled locally.

- **2,606 rows** — one row per build per project
- A single data point = one build of one project at one specific commit

#### Columns explained:

**Identity columns — what build is this?**

| Column | What it means |
|--------|---------------|
| `repo` | The project name e.g. `ManageIQ/ui-components` |
| `childSha` | The Git commit hash of this build |
| `parentSha` | The Git commit hash of the previous build |
| `childBranch` | Which Git branch e.g. `master` |
| `timestamp` | Unix timestamp of when the build happened |

**Overall coverage columns — how much is covered in total?**

| Column | What it means |
|--------|---------------|
| `totalStatementsNow` | Total lines of code in this build |
| `totalStatementsPrev` | Total lines of code in the previous build |
| `totalStatementsHitNow` | Lines covered by tests in this build |
| `totalStatementsHitPrev` | Lines covered by tests in previous build |
| `nStatementsInBoth` | Lines covered in BOTH this and previous build |
| `nStatementsInEither` | Lines covered in EITHER this or previous build |

**Patch coverage columns — what happened to newly added lines?**

| Column | What it means |
|--------|---------------|
| `newHitLines` | Newly added lines that ARE covered by tests |
| `newNonHitLines` | Newly added lines that are NOT covered |
| `newFileHitLines` | Covered lines in brand new files |
| `newFileNonHitLines` | Uncovered lines in brand new files |

**Non-patch coverage columns — what happened to existing unchanged lines?**

| Column | What it means |
|--------|---------------|
| `oldLinesNewlyTested` | Existing lines that GAINED coverage |
| `oldLinesNoLongerTested` | Existing lines that LOST coverage |

**Modified lines columns — what happened to changed lines?**

| Column | What it means |
|--------|---------------|
| `modifiedLinesNewlyHit` | Modified lines that are now covered |
| `modifiedLinesStillHit` | Modified lines that were and still are covered |
| `modifiedLinesNotHit` | Modified lines that are not covered |

**Deleted lines columns — what happened to removed lines?**

| Column | What it means |
|--------|---------------|
| `deletedLinesTested` | Deleted lines that were previously covered |
| `deletedLinesNotTested` | Deleted lines that were previously uncovered |
| `deletedFileLinesTested` | Covered lines in entirely deleted files |
| `deletedFileLinesNotTested` | Uncovered lines in entirely deleted files |

**File change columns — what files changed?**

| Column | What it means |
|--------|---------------|
| `insFilesSrc` / `insFilesTest` | Source/test files inserted |
| `modFilesSrc` / `modFilesTest` | Source/test files modified |
| `delFilesSrc` / `delFilesTest` | Source/test files deleted |
| `newLinesSrc` / `newLinesTest` | New lines added in source/test files |
| `delLinesSrc` / `delLinesTest` | Lines deleted from source/test files |
| `insLinesAllFiles` / `delLinesAllFiles` | Total lines inserted/deleted across all files |

---

### `coverage_jacoco_EOL.csv` and `coverage_jacoco.csv`

Same structure as above but for the **traditional (JaCoCo)** projects — the 29 Java projects compiled and tested locally using the JaCoCo coverage tool.

- **5,578 rows** — one row per build per project
- A single data point = one build of one project at one specific commit
- Identical columns to `coverage_EOL.csv` plus one extra:

| Column | What it means |
|--------|---------------|
| `date` | Human readable date string of the build (e.g. `2014-02-26 18:44:35`) |

> The reason there are more rows here is that the traditional evaluation collected up to 250 builds per project across 29 projects, while the Coveralls data was rate-limited during collection.

---

## Category 2 — Line-Level Flipping Data

### `flapping_coveralls.csv` (41,391 rows) and `flapping_jacoco.csv` (126,651 rows)

These files track individual lines of code that **flipped between covered and uncovered** across commits. This is the most granular data in the artifact and is used specifically for **RQ4** in the paper.

- A single data point = one line of code at one specific commit where a coverage flip was recorded

#### Columns:

| Column | What it means |
|--------|---------------|
| `commit` | The Git commit hash where the flip was recorded |
| `file` | The file path containing the line e.g. `src/main/java/org/apache/commons/dbcp2/BasicDataSource.java` |
| `line` | The line number within that file |
| `covered` | Whether the line was covered (`1`) or not covered (`0`) at this commit |

> The reason `flapping_jacoco.csv` is much larger (126,651 vs 41,391 rows) is that the JaCoCo dataset covers more projects with more builds, giving more opportunities to detect line-level flips.

---

## Category 3 — Project Metadata

### `project_sources.csv` (30 rows)

Lists the Coveralls projects and which prior paper they came from.

- A single data point = one project

| Column | What it means |
|--------|---------------|
| `ProjectName` | Project name e.g. `apache/commons-exec` |
| `Source` | Which prior paper the project was sourced from e.g. `\cite{deflaker}` |

### `projects_jacoco.csv` (29 rows)

Lists the JaCoCo projects used in the traditional evaluation.

- A single data point = one project

| Column | What it means |
|--------|---------------|
| `URL` | Full GitHub URL of the project |
| `lang` | Always `jacoco` indicating collection method |
| `slug` | Shortened identifier used to match with coverage data e.g. `apache-commons-dbcp` |

---

## Category 4 — Commit Ordering and Branch Data

### `csvShaOrder.csv` (117,317 rows)

Maps every commit SHA to a global sequential index across all projects.

- A single data point = one commit

| Column | What it means |
|--------|---------------|
| `sha` | The Git commit hash |
| `idx` | The global sequential position of this commit |

### `shaOrders.csv` (8,917 rows)

Maps commits to their per-project sequential index.

- A single data point = one commit within one project

| Column | What it means |
|--------|---------------|
| `project` | The project name |
| `idx` | Sequential position within that specific project |
| `sha` | The Git commit hash |

### `branches_uniq.csv` (32,656 rows)

Maps every commit to its branch name.

- A single data point = one commit

| Column | What it means |
|--------|---------------|
| `SHA` | The Git commit hash |
| `branch` | The branch name, almost always `master` |

---

## How All Files Relate to Each Other

The files are linked together through shared key columns, primarily the Git commit SHA and project name:

```
project_sources.csv          projects_jacoco.csv
(18 Coveralls projects)      (29 JaCoCo projects)
        ↓ joined by ProjectName/URL
coverage_EOL.csv             coverage_jacoco_EOL.csv
(2,606 builds)               (5,578 builds)
        ↓ joined by childSha
csvShaOrder / shaOrders      branches_uniq.csv
(commit ordering)            (branch info)
        ↓ joined by commit SHA
flapping_coveralls.csv       flapping_jacoco.csv
(41,391 line-level records)  (126,651 line-level records)
```

The R script `CoverallsIOData.R` (the master data loading script) performs all of these joins automatically, merging everything into a single unified data frame called `allData` which contains **7,816 builds across 47 projects** — exactly matching the number reported in the paper. This `allData` object is then what all the analysis scripts (RQ1 through RQ5) operate on.

---

## Computed Columns Added by the Scripts

It is worth noting that the scripts also add several columns to `allData` that do not exist in the raw CSV files, computed from the raw data:

| Computed Column | Formula | Used For |
|-----------------|---------|----------|
| `CoverageNow` | `totalStatementsHitNow / totalStatementsNow` | Overall coverage ratio |
| `ActualChangeToCoverage` | Coverage ratio now minus coverage ratio before | Detecting occluded changes (RQ3) |
| `Jaccard` | `nStatementsInBoth / nStatementsInEither` | Similarity of covered lines between builds |
| `srcPatchSize` | `newLinesSrc + delLinesSrc` | Source patch size in lines |
| `testPatchSize` | `newLinesTest + delLinesTest` | Test patch size in lines |
| `pid` | Assigned by script (P01–P47) | Project identifier matching Table 1 in paper |

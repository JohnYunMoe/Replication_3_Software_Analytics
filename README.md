<p style="border:1px; border-style:solid; border-color:black; padding: 1em;">
CS-UH 3260 Software Analytics<br/>
Replication Study <br/>
John Yun Moe & Zavier Shaikh, NYUAD
</p>

# Replication of  A Large-Scale Study of Test Coverage Evolution

## Requirements 
M. Hilton, J. Bell, and D. Marinov. 2018. A large-scale study of test coverage evolution. In Proceedings of the 33rd
ACM/IEEE International Conference on Automated Software Engineering (ASE '18). Association for Computing
Machinery, New York, NY, USA. https://doi.org/10.1145/3238147.3238183
Artifact: http://www.code-coverage.org/data/
### Scope of Replication:
1.Explore the data provided in the artifact. Explain what is provided and what do the columns for a given data point
represent. If multiple data files are provided, explain how they relate to each other.
2.Reproduce RQ1–RQ3 using the scripts and data provided. Compare your results with those reported in the paper.
For this task, you do not have to re-collect the coverage and code change data and can use the provided scripts
and data.
3.Pick five projects from the data set and check what is the latest date of code changes and coverage available in the
data. Use the provided data collection scripts to collect patch coverage information for new revisions to date. Re-run
RQ1 on the complete data available to date (i.e., the previous data points for the projects + the new data you
collected, such that you have the complete evolution of the project to date). Compare the key statistics in Table 1 on
the reproduced results you got from Task 2 on the original data and the new results you got with the full up-to-date
data

## Overview

This repo provides a template and and guidelines for creating a README file for your replication study repository. The README serves as the primary documentation for your repository and helps evaluators understand your work, navigate your repository structure, and reproduce your replication. You can create a repo based on this template and modify the README and content as needed.


## README Structure Template

Your repository README should include the following sections:

### 1. Project Title and Overview

- **Paper Title**: [Full title of the replicated paper]
- **Authors**: [Original paper authors]
- **Replication Team**: [Your team members' names]
- **Course**: CS-UH 3260 Software Analytics, NYUAD
- **Brief Description**: 
  - 2-3 sentences summarizing what the original paper is about
  - 2-3 sentences summarizing what this replication study does

### 2. Repository Structure

Document your repository structure clearly. Organize your repository using the following standard structure:

```
README                    # Documentation for your repository
datasets/                 # Subset of data you used (if any). If you used the whole dataset, include instructions on how to download it
replication_scripts/      # Scripts used in your replication:
                          #   - If you used scripts as-is: document which scripts you ran
                          #   - If you modified scripts: include the modified scripts
                          #   - If you created new scripts: include all new scripts
outputs/                  # Your generated results only
logs/                     # Console output, errors, screenshots
notes/                    # Optional if you have any notes you took during reproduction (E.g., where you noted discrepencies etc)
```

**For each folder and file, provide a brief description of what it contains.**

### 3. Setup Instructions

- **Prerequisites**: Required software, tools, and versions
  - OS requirements
  - Programming language versions (Python, R, etc.)
  - Required packages/libraries and versions
  - Any other dependencies
- **Installation Steps**: Step-by-step instructions to set up the environment
  - How to install dependencies
  - How to configure paths or settings
  - Any environment variables needed

### 4. GenAI Usage

**GenAI Usage**: Briefly document any use of generative AI tools (e.g., ChatGPT, GitHub Copilot, Cursor) during the replication process. Include:

  - Which tools were used
  - How they were used (e.g., understanding scripts, exploring datasets, understanding data fields, debugging)
  - Brief description of the assistance provided


## Grading Criteria for README

Your README will be evaluated based on the following aspects (Total: 40 points):

### 1. Completeness (10 points)
- [ ] All required sections are present
- [ ] Each section contains sufficient detail
- [ ] Repository structure is fully documented
- [ ] All files and folders are explained
- [ ] GenAI usage is documented (if any AI tools were used)

### 2. Clarity and Organization (5 points)
- [ ] Information is well-organized and easy to follow
- [ ] Instructions are clear and unambiguous
- [ ] Professional writing and formatting
- [ ] Proper use of markdown formatting (headers, code blocks, lists)

### 3. Setup and Reproducibility (10 points)
- [ ] Setup instructions are complete and accurate, i.e., we were able to rerun the scripts following your instructions and obtain the results you reported


## Best Practices

1. **Be Specific**: Include exact versions, paths, and commands rather than vague descriptions
2. **Keep It Updated**: Ensure the README reflects the current state of your repository
3. **Test Your Instructions**: Have someone else (or yourself in a fresh environment) follow the setup instructions
4. **Document AI Usage**: If you used any GenAI tools, be transparent about how they were used (e.g., understanding scripts, exploring datasets, understanding data fields)


## Acknowledgement

This guideline was developed with the assistance of [Cursor](https://www.cursor.com/), an AI-powered code editor. This tool was used to:

- Draft and refine this documentation iteratively

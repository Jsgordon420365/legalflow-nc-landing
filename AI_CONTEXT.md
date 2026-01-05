# AI Context Guide: LegalFlow NC Landing

This document provides context and instructions for AI agents (like Antigravity, Cursor, etc.) to understand and interact with the **LegalFlow NC** project.

## 🎯 Project Purpose
LegalFlow NC is an internal document automation toolkit designed for North Carolina legal professionals. It specifically handles the generation of "Complaint in Action on Judgment" documents using a Streamlit-based web interface and DOCX templates.

## 🏗️ System Architecture
The project follows a simple client-server model implemented locally:
- **Frontend**: Streamlit-based web form (`action_on_judgment/app.py`).
- **Engine**: Python-based document generation using `docxtpl` (`action_on_judgment/generate_doc.py`).
- **Templates**: Microsoft Word (.docx) files with Jinja2-style placeholders.

## 📂 Key Files & Directories
- `action_on_judgment/`: Primary application directory.
    - `app.py`: contains the Streamlit UI and input logic.
    - `generate_doc.py`: logic for merging user input into the DOCX template.
    - `complaint_action_on_judgment__template_v1.docx`: the source legal template.
- `orchestrate.ps1`: Orchestration script for setting up the environment and validating the template structure.
- `README.md`: General user-facing documentation.

## 🛠️ Workflows
- **Setup**: Run `.\orchestrate.ps1 setup` or `pip install -r action_on_judgment/requirements.txt`.
- **Run Application**: `streamlit run action_on_judgment/app.py`.
- **Validate Template**: `.\orchestrate.ps1 validate` (Checks if all required placeholders exist in the DOCX file).

## 🧩 Placeholders
The system relies on 26+ specific placeholders (e.g., `{{PLAINTIFF_NAME}}`, `{{COUNTY_NAME}}`). These are defined in `orchestrate.ps1` for validation and mapped in `app.py` / `generate_doc.py`.

## 🤖 AI Guidelines
- When adding new fields, ensure they are updated in:
    1. The DOCX template (`complaint_action_on_judgment__template_v1.docx`).
    2. The validation list in `orchestrate.ps1`.
    3. The UI form in `app.py`.
    4. The data mapping in `generate_doc.py`.
- Standard legal terminology should be maintained throughout.

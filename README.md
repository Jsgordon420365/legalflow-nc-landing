# LegalFlow NC Landing

Internal legal document automation toolkit for generating "Complaint in Action on Judgment" documents for North Carolina cases.

## Overview

This project provides a Streamlit-based web application for generating standardized legal complaints using DOCX templates. The toolkit is designed for internal use by legal professionals working on active cases.

## Project Structure

```
legalflow-nc-landing/
├── action_on_judgment/     # Main Python application
│   ├── app.py              # Streamlit web interface
│   ├── generate_doc.py     # Document generation engine
│   ├── requirements.txt    # Python dependencies
│   └── complaint_action_on_judgment__template_v1.docx  # DOCX template
├── index.html              # Internal toolkit landing page
├── index_old.html          # Previous marketing landing page
├── setup.ps1               # Initial setup script
├── orchestrate.ps1         # Setup and validation script
└── README.md               # This file
```

## Quick Start

1. **Setup the project:**
   ```powershell
   cd action_on_judgment
   pip install -r requirements.txt
   ```

2. **Run the application:**
   ```powershell
   streamlit run app.py
   ```

3. **Validate the template (optional):**
   ```powershell
   .\orchestrate.ps1 validate
   ```

## Features

- **Template-based Generation**: Uses DOCX templates with Jinja2-style placeholders
- **Streamlit Web Interface**: User-friendly form-based input
- **Validation Scripts**: PowerShell scripts to validate template integrity
- **26 Placeholders**: Comprehensive case data collection (plaintiff/defendant info, dates, attorney details, etc.)

## Requirements

- Python 3.x
- PowerShell (for setup/validation scripts)
- Streamlit
- docxtpl
- python-docx

## Legal Disclaimer

This tool generates legal document drafts from provided inputs. It does not provide legal advice and no attorney-client relationship is formed. All generated documents should be reviewed by qualified legal professionals before filing.

## Technology Stack

- **Frontend**: Streamlit (Python)
- **Document Processing**: docxtpl, python-docx
- **Template Format**: Microsoft Word DOCX
- **Orchestration**: PowerShell

## License

Internal use only.
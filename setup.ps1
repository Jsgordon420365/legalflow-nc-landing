# ver 20251215180412.0

<#
ACTION ON JUDGMENT – PROJECT ORCHESTRATOR

This script:
1. Creates the folder structure
2. Writes requirements.txt
3. Writes generate_doc.py
4. Writes app.py
5. Creates a placeholder for the DOCX template (manual step remains)
#>

function log_message {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $Message"
}

$basePath = Join-Path (Get-Location) "action_on_judgment"

$files = @{
    "requirements.txt" = @"
streamlit
docxtpl
python-docx
"@

    "generate_doc.py" = @"
from docxtpl import DocxTemplate
from io import BytesIO

def generate_complaint(data):
    template = DocxTemplate("complaint_action_on_judgment__template_v1.docx")

    context = {
        "PLAINTIFF_NAME": data["plaintiff_name"],
        "PLAINTIFF_RESIDENCE_ADDRESS": data["plaintiff_address"],
        "DEFENDANT_NAME": data["defendant_name"],
        "DEFENDANT_RESIDENCE_ADDRESS": data["defendant_address"],
        "COUNTY_NAME": data["county_name"],
        "CURRENT_ACTION_FILE_NO": data["current_file_no"],
        "PRIOR_ACTION_FILE_NO": data["prior_file_no"],
        "PRIOR_ACTION_FILING_MONTH_YEAR": data["prior_action_month_year"],
        "PRIOR_JUDGMENT_DATE": data["prior_judgment_date"],
        "PRIOR_JUDGMENT_AMOUNT": data["prior_judgment_amount"],
        "INTEREST_RATE_MONTHLY": data["interest_rate"],
        "INTEREST_START_DATE": data["interest_start_date"],
        "ATTORNEY_FEES_PERCENT": data["attorney_fee_percent"],
        "ATTORNEY_FEES_AMOUNT": data["attorney_fee_amount"],
        "PRIOR_COSTS_AMOUNT": data["prior_costs_amount"],
        "PLEADING_DAY": data["pleading_day"],
        "PLEADING_MONTH": data["pleading_month"],
        "ATTORNEY_NAME": data["attorney_name"],
        "LAW_FIRM_NAME": data["law_firm_name"],
        "LAW_FIRM_ADDRESS": data["law_firm_address"],
        "LAW_FIRM_PHONE": data["law_firm_phone"],
        "LAW_FIRM_FAX": data["law_firm_fax"],
        "LAW_FIRM_EMAIL": data["law_firm_email"],
        "VERIFICATION_COUNTY": data["verification_county"],
        "VERIFICATION_DAY": data["verification_day"],
        "VERIFICATION_MONTH": data["verification_month"],
        "VERIFICATION_YEAR": data["verification_year"],
        "NOTARY_NAME": data["notary_name"],
        "NOTARY_COMMISSION_EXPIRATION": data["notary_expiration"]
    }

    template.render(context)

    output = BytesIO()
    template.save(output)
    output.seek(0)
    return output
"@

    "app.py" = @"
import streamlit as st
from generate_doc import generate_complaint

st.set_page_config(page_title="Action on Judgment – Draft Generator")

st.title("Complaint in Action on Judgment")
st.info("This tool generates a pleading draft. It does not provide legal advice. The accuracy and suitability of this document depend entirely on the information you provide.")

with st.form("intake"):
    plaintiff_name = st.text_input("Plaintiff Name")
    plaintiff_address = st.text_area("Plaintiff Address")

    defendant_name = st.text_input("Defendant Name")
    defendant_address = st.text_area("Defendant Address")

    county_name = st.text_input("County")
    current_file_no = st.text_input("Current Action File No")
    prior_file_no = st.text_input("Prior Action File No")

    prior_action_month_year = st.text_input("Prior Action Filing Month/Year")
    prior_judgment_date = st.text_input("Prior Judgment Date")
    prior_judgment_amount = st.text_input("Prior Judgment Amount")

    interest_rate = st.text_input("Interest Rate Monthly", "1.5")
    interest_start_date = st.text_input("Interest Start Date")

    attorney_fee_percent = st.text_input("Attorney Fee Percent", "15")
    attorney_fee_amount = st.text_input("Attorney Fee Amount")
    prior_costs_amount = st.text_input("Prior Costs Amount")

    pleading_day = st.text_input("Pleading Day")
    pleading_month = st.text_input("Pleading Month")

    attorney_name = st.text_input("Attorney Name")
    law_firm_name = st.text_input("Law Firm Name")
    law_firm_address = st.text_area("Law Firm Address")
    law_firm_phone = st.text_input("Law Firm Phone")
    law_firm_fax = st.text_input("Law Firm Fax")
    law_firm_email = st.text_input("Law Firm Email")

    verification_county = st.text_input("Verification County")
    verification_day = st.text_input("Verification Day")
    verification_month = st.text_input("Verification Month")
    verification_year = st.text_input("Verification Year")

    notary_name = st.text_input("Notary Name")
    notary_expiration = st.text_input("Notary Commission Expiration")

    submitted = st.form_submit_button("Generate Draft")

if submitted:
    doc = generate_complaint(locals())
    st.download_button(
        "Download Complaint DOCX",
        data=doc,
        file_name="Complaint_Action_on_Judgment.docx",
        mime="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    )
"@
}

log_message "Starting Action on Judgment project setup"

if (-not (Test-Path $basePath)) {
    New-Item -ItemType Directory -Path $basePath | Out-Null
    log_message "Created folder: $basePath"
} else {
    log_message "Folder already exists: $basePath"
}

foreach ($file in $files.Keys) {
    $path = Join-Path $basePath $file
    if (-not (Test-Path $path)) {
        Set-Content -Path $path -Value $files[$file] -Encoding UTF8
        log_message "Created file: $file"
    } else {
        log_message "File already exists, skipping: $file"
    }
}

$templatePath = Join-Path $basePath "complaint_action_on_judgment__template_v1.docx"
if (-not (Test-Path $templatePath)) {
    New-Item -ItemType File -Path $templatePath | Out-Null
    log_message "Created placeholder DOCX: complaint_action_on_judgment__template_v1.docx"
    log_message "Manual step required: paste sanitized template content into this DOCX"
} else {
    log_message "Template DOCX already exists"
}

log_message "Setup complete. Next steps:"
log_message "1. Paste sanitized pleading into the DOCX template"
log_message "2. pip install -r requirements.txt"
log_message "3. streamlit run app.py"

# Version History
# 20251215180412.0 Initial orchestration script

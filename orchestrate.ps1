# ver 20251215180412.1

<#
ACTION ON JUDGMENT – PROJECT ORCHESTRATOR
WITH VALIDATION-ONLY DRY RUN MODE

Modes:
- setup      : create folders and files
- validate   : perform dry-run validation only (no document generation)

Usage examples:
.\orchestrate.ps1 setup
.\orchestrate.ps1 validate
#>

param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("setup","validate")]
    [string]$Mode
)

function log_message {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $Message"
}

$basePath = Join-Path (Get-Location) "action_on_judgment"

$requiredFiles = @(
    "requirements.txt",
    "generate_doc.py",
    "app.py",
    "complaint_action_on_judgment__template_v1.docx"
)

$requiredPlaceholders = @(
    "{{PLAINTIFF_NAME}}",
    "{{PLAINTIFF_RESIDENCE_ADDRESS}}",
    "{{DEFENDANT_NAME}}",
    "{{DEFENDANT_RESIDENCE_ADDRESS}}",
    "{{COUNTY_NAME}}",
    "{{CURRENT_ACTION_FILE_NO}}",
    "{{PRIOR_ACTION_FILE_NO}}",
    "{{PRIOR_ACTION_FILING_MONTH_YEAR}}",
    "{{PRIOR_JUDGMENT_DATE}}",
    "{{PRIOR_JUDGMENT_AMOUNT}}",
    "{{INTEREST_RATE_MONTHLY}}",
    "{{INTEREST_START_DATE}}",
    "{{ATTORNEY_FEES_PERCENT}}",
    "{{ATTORNEY_FEES_AMOUNT}}",
    "{{PRIOR_COSTS_AMOUNT}}",
    "{{PLEADING_DAY}}",
    "{{PLEADING_MONTH}}",
    "{{ATTORNEY_NAME}}",
    "{{LAW_FIRM_NAME}}",
    "{{LAW_FIRM_ADDRESS}}",
    "{{LAW_FIRM_PHONE}}",
    "{{LAW_FIRM_FAX}}",
    "{{LAW_FIRM_EMAIL}}",
    "{{VERIFICATION_COUNTY}}",
    "{{VERIFICATION_DAY}}",
    "{{VERIFICATION_MONTH}}",
    "{{VERIFICATION_YEAR}}",
    "{{NOTARY_NAME}}",
    "{{NOTARY_COMMISSION_EXPIRATION}}"
)

if ($Mode -eq "validate") {

    log_message "VALIDATION MODE – DRY RUN ONLY"
    log_message "No files will be created or modified"

    if (-not (Test-Path $basePath)) {
        throw "Project folder missing: $basePath"
    }

    log_message "Project folder found"

    foreach ($file in $requiredFiles) {
        $path = Join-Path $basePath $file
        if (-not (Test-Path $path)) {
            throw "Missing required file: $file"
        }
        log_message "Found file: $file"
    }

    $templatePath = Join-Path $basePath "complaint_action_on_judgment__template_v1.docx"

    log_message "Scanning DOCX template for placeholders"

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($templatePath)

    $docEntry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
    if (-not $docEntry) {
        throw "Invalid DOCX structure: word/document.xml not found"
    }

    $reader = New-Object System.IO.StreamReader($docEntry.Open())
    $xmlContent = $reader.ReadToEnd()
    $reader.Close()
    $zip.Dispose()

    foreach ($placeholder in $requiredPlaceholders) {
        if ($xmlContent -notlike "*$placeholder*") {
            throw "Placeholder missing from template: $placeholder"
        }
        log_message "Placeholder OK: $placeholder"
    }

    log_message "VALIDATION SUCCESSFUL"
    log_message "Template is structurally safe for active case use"
    return
}

if ($Mode -eq "setup") {

    log_message "SETUP MODE – CREATING PROJECT STRUCTURE"

    if (-not (Test-Path $basePath)) {
        New-Item -ItemType Directory -Path $basePath | Out-Null
        log_message "Created folder: $basePath"
    } else {
        log_message "Folder already exists: $basePath"
    }

    log_message "Setup mode complete"
    log_message "Next step: run validation with './orchestrate.ps1 validate'"
}

# Version History
# 20251215180412.0 Initial orchestration script
# 20251215180412.1 Added validation-only dry run mode

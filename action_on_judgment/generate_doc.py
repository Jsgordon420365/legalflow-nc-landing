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

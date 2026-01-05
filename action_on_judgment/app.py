import streamlit as st
from generate_doc import generate_complaint

st.set_page_config(page_title="Action on Judgment â€“ Draft Generator")

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

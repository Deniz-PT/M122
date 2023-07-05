#!/bin/bash

# Funktion zum Erstellen des IC-SENDER-Blocks
create_ic_sender_block() {
    sender_pid=$1
    echo "	<IC-SENDER>"
    echo "		<Pid>$sender_pid</Pid>"
    echo "	</IC-SENDER>"
}

# Funktion zum Erstellen des IC-RECEIVER-Blocks
create_ic_receiver_block() {
    receiver_pid=$1
    echo "	<IC-RECEIVER>"
    echo "		<Pid>$receiver_pid</Pid>"
    echo "	</IC-RECEIVER>"
}

# Funktion zum Erstellen des IR-Ref-Blocks
create_ir_ref_block() {
    echo "	<IR-Ref />"
}

# Funktion zum Erstellen des INTERCHANGE-Blocks
create_interchange_block() {
    sender_pid=$1
    receiver_pid=$2
    create_ic_sender_block $sender_pid
    create_ic_receiver_block $receiver_pid
    create_ir_ref_block
}

# Funktion zum Erstellen des Reference-No-Blocks
create_reference_no_block() {
    reference_no=$1
    echo "		<Reference-No>$reference_no</Reference-No>"
}

# Funktion zum Erstellen des Date-Blocks
create_date_block() {
    date=$1
    echo "		<Date>$date</Date>"
}

# Funktion zum Erstellen des MESSAGE-REFERENCE-Blocks
create_message_reference_block() {
    reference_no=$1
    date=$2
    echo "	<MESSAGE-REFERENCE>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reference_no
    create_date_block $date
    echo "		</REFERENCE-DATE>"
    echo "	</MESSAGE-REFERENCE>"
}

# Funktion zum Erstellen des INVOICE-REFERENCE-Blocks
create_invoice_reference_block() {
    reference_no=$1
    date=$2
    echo "	<INVOICE-REFERENCE>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reference_no
    create_date_block $date
    echo "		</REFERENCE-DATE>"
    echo "	</INVOICE-REFERENCE>"
}

# Funktion zum Erstellen des ORDER-Blocks
create_order_block() {
    reference_no=$1
    date=$2
    echo "	<ORDER>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reference_no
    create_date_block $date
    echo "		</REFERENCE-DATE>"
    echo "	</ORDER>"
}

# Funktion zum Erstellen des REMINDER-Blocks
create_reminder_block() {
    reminder_reference_no=$1
    reminder_date=$2
    echo "	<REMINDER Which=\"MAH\">"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reminder_reference_no
    create_date_block $reminder_date
    echo "		</REFERENCE-DATE>"
    echo "	</REMINDER>"
}

# Funktion zum Erstellen des OTHER-REFERENCE-Blocks
create_other_reference_block() {
    reference_no=$1
    date=$2
    echo "	<OTHER-REFERENCE Type=\"ADE\">"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reference_no
    create_date_block $date
    echo "		</REFERENCE-DATE>"
    echo "	</OTHER-REFERENCE>"
}

# Funktion zum Erstellen des REFERENCE-Blocks
create_reference_block() {
    invoice_reference_reference_no=$1
    invoice
    echo "		<INVOICE-REFERENCE>"
    echo "			<REFERENCE-DATE>"
    create_reference_no_block $invoice_reference_reference_no
    create_date_block $invoice_reference_date
    echo "			</REFERENCE-DATE>"
    echo "		</INVOICE-REFERENCE>"
    create_order_block $order_reference_no $order_date
    create_reminder_block $reminder_reference_no $reminder_date
    create_other_reference_block $other_reference_reference_no $other_reference_date
    echo "	</REFERENCE>"
}

# Funktion zum Erstellen des NAME-ADDRESS-Blocks
create_name_address_block() {
    name=$1
    street=$2
    city=$3
    state=$4
    zip=$5
    country=$6
    echo "	<NAME-ADDRESS Format=\"COM\">"
    echo "		<NAME>"
    echo "			<Line-35>$name</Line-35>"
    echo "			<Line-35>$street</Line-35>"
    echo "			<Line-35>$city</Line-35>"
    echo "			<Line-35>$state</Line-35>"
    echo "			<Line-35>$zip $country</Line-35>"
    echo "		</NAME>"
    echo "		<STREET>"
    echo "			<Line-35>$street</Line-35>"
    echo "			<Line-35>$city</Line-35>"
    echo "			<Line-35>$state</Line-35>"
    echo "		</STREET>"
    echo "		<City>$city</City>"
    echo "		<State>$state</State>"
    echo "		<Zip>$zip</Zip>"
    echo "		<Country>$country</Country>"
    echo "	</NAME-ADDRESS>"
}

# Funktion zum Erstellen des BILLER-Blocks
create_biller_block() {
    tax_no=$1
    party_id=$2
    name=$3
    street=$4
    city=$5
    state=$6
    zip=$7
    country=$8
    acct_no=$9
    acct_name=${10}
    bank_id=${11}
    echo "	<BILLER>"
    echo "		<Tax-No>$tax_no</Tax-No>"
    echo "		<PARTY-ID>"
    echo "			<Pid>$party_id</Pid>"
    echo "		</PARTY-ID>"
    create_name_address_block "$name" "$street" "$city" "$state" "$zip" "$country"
    echo "		<BANK-INFO>"
    echo "			<Acct-No>$acct_no</Acct-No>"
    echo "			<Acct-Name>$acct_name</Acct-Name>"
    echo "			<BankId Type=\"BCNr-nat\" Country=\"$country\">$bank_id</BankId>"
    echo "		</BANK-INFO>"
    echo "	</BILLER>"
}

# Funktion zum Erstellen des PAYER-Blocks
create_payer_block() {
    party_id=$1
    name=$2
    street=$3
    city=$4
    state=$5
    zip=$6
    country=$7
    echo "	<PAYER>"
    echo "		<PARTY-ID>"
    echo "			<Pid>$party_id</Pid>"
    echo "		</PARTY-ID>"
    create_name_address_block "$name" "$street" "$city" "$state" "$zip" "$country"
    echo "	</PAYER>"
}

# Funktion zum Erstellen des INVOICE-AMOUNT-Blocks
create_invoice_amount_block() {
    amount=$1
    echo "	<INVOICE-AMOUNT>"
    echo "		<Amount>$amount</Amount>"
    echo "	</INVOICE-AMOUNT>"
}

# Funktion zum Erstellen des VAT-AMOUNT-Blocks
create_vat_amount_block() {
    amount=$1
    echo "	<VAT-AMOUNT>"
    echo "		<Amount>$amount</Amount>"
    echo "	</VAT-AMOUNT>"
}

# Funktion zum Erstellen des DEPOSIT-AMOUNT-Blocks
create_deposit_amount_block() {
    amount=$1
    reference_no=$2
    date=$3
    echo "	<DEPOSIT-AMOUNT>"
    echo "		<Amount>$amount</Amount>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $reference_no
    create_date_block $date
    echo "		</REFERENCE-DATE>"
    echo "	</DEPOSIT-AMOUNT>"
}

# Funktion zum Erstellen des EXTENDED-AMOUNT-Blocks
create_extended_amount_block() {
    amount=$1
    echo "	<EXTENDED-AMOUNT Type=\"79\">"
    echo "		<Amount>$amount</Amount>"
    echo "	</EXTENDED-AMOUNT>"
}

# Funktion zum Erstellen des TAX-Blocks
create_tax_block() {
    tax_basis=$1
    tax_rate=$2
    tax_amount=$3
    echo "	<TAX>"
    echo "		<TAX-BASIS>"
    echo "			<Amount>$tax_basis</Amount>"
    echo "		</TAX-BASIS>"
    echo "		<Rate Categorie=\"S\">$tax_rate</Rate>"
    echo "		<Amount>$tax_amount</Amount>"
    echo "	</TAX>"
}

# Funktion zum Erstellen des PAYMENT-TERMS-Blocks
create_payment_terms_block() {
    basic_payment_type=$1
    basic_terms_type=$2
    basic_payment_period=$3
    basic_payment_date=$4
    discount_percentage=$5
    discount_payment_period=$6
    discount_payment_date=$7
    echo "	<PAYMENT-TERMS>"
    echo "		<BASIC Payment-Type=\"$basic_payment_type\" Terms-Type=\"$basic_terms_type\">"
    echo "			<TERMS>"
    echo "				<Payment-Period Type=\"M\" On-Or-After=\"1\" Reference-Day=\"31\">$basic_payment_period</Payment-Period>"
    create_date_block $basic_payment_date
    echo "			</TERMS>"
    echo "		</BASIC>"
    echo "		<DISCOUNT Terms-Type=\"22\">"
    echo "			<Discount-Percentage>$discount_percentage</Discount-Percentage>"
    echo "			<TERMS>"
    echo "				<Payment-Period Type=\"M\" On-Or-After=\"1\" Reference-Day=\"31\">$discount_payment_period</Payment-Period>"
    create_date_block $discount_payment_date
    echo "			</TERMS>"
    echo "			<Back-Pack-Container Encode=\"Base64\"> </Back-Pack-Container>"
    echo "		</DISCOUNT>"
    echo "	</PAYMENT-TERMS>"
}

# Funktion zum Erstellen des XML-FSCM-INVOICE-2003A-Dokuments
create_xml_fscm_invoice_2003a() {
    echo "<XML-FSCM-INVOICE-2003A>"
    echo "<INTERCHANGE>"
    echo "	<IC-SENDER>"
    echo "		<Pid>$biller_party_id</Pid>"
    echo "	</IC-SENDER>"
    echo "	<IC-RECEIVER>"
    echo "		<Pid>$payer_party_id</Pid>"
    echo "	</IC-RECEIVER>"
    echo "	<IR-Ref />"
    echo "</INTERCHANGE>"
    echo "<INVOICE>"
    echo "	<HEADER>"
    echo "	<FUNCTION-FLAGS>"
    echo "		<Confirmation-Flag />"
    echo "		<Canellation-Flag />"
    echo "	</FUNCTION-FLAGS>"
    echo "	<MESSAGE-REFERENCE>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $invoice_reference_reference_no
    create_date_block $invoice_reference_date
    echo "		</REFERENCE-DATE>"
    echo "	</MESSAGE-REFERENCE>"
    echo "	<PRINT-DATE>"
    create_date_block $invoice_print_date
    echo "	</PRINT-DATE>"
    echo "	<REFERENCE>"
    echo "		<INVOICE-REFERENCE>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $invoice_reference_no
    create_date_block $invoice_reference_date
    echo "		</REFERENCE-DATE>"
    echo "		</INVOICE-REFERENCE>"
    echo "		<ORDER>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $invoice_order_no
    create_date_block $invoice_order_date
    echo "		</REFERENCE-DATE>"
    echo "		</ORDER>"
    echo "		<REMINDER Which=\"MAH\">"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block
    create_date_block
    echo "			</REFERENCE-DATE>"
    echo "		</REMINDER>"
    echo "		<OTHER-REFERENCE Type=\"ADE\">"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $invoice_other_reference_no
    create_date_block $invoice_other_reference_date
    echo "		</REFERENCE-DATE>"
    echo "		</OTHER-REFERENCE>"
    echo "	</REFERENCE>"
    echo "	<BILLER>"
    echo "		<Tax-No>$biller_tax_no</Tax-No>"
    echo "		<Doc-Reference Type=\"$biller_doc_reference_type\"></Doc-Reference>"
    echo "		<PARTY-ID>"
    echo "		<Pid>$biller_party_id</Pid>"
    echo "		</PARTY-ID>"
    echo "		<NAME-ADDRESS Format=\"COM\">"
    echo "		<NAME>"
    echo "			<Line-35>$biller_name</Line-35>"
    echo "			<Line-35>$biller_address_line_1</Line-35>"
    echo "			<Line-35>$biller_address_line_2</Line-35>"
    echo "			<Line-35>$biller_address_line_3</Line-35>"
    echo "			<Line-35>$biller_address_line_4</Line-35>"
    echo "		</NAME>"
    echo "		<STREET>"
    echo "			<Line-35>$biller_street_line_1</Line-35>"
    echo "			<Line-35>$biller_street_line_2</Line-35>"
    echo "			<Line-35>$biller_street_line_3</Line-35>"
    echo "		</STREET>"
    echo "
    echo "		<CITY>$biller_city</CITY>"
    echo "		<STATE>$biller_state</STATE>"
    echo "		<ZIP>$biller_zip</ZIP>"
    echo "		<COUNTRY>$biller_country</COUNTRY>"
    echo "		</NAME-ADDRESS>"
    echo "		<BANK-INFO>"
    echo "		<Acct-No>$biller_bank_account_no</Acct-No>"
    echo "		<Acct-Name>$biller_bank_account_name</Acct-Name>"
    echo "		<BankId Type=\"$biller_bank_id_type\" Country=\"$biller_bank_id_country\">$biller_bank_id</BankId>"
    echo "		</BANK-INFO>"
    echo "	</BILLER>"
    echo "	<PAYER>"
    echo "		<PARTY-ID>"
    echo "		<Pid>$payer_party_id</Pid>"
    echo "		</PARTY-ID>"
    echo "		<NAME-ADDRESS Format=\"COM\">"
    echo "		<NAME>"
    echo "			<Line-35>$payer_name</Line-35>"
    echo "			<Line-35>$payer_address_line_1</Line-35>"
    echo "			<Line-35>$payer_address_line_2</Line-35>"
    echo "			<Line-35>$payer_address_line_3</Line-35>"
    echo "			<Line-35>$payer_address_line_4</Line-35>"
    echo "		</NAME>"
    echo "		<STREET>"
    echo "			<Line-35>$payer_street_line_1</Line-35>"
    echo "			<Line-35>$payer_street_line_2</Line-35>"
    echo "			<Line-35>$payer_street_line_3</Line-35>"
    echo "		</STREET>"
    echo "		<CITY>$payer_city</CITY>"
    echo "		<STATE>$payer_state</STATE>"
    echo "		<ZIP>$payer_zip</ZIP>"
    echo "		<COUNTRY>$payer_country</COUNTRY>"
    echo "		</NAME-ADDRESS>"
    echo "	</PAYER>"
    echo "	</HEADER>"
    echo "	<LINE-ITEM />"
    echo "	<SUMMARY>"
    echo "	<INVOICE-AMOUNT>"
    echo "		<Amount>$invoice_amount</Amount>"
    echo "	</INVOICE-AMOUNT>"
    echo "	<VAT-AMOUNT>"
    create_amount_block $vat_amount
    echo "	</VAT-AMOUNT>"
    echo "	<DEPOSIT-AMOUNT>"
    echo "		<Amount>$deposit_amount</Amount>"
    echo "		<REFERENCE-DATE>"
    create_reference_no_block $deposit_reference_no
    create_date_block $deposit_reference_date
    echo "		</REFERENCE-DATE>"
    echo "	</DEPOSIT-AMOUNT>"
    echo "	<EXTENDED-AMOUNT Type=\"$extended_amount_type\">"
    create_amount_block $extended_amount
    echo "	</EXTENDED-AMOUNT>"
    echo "	<TAX>"
    echo "		<TAX-BASIS>"
    create_amount_block $tax_basis_amount
    echo "		</TAX-BASIS>"
    echo "		<Rate Categorie=\"$tax_rate_category\">$tax_rate</Rate>"
    echo "		<Amount>"
    create_amount_block $tax_amount
    echo "		</Amount>"
    echo "	</TAX>"
    echo "	<PAYMENT-TERMS>"
    echo "		<BASIC Payment-Type=\"$payment_type\" Terms-Type=\"$terms_type\">"
    echo "		<TERMS>"
    echo "			<Payment-Period Type=\"$payment_period_type\" On-Or-After=\"$on_or_after\" Reference-Day=\"$reference_day\">$payment_period</Payment-Period>"
    echo "			<Date>$payment_terms_date</Date>"
    echo "		</TERMS>"
    echo "		</BASIC>"
    echo "		<DISCOUNT Terms-Type=\"$discount_terms_type\">"
    echo "		<Discount-Percentage>$discount_percentage</Discount-Percentage>"
    echo "		<TERMS>"
    echo "			<Payment-Period Type=\"$payment_period_type\" On-Or-After=\"$on_or_after\" Reference-Day=\"$reference_day\"></Payment-Period>"
    echo "			<Date>$discount_terms_date</Date>"
    echo "		</TERMS>"
    echo "		<Back-Pack-Container Encode=\"$back_pack_container_encode\">$back_pack_container_data</Back-Pack-Container>"
    echo "		</DISCOUNT>"
    echo "	</PAYMENT-TERMS>"
    echo "</SUMMARY>"
    echo "</INVOICE>"
    echo "</XML-FSCM-INVOICE-2003A>"
}

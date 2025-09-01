From NAV to BC

# Tables

## Account -> Account

Field mapping

* "Balance Account Type" => "Bal. Account Type" - NB værdierne svarer IKKE til dem i BC. I NAV er 1 = Bank Account, i BC er 3 = Bank Account
* "Balance Account" => "Bal. Account No." - BEMÆRK går fra Code 40 til Code 20. Bør ikke være et problem da Bank Account er 20

? Når man angiver **Bal. Account No.** (enten Bankkonto eller Finanskonto), skal dimension 1 og 2 så tages fra kontoen? (altså enten fra bank eller finans)
? TableRelation missing for field **Security Account No**.

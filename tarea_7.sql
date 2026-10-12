INSERT INTO core.customers (customer_id, first_name, last_name, email, phone_number, tax_id, date_of_birth)
VALUES ('11111111-1111-1111-1111-111111111111', 'John', 'Doe', 'john.doe@email.com', '555-0100', 'TAX-100', '1985-04-12')
ON CONFLICT (email) DO NOTHING;

ON Conflict (account_number) Do Nothing;

UPDATE core.accounts
Where 'ACCT-1001' RETURNING account_number, balance;

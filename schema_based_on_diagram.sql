CREATE DATABASE schema;
\c schema;
-- Create table named PATIENTS
CREATE TABLE patients(
    id int primary key,
    name varchar(255),
    date_of_birth date
);

-- Create table named medical histories
CREATE TABLE medical_histories(
    id int primary key,
    admitted_at timestamp,
    patient_id int,
    status varchar(255)
);

-- Create table named invoices
CREATE TABLE invoices(
    id int primary key,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    CONSTRAINT fkey_history_id foreign key(medical_history_id) references medical_histories(id)
);

ALTER table medical_histories drop column patient_id;
ALTER TABLE medical_histories add column patient_id int references patients(id);

-- Create table named invoice_items
CREATE TABLE invoice_items(
    id int primary key,
    unit_price decimal,
    quantity int,
    total_price decimal,
    invoice_id int,
    treatment_id int,
    CONSTRAINT fkey_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id)
);

--  Create table named treatments
CREATE TABLE treatments(
    id int primary key,
    type varchar(255),
    name varchar(255),
);

BEGIN;
ALTER TABLE invoice_items
    DROP COLUMN treatment_id,
    ADD COLUMN treatment_id int REFERENCES treatments(id);
COMMIT;

CREATE TABLE medical_histories_treatments (
  medical_id int,
  treatment_id int,
  PRIMARY KEY (medical_id, treatment_id),
  CONSTRAINT fkey_medical_id FOREIGN KEY(medical_id) REFERENCES medical_histories(id),
  CONSTRAINT fkey_treatments_id FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE INDEX medical_history_id_index on invoices(
    medical_history_id
);

CREATE INDEX medical_history_id on medical_histories(
    patient_id
);

CREATE INDEX treatment_id_index on invoice_items(
    treatment_id
);

CREATE INDEX invoice_id_index on invoice_items(
    invoice_id
);

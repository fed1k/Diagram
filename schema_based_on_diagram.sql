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
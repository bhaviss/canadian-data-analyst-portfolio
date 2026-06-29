-- ============================================================
-- SCHEMA + SEED DATA: Canadian Retail & Healthcare SQL Projects
-- Run this first to create tables and load sample data
-- Compatible with: PostgreSQL 13+, Supabase
-- ============================================================

-- ============================================================
-- PART 1: RETAIL SCHEMA (for retail_kpi_queries.sql)
-- ============================================================

DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS provinces CASCADE;

-- Provinces
CREATE TABLE provinces (
  province_code VARCHAR(2) PRIMARY KEY,
  province_name VARCHAR(50) NOT NULL,
  region        VARCHAR(20) NOT NULL
);

INSERT INTO provinces VALUES
  ('ON', 'Ontario',                'Central'),
  ('QC', 'Quebec',                 'Central'),
  ('BC', 'British Columbia',       'West'),
  ('AB', 'Alberta',                'West'),
  ('MB', 'Manitoba',               'Prairies'),
  ('SK', 'Saskatchewan',           'Prairies'),
  ('NS', 'Nova Scotia',            'Atlantic'),
  ('NB', 'New Brunswick',          'Atlantic'),
  ('NL', 'Newfoundland',           'Atlantic'),
  ('PE', 'Prince Edward Island',   'Atlantic');

-- Stores
CREATE TABLE stores (
  store_id      SERIAL PRIMARY KEY,
  store_name    VARCHAR(100) NOT NULL,
  city          VARCHAR(50)  NOT NULL,
  province_code VARCHAR(2)   REFERENCES provinces(province_code),
  store_type    VARCHAR(20)  NOT NULL  -- 'Superstore', 'Express', 'Warehouse'
);

INSERT INTO stores (store_name, city, province_code, store_type) VALUES
  ('Maple Grocery Toronto Downtown',  'Toronto',    'ON', 'Superstore'),
  ('Maple Grocery Mississauga',       'Mississauga','ON', 'Superstore'),
  ('Maple Grocery Ottawa East',       'Ottawa',     'ON', 'Express'),
  ('Maple Grocery Montreal Centre',   'Montreal',   'QC', 'Superstore'),
  ('Maple Grocery Quebec City',       'Quebec City','QC', 'Express'),
  ('Maple Grocery Vancouver Main',    'Vancouver',  'BC', 'Superstore'),
  ('Maple Grocery Surrey',            'Surrey',     'BC', 'Express'),
  ('Maple Grocery Calgary NW',        'Calgary',    'AB', 'Superstore'),
  ('Maple Grocery Edmonton South',    'Edmonton',   'AB', 'Superstore'),
  ('Maple Grocery Winnipeg',          'Winnipeg',   'MB', 'Superstore');

-- Products
CREATE TABLE products (
  product_id   SERIAL PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category     VARCHAR(50)  NOT NULL,
  subcategory  VARCHAR(50)  NOT NULL,
  unit_cost    DECIMAL(8,2) NOT NULL,
  sku          VARCHAR(20)  UNIQUE NOT NULL
);

INSERT INTO products (product_name, category, subcategory, unit_cost, sku) VALUES
  ('Milk 4L Homo',           'Dairy',    'Milk',     2.80, 'DAI-001'),
  ('Cheddar Cheese 500g',    'Dairy',    'Cheese',   4.50, 'DAI-002'),
  ('Greek Yogurt 750g',      'Dairy',    'Yogurt',   3.20, 'DAI-003'),
  ('Bread Whole Wheat',      'Bakery',   'Bread',    1.80, 'BAK-001'),
  ('Sourdough Loaf',         'Bakery',   'Bread',    2.60, 'BAK-002'),
  ('Chicken Breast 1kg',     'Meat',     'Poultry',  6.50, 'MEA-001'),
  ('Ground Beef 500g',       'Meat',     'Beef',     4.20, 'MEA-002'),
  ('Atlantic Salmon 300g',   'Seafood',  'Fish',     7.80, 'SEA-001'),
  ('Broccoli Crown',         'Produce',  'Vegetable',1.20, 'PRO-001'),
  ('Gala Apples 3lb',        'Produce',  'Fruit',    2.10, 'PRO-002'),
  ('Orange Juice 1.89L',     'Beverages','Juice',    3.40, 'BEV-001'),
  ('Sparkling Water 12pk',   'Beverages','Water',    5.50, 'BEV-002'),
  ('Pasta Penne 900g',       'Pantry',   'Pasta',    1.90, 'PAN-001'),
  ('Tomato Sauce 680ml',     'Pantry',   'Sauces',   1.50, 'PAN-002'),
  ('Olive Oil 1L',           'Pantry',   'Oils',     7.20, 'PAN-003');

-- Customers
CREATE TABLE customers (
  customer_id       SERIAL PRIMARY KEY,
  first_name        VARCHAR(50)  NOT NULL,
  last_name         VARCHAR(50)  NOT NULL,
  email             VARCHAR(100) UNIQUE NOT NULL,
  province_code     VARCHAR(2)   REFERENCES provinces(province_code),
  postal_code       VARCHAR(7),
  registration_date DATE         NOT NULL,
  loyalty_tier      VARCHAR(20)  DEFAULT 'Standard'  -- Standard, Silver, Gold, Platinum
);

INSERT INTO customers (first_name, last_name, email, province_code, postal_code, registration_date, loyalty_tier) VALUES
  ('Emma',    'Tremblay',  'emma.tremblay@email.ca',    'QC', 'H2X 1Y3', '2021-03-15', 'Gold'),
  ('Liam',    'Smith',     'liam.smith@email.ca',       'ON', 'M5V 2T6', '2020-07-22', 'Platinum'),
  ('Olivia',  'Johnson',   'olivia.j@email.ca',         'BC', 'V6B 1A1', '2022-01-10', 'Silver'),
  ('Noah',    'Williams',  'noah.w@email.ca',           'AB', 'T2P 1J9', '2021-11-05', 'Gold'),
  ('Ava',     'Brown',     'ava.brown@email.ca',        'ON', 'K1A 0B1', '2020-05-30', 'Platinum'),
  ('William', 'Jones',     'william.j@email.ca',        'QC', 'G1R 4S9', '2023-02-14', 'Standard'),
  ('Sophia',  'Garcia',    'sophia.g@email.ca',         'BC', 'V5K 0A1', '2022-08-19', 'Silver'),
  ('James',   'Miller',    'james.m@email.ca',          'AB', 'T6G 2R3', '2021-06-07', 'Gold'),
  ('Isabella','Davis',     'isabella.d@email.ca',       'MB', 'R3C 0V8', '2023-05-21', 'Standard'),
  ('Oliver',  'Wilson',    'oliver.w@email.ca',         'ON', 'L4B 1J4', '2020-09-12', 'Platinum'),
  ('Mia',     'Martinez',  'mia.m@email.ca',            'NS', 'B3H 1A1', '2022-11-30', 'Silver'),
  ('Ethan',   'Anderson',  'ethan.a@email.ca',          'ON', 'N2J 4G8', '2021-04-16', 'Gold'),
  ('Charlotte','Taylor',   'charlotte.t@email.ca',      'QC', 'J4H 1H1', '2023-07-03', 'Standard'),
  ('Lucas',   'Thomas',    'lucas.t@email.ca',          'BC', 'V8W 1N2', '2020-12-25', 'Platinum'),
  ('Amelia',  'Hernandez', 'amelia.h@email.ca',         'AB', 'T1X 0L3', '2022-03-08', 'Silver'),
  ('Mason',   'Moore',     'mason.mo@email.ca',         'SK', 'S7K 2H6', '2021-09-19', 'Standard'),
  ('Harper',  'Martin',    'harper.ma@email.ca',        'NB', 'E1C 1H1', '2023-01-27', 'Standard'),
  ('Elijah',  'Jackson',   'elijah.j@email.ca',         'ON', 'M4C 1M5', '2020-08-14', 'Gold'),
  ('Evelyn',  'Thompson',  'evelyn.t@email.ca',         'QC', 'H3A 0G4', '2022-06-11', 'Silver'),
  ('Logan',   'White',     'logan.w@email.ca',          'BC', 'V6Z 2E7', '2021-07-29', 'Gold');

-- Sales (transactions)
CREATE TABLE sales (
  transaction_id   SERIAL PRIMARY KEY,
  customer_id      INT          REFERENCES customers(customer_id),
  product_id       INT          REFERENCES products(product_id),
  store_id         INT          REFERENCES stores(store_id),
  transaction_date DATE         NOT NULL,
  quantity         INT          NOT NULL CHECK (quantity > 0),
  unit_price       DECIMAL(8,2) NOT NULL,
  discount_pct     DECIMAL(5,4) DEFAULT 0.0
);

-- Generate ~300 realistic sales rows across 2022-2024
INSERT INTO sales (customer_id, product_id, store_id, transaction_date, quantity, unit_price, discount_pct)
SELECT
  (random() * 19 + 1)::INT                                        AS customer_id,
  (random() * 14 + 1)::INT                                        AS product_id,
  (random() * 9  + 1)::INT                                        AS store_id,
  DATE '2022-01-01' + (random() * 900)::INT                       AS transaction_date,
  (random() * 5 + 1)::INT                                         AS quantity,
  ROUND((random() * 12 + 1.5)::NUMERIC, 2)                        AS unit_price,
  CASE WHEN random() < 0.2 THEN ROUND((random() * 0.25)::NUMERIC,4)
       ELSE 0 END                                                  AS discount_pct
FROM generate_series(1, 300);

-- ============================================================
-- PART 2: HEALTHCARE SCHEMA (for healthcare_wait_times.sql)
-- ============================================================

DROP TABLE IF EXISTS wait_times CASCADE;
DROP TABLE IF EXISTS hospitals CASCADE;
DROP TABLE IF EXISTS procedure_types CASCADE;

-- Provinces already created above (shared)

-- Procedure types (with national benchmarks in days)
CREATE TABLE procedure_types (
  procedure_code   VARCHAR(10) PRIMARY KEY,
  procedure_name   VARCHAR(100) NOT NULL,
  procedure_category VARCHAR(50) NOT NULL,
  benchmark_days   INT NOT NULL   -- Canada Health Act benchmark
);

INSERT INTO procedure_types VALUES
  ('HIP-REP',  'Hip Replacement',          'Orthopaedic',      182),
  ('KNEE-REP', 'Knee Replacement',          'Orthopaedic',      182),
  ('CATARACT', 'Cataract Surgery',          'Ophthalmology',    112),
  ('CARDIAC',  'Cardiac Bypass Surgery',    'Cardiac',           14),
  ('MRI-SCAN', 'MRI Diagnostic Scan',       'Diagnostic',        30),
  ('CT-SCAN',  'CT Diagnostic Scan',        'Diagnostic',        30),
  ('COLONOSC', 'Colonoscopy',               'Gastroenterology',  60),
  ('HIP-FRAC', 'Hip Fracture Repair',       'Orthopaedic',        2),
  ('GALLBLAD', 'Gallbladder Removal',       'General Surgery',   56),
  ('TONSIL',   'Tonsillectomy',             'ENT',               56);

-- Hospitals
CREATE TABLE hospitals (
  hospital_id    SERIAL PRIMARY KEY,
  hospital_name  VARCHAR(100) NOT NULL,
  city           VARCHAR(50)  NOT NULL,
  province_code  VARCHAR(2)   REFERENCES provinces(province_code),
  hospital_type  VARCHAR(30)  NOT NULL,  -- 'Teaching', 'Regional', 'Community'
  bed_count      INT
);

INSERT INTO hospitals (hospital_name, city, province_code, hospital_type, bed_count) VALUES
  ('Toronto General Hospital',        'Toronto',    'ON', 'Teaching',  471),
  ('Sunnybrook Health Sciences',      'Toronto',    'ON', 'Teaching',  395),
  ('Ottawa General Hospital',         'Ottawa',     'ON', 'Regional',  279),
  ('CHUM Montreal',                   'Montreal',   'QC', 'Teaching',  772),
  ('McGill University Health Centre', 'Montreal',   'QC', 'Teaching',  500),
  ('Vancouver General Hospital',      'Vancouver',  'BC', 'Teaching',  955),
  ('BC Children''s Hospital',         'Vancouver',  'BC', 'Teaching',  182),
  ('Foothills Medical Centre',        'Calgary',    'AB', 'Regional',  883),
  ('University of Alberta Hospital',  'Edmonton',   'AB', 'Teaching',  600),
  ('Health Sciences Centre Winnipeg', 'Winnipeg',   'MB', 'Regional',  1000),
  ('Queen Elizabeth II Health',       'Halifax',    'NS', 'Teaching',  375),
  ('Saint John Regional Hospital',    'Saint John', 'NB', 'Regional',  254);

-- Wait times (patient-level records)
CREATE TABLE wait_times (
  wait_id        SERIAL PRIMARY KEY,
  patient_id     INT          NOT NULL,
  hospital_id    INT          REFERENCES hospitals(hospital_id),
  procedure_code VARCHAR(10)  REFERENCES procedure_types(procedure_code),
  referral_date  DATE         NOT NULL,
  treatment_date DATE,
  wait_days      INT GENERATED ALWAYS AS
                   (CASE WHEN treatment_date IS NOT NULL
                         THEN treatment_date - referral_date END) STORED,
  outcome        VARCHAR(20)  DEFAULT 'Completed'  -- Completed, Cancelled, Pending
);

-- Generate ~500 wait time records spanning 2019-2024
INSERT INTO wait_times (patient_id, hospital_id, procedure_code, referral_date, treatment_date, outcome)
SELECT
  (random() * 9000 + 1000)::INT                              AS patient_id,
  (random() * 11 + 1)::INT                                   AS hospital_id,
  (ARRAY['HIP-REP','KNEE-REP','CATARACT','MRI-SCAN',
         'CT-SCAN','COLONOSC','GALLBLAD','CARDIAC'])[
   (random() * 7 + 1)::INT]                                  AS procedure_code,
  DATE '2019-01-01' + (random() * 2000)::INT                 AS referral_date,
  DATE '2019-01-01' + (random() * 2000)::INT
    + (random() * 350 + 10)::INT                              AS treatment_date,
  CASE WHEN random() < 0.07 THEN 'Cancelled' ELSE 'Completed' END AS outcome
FROM generate_series(1, 500);

-- ============================================================
-- QUICK VERIFICATION QUERIES
-- ============================================================
-- SELECT COUNT(*) FROM sales;          -- should be 300
-- SELECT COUNT(*) FROM wait_times;     -- should be 500
-- SELECT * FROM provinces ORDER BY 1;
-- SELECT * FROM stores LIMIT 5;
-- SELECT * FROM procedure_types;

-- ============================================================
-- END OF SCHEMA SETUP
-- ============================================================

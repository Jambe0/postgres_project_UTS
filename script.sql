CREATE SCHEMA SALAM;

CREATE TABLE SALAM.mahasiswas (
  nim VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(100) UNIQUE,
  umur INT CHECK (umur >= 17),
  jurusan VARCHAR(50) DEFAULT 'Teknik Informatika'
);

INSERT INTO SALAM.mahasiswas (nim, nama, umur) 
VALUES ('001', 'Budi', 18);

INSERT INTO SALAM.mahasiswas (nim, nama, umur) 
VALUES ('002', 'Andi', 15);

INSERT INTO SALAM.mahasiswas (nim, nama, umur) 
VALUES ('003', 'Budi', 20);

SELECT * FROM SALAM.mahasiswas;

CREATE USER backend_dev WITH PASSWORD 'backend';
CREATE USER bi_dev WITH PASSWORD 'bidev';
CREATE USER data_engineer WITH PASSWORD 'engineer';

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;

GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT ON TABLES TO bi_dev;

GRANT USAGE, CREATE ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT ALL PRIVILEGES ON TABLES TO data_engineer;

SET ROLE backend_dev;

INSERT INTO SALAM.mahasiswas (nim, nama, umur) VALUES ('004', 'Rizky', 19);

RESET ROLE;

GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT USAGE, CREATE ON SCHEMA SALAM TO data_engineer;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;

SET ROLE backend_dev;

INSERT INTO SALAM.mahasiswas (nim, nama, umur) VALUES ('004', 'Rizky', 19);

SELECT * FROM SALAM.mahasiswas;

DELETE FROM SALAM.mahasiswas WHERE nim='004';

RESET ROLE;
SET ROLE bi_dev;

SELECT * FROM SALAM.mahasiswas;

INSERT INTO SALAM.mahasiswas (nim, nama, umur) VALUES ('005', 'Doni', 20);

RESET ROLE;
SET ROLE data_engineer;

CREATE TABLE SALAM.log_aktivitas (
  id SERIAL PRIMARY KEY,
  waktu TIMESTAMP DEFAULT NOW(),
  aktivitas VARCHAR(100)
);

INSERT INTO SALAM.log_aktivitas (aktivitas) VALUES ('Menambah tabel baru');

SELECT * FROM SALAM.log_aktivitas;

CREATE TABLE SALAM.dosen (
  nip VARCHAR(10) PRIMARY KEY,             
  nama_dosen VARCHAR(100) NOT NULL,        
  mata_kuliah VARCHAR(100),                
  usia INT CHECK (usia >= 25),             
  jabatan VARCHAR(50) DEFAULT 'Dosen Tetap' 
);

INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES
('D001', 'Pak Budi Santoso', 'Basis Data', 35),
('D002', 'Bu Siti Aminah', 'Pemrograman Java', 29),
('D003', 'Pak Andi Wijaya', 'IMK', 40);

SELECT * FROM SALAM.dosen;

INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES ('D004', 'Pak Dede', 'Jaringan Komputer', 20);

SET ROLE backend_dev;
INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES ('D005', 'Bu Ratna Dewi', 'Struktur Data', 32);

RESET ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE ON SALAM.dosen TO backend_dev;
GRANT SELECT ON SALAM.dosen TO bi_dev;
GRANT ALL PRIVILEGES ON SALAM.dosen TO data_engineer;

SET ROLE backend_dev;
INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES ('D005', 'Bu Ratna Dewi', 'Struktur Data', 32);

DELETE FROM SALAM.dosen WHERE nip='D005';

SET ROLE bi_dev;
INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES ('D006', 'Pak Joko', 'Jaringan', 45);

CREATE VIEW SALAM.view_dosen_tua AS
SELECT nama_dosen, mata_kuliah, usia
FROM SALAM.dosen
WHERE usia >= 35;

SET ROLE data_engineer;

CREATE VIEW SALAM.view_dosen_tua AS
SELECT nama_dosen, mata_kuliah, usia
FROM SALAM.dosen
WHERE usia >= 35;

SELECT * FROM SALAM.dosen;

INSERT INTO SALAM.dosen (nip, nama_dosen, mata_kuliah, usia)
VALUES ('D010', 'Pak Joko Susilo', 'AI dan Data Mining', 45);

SELECT * FROM SALAM.view_dosen_tua;


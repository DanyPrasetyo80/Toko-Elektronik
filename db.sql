-- Buat database
CREATE DATABASE db_techzone;
USE db_techzone;

-- Tabel admin
CREATE TABLE admin (
  id_admin INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  nama_admin VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  tanggal_dibuat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel produk
CREATE TABLE produk (
  id_produk INT AUTO_INCREMENT PRIMARY KEY,
  nama_produk VARCHAR(100) NOT NULL,
  deskripsi TEXT,
  harga DECIMAL(12,2) NOT NULL,
  stok INT DEFAULT 0,
  gambar VARCHAR(255),
  kategori ENUM('Laptop', 'Smartphone', 'Aksesoris', 'Lainnya') DEFAULT 'Lainnya',
  id_admin INT,
  tanggal_tambah TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_admin) REFERENCES admin(id_admin) ON DELETE SET NULL
);

-- Tabel pelanggan
CREATE TABLE pelanggan (
  id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
  nama_pelanggan VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  no_hp VARCHAR(20),
  alamat TEXT,
  tanggal_daftar TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel pesanan
CREATE TABLE pesanan (
  id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
  id_pelanggan INT,
  tanggal_pesan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('Menunggu Pembayaran', 'Dibayar', 'Dikirim', 'Selesai', 'Dibatalkan') DEFAULT 'Menunggu Pembayaran',
  total_harga DECIMAL(12,2) DEFAULT 0,
  metode_pembayaran ENUM('Transfer Bank', 'COD', 'E-Wallet') DEFAULT 'Transfer Bank',
  FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE
);

-- Tabel detail_pesanan
CREATE TABLE detail_pesanan (
  id_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_pesanan INT,
  id_produk INT,
  jumlah INT NOT NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) ON DELETE CASCADE,
  FOREIGN KEY (id_produk) REFERENCES produk(id_produk) ON DELETE CASCADE
);

-- Contoh data awal admin
INSERT INTO admin (username, password, nama_admin, email)
VALUES ('admin1', MD5('admin123'), 'Admin TechZone', 'admin@techzone.com');

-- Contoh data awal produk
INSERT INTO produk (nama_produk, deskripsi, harga, stok, gambar, kategori, id_admin) VALUES
('ASUS Vivobook 14', 'Laptop ringan dan cepat untuk belajar maupun bekerja.', 7499000, 10, 'laptop.jpg', 'Laptop', 1),
('Samsung Galaxy A55', 'Performa tinggi dengan kamera jernih dan baterai tahan lama.', 5299000, 15, 'smartphone.jpg', 'Smartphone', 1),
('Headset Blueto

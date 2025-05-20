# 📈 Tối Ưu Hóa Hiệu Năng PostgreSQL

## Mục lục

- [Giới thiệu](#giới-thiệu)
- [Nguyên tắc cốt lõi](#nguyên-tắc-cốt-lõi)
- [1. Cấu hình PostgreSQL tối ưu](#1-cấu-hình-postgresql-tối-ưu)
- [2. Tối ưu hóa truy vấn SQL](#2-tối-ưu-hóa-truy-vấn-sql)
- [3. Tối ưu hóa chỉ mục (Index)](#3-tối-ưu-hóa-chỉ-mục-index)
- [4. Quản lý autovacuum và phân mảnh](#4-quản-lý-autovacuum-và-phân-mảnh)
- [5. Giám sát và đo hiệu năng](#5-giám-sát-và-đo-hiệu-năng)
- [6. Caching và Connection Pooling](#6-caching-và-connection-pooling)
- [7. Chiến lược mở rộng quy mô](#7-chiến-lược-mở-rộng-quy-mô)
- [8. Công cụ hỗ trợ tối ưu hóa](#8-công-cụ-hỗ-trợ-tối-ưu-hóa)
- [Tài nguyên tham khảo](#tài-nguyên-tham-khảo)

---

## Giới thiệu

Tối ưu hóa hiệu năng PostgreSQL là quá trình cải thiện tốc độ và độ ổn định của hệ quản trị cơ sở dữ liệu, từ cấu hình hệ thống đến thiết kế truy vấn. Mục tiêu là đảm bảo ứng dụng hoạt động nhanh, tiết kiệm tài nguyên và mở rộng tốt.

---

## Nguyên tắc cốt lõi

- Thiết kế cơ sở dữ liệu hợp lý
- Giảm chi phí truy vấn
- Tránh overfetching và underfetching
- Giám sát thường xuyên
- Cân bằng tải truy cập và tài nguyên hệ thống

---

## 1. Cấu hình PostgreSQL tối ưu

**Tập tin cần chỉnh: `postgresql.conf`**

### Các thông số quan trọng:

- `shared_buffers`: ~25-40% RAM
- `work_mem`: 4MB–64MB tùy khối lượng truy vấn
- `maintenance_work_mem`: 64MB–1GB (cho VACUUM/CREATE INDEX)
- `effective_cache_size`: 60–80% RAM (ước lượng cache OS)
- `wal_buffers`: 16MB hoặc `-1` để tự động
- `checkpoint_completion_target`: 0.7–0.9
- `max_connections`: Giới hạn kết nối để tránh RAM cạn
- `random_page_cost`: Giảm xuống 1.0 nếu SSD

---

## 2. Tối ưu hóa truy vấn SQL

- Sử dụng `EXPLAIN (ANALYZE, BUFFERS)` để hiểu chi phí truy vấn
- Tránh SELECT * – chỉ chọn cột cần thiết
- Dùng `LIMIT`, `OFFSET` hiệu quả
- Tránh `OR`, thay bằng `UNION ALL` khi hợp lý
- Dùng CTE (`WITH`) cẩn thận – có thể gây vật liệu hóa không mong muốn
- Đảm bảo JOIN có chỉ mục phù hợp
- Tránh truy vấn con không tương quan lồng sâu

---

## 3. Tối ưu hóa chỉ mục (Index)

- **Loại chỉ mục phổ biến:**
  - `btree`: mặc định
  - `hash`: cho phép so sánh bằng `=`
  - `GIN`, `GiST`: tìm kiếm full-text, array
  - `BRIN`: dữ liệu rất lớn, dạng tuần tự

- **Chiến lược:**
  - Tạo chỉ mục trên cột WHERE, JOIN, ORDER BY
  - Dùng `partial index` nếu truy vấn có điều kiện cụ thể
  - Tránh tạo chỉ mục dư thừa (tốn RAM và thời gian cập nhật)
  - Dùng `covering index` nếu chỉ đọc vài cột

---

## 4. Quản lý autovacuum và phân mảnh

- PostgreSQL không xóa bản ghi ngay – dùng VACUUM
- Cấu hình `autovacuum` hợp lý:
  - `autovacuum_vacuum_cost_limit`
  - `autovacuum_naptime`
  - `autovacuum_vacuum_threshold`

- Dùng `pg_stat_user_tables` để theo dõi dead tuples
- Dùng `VACUUM (VERBOSE)` hoặc `VACUUM FULL` (blocking)

---

## 5. Giám sát và đo hiệu năng

### Công cụ tích hợp:

- `pg_stat_statements`: thống kê truy vấn chậm
- `pg_stat_activity`: xem truy vấn đang chạy
- `pg_stat_bgwriter`: hiệu năng ghi WAL

### Giải pháp APM:

- [pgBadger](https://github.com/dalibo/pgbadger) – phân tích log
- [Prometheus + Grafana](https://github.com/prometheus-community/postgres_exporter)
- [pganalyze](https://pganalyze.com/)

---

## 6. Caching và Connection Pooling

### Caching:

- Ứng dụng: Redis, Memcached
- Materialized views nếu dữ liệu không thay đổi liên tục

### Connection Pooling:

- **PgBouncer** – nhẹ, phổ biến
- **Pgpool-II** – hỗ trợ load balancing, failover

---

## 7. Chiến lược mở rộng quy mô

- **Vertical scaling**: nâng RAM/CPU
- **Read replicas**: nhân bản để đọc
- **Partitioning (Table Sharding)**:
  - Range, List, Hash partition
- Logical replication: tách workload theo dịch vụ

---

## 8. Công cụ hỗ trợ tối ưu hóa

- `EXPLAIN`, `ANALYZE` – phân tích truy vấn
- `auto_explain` – ghi truy vấn chậm tự động
- `pg_hint_plan` – thêm gợi ý cho planner
- `pg_repack` – chống phân mảnh mà không lock
- `hypopg` – giả lập chỉ mục để test hiệu năng

---

## Tài nguyên tham khảo

- [PostgreSQL Performance Tuning Documentation](https://www.postgresql.org/docs/current/performance-tips.html)
- [Use The Index, Luke](https://use-the-index-luke.com/)
- [PGTune – Online Config Generator](https://pgtune.leopard.in.ua/)
- [Postgres Wiki - Performance](https://wiki.postgresql.org/wiki/Performance_Optimization)
- [pg_stat_statements Documentation](https://www.postgresql.org/docs/current/pgstatstatements.html)

---

✅ **Khuyến nghị**: Kiểm thử từng thay đổi trên môi trường staging trước khi áp dụng vào production để đảm bảo an toàn và hiệu quả.

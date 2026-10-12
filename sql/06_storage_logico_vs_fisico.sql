-- 06 · ¿Conviene facturar storage físico (comprimido) en vez de lógico?
-- Precios mensuales por GiB: VERIFICAR los vigentes de tu región antes de decidir.
DECLARE p_log_activo FLOAT64 DEFAULT 0.02;
DECLARE p_log_largo  FLOAT64 DEFAULT 0.01;
DECLARE p_fis_activo FLOAT64 DEFAULT 0.04;
DECLARE p_fis_largo  FLOAT64 DEFAULT 0.02;

SELECT
  table_schema AS dataset,
  ROUND(SUM(active_logical_bytes)    / POW(1024,3) * p_log_activo
      + SUM(long_term_logical_bytes) / POW(1024,3) * p_log_largo, 2)  AS usd_mes_logico,
  ROUND(SUM(active_physical_bytes - IFNULL(time_travel_physical_bytes,0)) / POW(1024,3) * p_fis_activo
      + SUM(long_term_physical_bytes) / POW(1024,3) * p_fis_largo
      + SUM(IFNULL(time_travel_physical_bytes,0)) / POW(1024,3) * p_fis_activo, 2) AS usd_mes_fisico
FROM `region-us`.INFORMATION_SCHEMA.TABLE_STORAGE
GROUP BY dataset
ORDER BY usd_mes_logico DESC;

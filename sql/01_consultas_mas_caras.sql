-- 01 · Top consultas por costo (últimos N días)
-- Parámetros: región del proyecto y precio on-demand por TiB (verificar precio vigente de tu región).
DECLARE dias INT64 DEFAULT 30;
DECLARE usd_por_tib FLOAT64 DEFAULT 6.25;

SELECT
  job_id,
  user_email,
  creation_time,
  ROUND(total_bytes_billed / POW(1024, 4), 4)              AS tib_facturados,
  ROUND(total_bytes_billed / POW(1024, 4) * usd_por_tib, 2) AS usd_estimado,
  ROUND(total_slot_ms / 1000 / 3600, 2)                     AS slot_horas,
  cache_hit,
  LEFT(query, 300)                                          AS query_preview
FROM `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL dias DAY)
  AND job_type = 'QUERY'
  AND state = 'DONE'
  AND error_result IS NULL
ORDER BY total_bytes_billed DESC
LIMIT 50;

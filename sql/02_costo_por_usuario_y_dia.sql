-- 02 · Costo diario por usuario / service account
DECLARE dias INT64 DEFAULT 30;
DECLARE usd_por_tib FLOAT64 DEFAULT 6.25;

SELECT
  DATE(creation_time)                                            AS dia,
  user_email,
  COUNT(*)                                                       AS consultas,
  ROUND(SUM(total_bytes_billed) / POW(1024, 4) * usd_por_tib, 2) AS usd_estimado
FROM `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL dias DAY)
  AND job_type = 'QUERY'
GROUP BY dia, user_email
ORDER BY dia DESC, usd_estimado DESC;

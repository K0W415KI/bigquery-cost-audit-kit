-- 04 · Consultas con SELECT * que escanean mucho (antipatrón clásico)
DECLARE dias INT64 DEFAULT 30;
DECLARE usd_por_tib FLOAT64 DEFAULT 6.25;

SELECT
  user_email,
  COUNT(*)                                                       AS ejecuciones,
  ROUND(SUM(total_bytes_billed) / POW(1024, 4) * usd_por_tib, 2) AS usd_estimado,
  ANY_VALUE(LEFT(query, 300))                                    AS ejemplo
FROM `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL dias DAY)
  AND job_type = 'QUERY'
  AND REGEXP_CONTAINS(UPPER(query), r'SELECT\s+\*')
GROUP BY user_email
ORDER BY usd_estimado DESC;

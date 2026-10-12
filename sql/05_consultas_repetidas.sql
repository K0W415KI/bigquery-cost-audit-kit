-- 05 · Consultas repetidas (misma forma, distintos literales): candidatas a
-- vista materializada, tabla agregada o caché.
DECLARE dias INT64 DEFAULT 30;
DECLARE usd_por_tib FLOAT64 DEFAULT 6.25;

SELECT
  query_info.query_hashes.normalized_literals                    AS hash_consulta,
  COUNT(*)                                                       AS ejecuciones,
  ROUND(SUM(total_bytes_billed) / POW(1024, 4) * usd_por_tib, 2) AS usd_estimado,
  ANY_VALUE(LEFT(query, 300))                                    AS ejemplo
FROM `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL dias DAY)
  AND job_type = 'QUERY'
  AND query_info.query_hashes.normalized_literals IS NOT NULL
GROUP BY hash_consulta
HAVING ejecuciones > 10
ORDER BY usd_estimado DESC
LIMIT 50;

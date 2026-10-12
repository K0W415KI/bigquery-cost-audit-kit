-- 03 · Tablas grandes sin particionado ni clustering (candidatas a rediseño)
DECLARE min_gib FLOAT64 DEFAULT 10;

WITH diseno AS (
  SELECT
    table_schema,
    table_name,
    LOGICAL_OR(is_partitioning_column = 'YES')        AS particionada,
    LOGICAL_OR(clustering_ordinal_position IS NOT NULL) AS clusterizada
  FROM `region-us`.INFORMATION_SCHEMA.COLUMNS
  GROUP BY table_schema, table_name
)
SELECT
  s.table_schema,
  s.table_name,
  ROUND(s.total_logical_bytes / POW(1024, 3), 1) AS gib_logicos,
  d.particionada,
  d.clusterizada
FROM `region-us`.INFORMATION_SCHEMA.TABLE_STORAGE s
JOIN diseno d USING (table_schema, table_name)
WHERE s.total_logical_bytes / POW(1024, 3) >= min_gib
  AND (NOT d.particionada OR NOT d.clusterizada)
ORDER BY s.total_logical_bytes DESC;

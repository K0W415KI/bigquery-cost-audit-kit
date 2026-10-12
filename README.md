# BigQuery Cost Audit Kit

Kit de consultas SQL para encontrar **dónde se va la plata en BigQuery** en menos de 30 minutos. Usa solo `INFORMATION_SCHEMA`, así que no hace falta instalar nada, no se mueven datos fuera del proyecto y alcanza con permisos de lectura de metadatos.

Autor: Jonatan, Senior Data Engineer (más de 15 años en ETL y banca).

## Qué responde

| # | Script | Pregunta |
|---|--------|----------|
| 01 | `consultas_mas_caras` | ¿Qué 50 consultas costaron más en los últimos 30 días? |
| 02 | `costo_por_usuario_y_dia` | ¿Qué usuario o service account gasta más, y cuándo? |
| 03 | `tablas_sin_particion_ni_cluster` | ¿Qué tablas grandes están mal diseñadas para el costo? |
| 04 | `select_estrella_costosos` | ¿Quién hace `SELECT *` sobre tablas grandes? |
| 05 | `consultas_repetidas` | ¿Qué consultas se repiten y convendría materializar? |
| 06 | `storage_logico_vs_fisico` | ¿Conviene cambiar el modelo de facturación del storage? |

## Uso

1. Reemplazá `region-us` por la región de tu proyecto (por ejemplo, `region-southamerica-east1`).
2. Ajustá `usd_por_tib` y los precios de storage a los vigentes en tu región.
3. Ejecutá cada script en la consola de BigQuery.

Permisos mínimos: `roles/bigquery.resourceViewer` y `roles/bigquery.metadataViewer`.

> **Versión 0.1.** Si algún script falla en tu región o edición, abrí un *issue* y lo corrijo.

> Los montos en USD son **estimaciones** basadas en precios on-demand. Si usás reservas de slots (Editions), mirá la columna `slot_horas`.

## Servicio de auditoría

¿Querés que lo analice yo y te entregue un informe con un plan de ahorro priorizado? Escribime por LinkedIn.

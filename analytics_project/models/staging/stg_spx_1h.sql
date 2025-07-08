SELECT
  (CAST(time AS TIMESTAMP) AT TIME ZONE 'UTC') AT TIME ZONE 'Australia/Sydney' AS nsw_time,
  CAST(open AS DOUBLE) AS open,
  CAST(close AS DOUBLE) AS close,
  CAST(high AS DOUBLE) AS high,
  CAST(low AS DOUBLE) AS low
FROM {{ source('market_data', 'SPX_1h') }}
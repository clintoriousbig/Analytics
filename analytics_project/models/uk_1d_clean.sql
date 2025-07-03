SELECT
  CAST(time AS TIMESTAMP) AS time,
  CAST(open AS DOUBLE) AS open,
  CAST(close AS DOUBLE) AS close,
  CAST(high AS DOUBLE) AS high,
  CAST(low AS DOUBLE) AS low,
  CAST(volume AS DOUBLE) AS volume
FROM {{ source('market_data', 'UK_1d') }}
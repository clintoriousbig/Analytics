SELECT
  time,
  CAST(time AT TIME ZONE 'UTC' AT TIME ZONE 'Australia/Sydney' AS DATE) AS syd_date,
  CAST(open AS DOUBLE) AS open,
  CAST(close AS DOUBLE) AS close,
  CAST(high AS DOUBLE) AS high,
  CAST(low AS DOUBLE) AS low
FROM {{ source('market_data', 'AUS_1d') }}

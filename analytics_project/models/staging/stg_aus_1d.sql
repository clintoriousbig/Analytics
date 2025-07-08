WITH src AS (
  SELECT *,
    EXTRACT(year FROM time) AS year,

    -- Calculate second Sunday in March (US DST start)
    DATE_TRUNC('year', time) + INTERVAL '2 months' + 
    ((7 - EXTRACT(dow FROM DATE_TRUNC('year', time) + INTERVAL '2 months')) % 7) * INTERVAL '1 day' + 
    INTERVAL '7 days' AS us_dst_start,

    -- Calculate first Sunday in November (US DST end)
    DATE_TRUNC('year', time) + INTERVAL '10 months' + 
    ((7 - EXTRACT(dow FROM DATE_TRUNC('year', time) + INTERVAL '10 months')) % 7) * INTERVAL '1 day' AS us_dst_end

  FROM {{ source('market_data', 'AUS_1d') }}
)

SELECT
  CASE
    WHEN time BETWEEN us_dst_start AND us_dst_end THEN time + INTERVAL '12 hours'
    ELSE time + INTERVAL '11 hours'
  END AS nsw_time,

  CAST(open AS DOUBLE) AS open,
  CAST(close AS DOUBLE) AS close,
  CAST(high AS DOUBLE) AS high,
  CAST(low AS DOUBLE) AS low
FROM src

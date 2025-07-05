WITH aus AS (
  SELECT * FROM {{ ref('stg_aus_1d') }}
),
spx AS (
  SELECT time AS spx_time, close AS spx_close
  FROM {{ ref('spx_1d_clean') }}
),
joined AS (
  SELECT
    aus.*,
    spx.spx_close,
    LAG(spx.spx_close) OVER (ORDER BY spx_time) AS spx_prev_close
  FROM aus
  LEFT JOIN spx
    ON DATE(aus.time) = DATE(spx.spx_time)
),
filtered AS (
  SELECT *,
    ROUND((spx_close - spx_prev_close) / spx_prev_close, 4) AS spx_return
  FROM joined
  WHERE strftime('%w', time) IN ('1', '2', '3', '4', '5')  -- weekdays
)

SELECT *
FROM filtered
ORDER BY time DESC

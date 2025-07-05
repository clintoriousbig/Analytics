WITH aus AS (
  SELECT * FROM {{ ref('rpt_aus_spx_move') }}
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
    AND spx_prev_close IS NOT NULL
    AND spx_return > 0.01  -- SPX up > 1%
)

SELECT *
FROM filtered
ORDER BY time DESC

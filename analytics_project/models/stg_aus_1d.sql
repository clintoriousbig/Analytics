WITH base AS (
  SELECT
    *,
    LAG(close) OVER (ORDER BY time) AS prev_close,
    LAG(high) OVER (ORDER BY time) AS prev_high,
    LAG(low) OVER (ORDER BY time) AS prev_low
  FROM {{ ref('aus_1d_clean') }}
),

true_range AS (
  SELECT
    *,
    ROUND(GREATEST(
      high - low,
      ABS(high - prev_close),
      ABS(low - prev_close), 1)
    ) AS true_range
  FROM base
),

atr_calc AS (
  SELECT
    *,
    ROUND(AVG(true_range) OVER (
      ORDER BY time
      ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
    ), 1) AS atr_14
  FROM true_range
)

SELECT *,
  ROUND((close - prev_close) / prev_close, 4) AS daily_return,
  CASE
    WHEN atr_14 < 70 THEN 'low'
    WHEN atr_14 < 80 THEN 'medium'
    ELSE 'high'
  END AS volatility_class
FROM atr_calc
WHERE prev_close IS NOT NULL
ORDER BY time DESC

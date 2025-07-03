SELECT *
FROM {{ ref('aus_1d_clean') }}
ORDER BY time DESC
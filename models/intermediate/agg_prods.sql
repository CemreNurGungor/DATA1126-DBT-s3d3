SELECT
  s.products_id,
  COUNT(DISTINCT s.orders_id)                                      AS order_count,
  SUM(s.qty)                                                       AS total_qty,
  SUM(s.turnover)                                                  AS total_turnover,
  SUM(s.qty * CAST(p.purchase_price AS FLOAT64))                   AS total_purchase_cost,
  SUM(s.turnover) - SUM(s.qty * CAST(p.purchase_price AS FLOAT64)) AS total_margin,
  SAFE_DIVIDE(
    SUM(s.turnover) - SUM(s.qty * CAST(p.purchase_price AS FLOAT64)),
    SUM(s.turnover)
  )                                                                AS margin_pct
FROM `dbt-bq-cemre-2611.course16.gwz_sales` AS s
LEFT JOIN `dbt-bq-cemre-2611.course16.gwz_product` AS p
  ON s.products_id = p.products_id
GROUP BY s.products_id
SELECT t_ext.transaction_id, t_ext.account_id, t_ext.amount,
       (SELECT ROUND(AVG(t_int.amount), 2)
        FROM core.transactions t_int
        WHERE t_int.account_id = t_ext.account_id) AS account_average
FROM core.transactions t_ext
WHERE t_ext.amount > (
  SELECT AVG(t_int.amount)
  FROM core.transactions t_int
  WHERE t_int.account_id = t_ext.account_id
)
ORDER BY t_ext.amount DESC;


SELECT account_id, ROUND(AVG(amount), 2) AS account_average
FROM core.transactions 
GROUP BY account_id 
ORDER BY account_id;
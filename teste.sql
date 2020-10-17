USE MePoupe;
#
DELETE FROM
  Registro_Saque;
#
DELETE FROM
  Registro_Deposito;
#
INSERT INTO
  Registro_Deposito (
    cod_deposito,
    cod_conta,
    dt_deposito,
    valor_deposito
  )
VALUES
  (1, 1, "2019-09-14", 500),
  (2, 1, "2019-09-16", 100);
#
INSERT INTO
  Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES
  (1, 1, "2019-09-20", 200),
  (2, 1, "2019-09-21", 200);
#
INSERT INTO
  Registro_Deposito (
    cod_deposito,
    cod_conta,
    dt_deposito,
    valor_deposito
  )
VALUES
  (3, 2, "2020-08-24", 1000),
  (4, 2, "2020-08-24", 99999);
#
INSERT INTO
  Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES
  (3, 2, "2020-09-22", 50);
#
SELECT
  c.nome,
  c.CPF,
  cc.cod_conta
FROM
  conta_corrente cc
  LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
  LEFT JOIN Registro_Deposito rd ON cc.cod_conta = rd.cod_conta
  LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
GROUP BY
  c.nome,
  c.CPF,
  cc.cod_conta
HAVING(sum(rd.valor_deposito) - sum(rs.valor_saque)) > 100000;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managers;

import apoio.ConexaoBD;
import entidade.Vendas;
import groovy.json.JsonBuilder;
import java.sql.*;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author STI
 */
public class ChartManager {

    public static List<Vendas> getVendasDoDia(String data) {
        Connection conn = ConexaoBD.getInstance().getConnection();
        System.out.printf("Obtendo vendas para a data %s\n", data);
        String sql
                = "SELECT \n"
                + "  categoria.descricao AS categoria, \n"
                + "  SUM(item.quant) AS quantidade\n"
                + "FROM \n"
                + "  categoria, \n"
                + "  compra, \n"
                + "  itencarrinho AS item, \n"
                + "  carrinho, \n"
                + "  produto\n"
                + "WHERE compra.created_at = '" + data + "' \n"
                + "  AND categoria.id = produto.id_categoria \n"
                + "  AND produto.id = item.id_produto\n"
                + "  AND carrinho.id_compra = compra.id \n"
                + "  AND carrinho.id_iten = item.id \n"
                + "GROUP BY categoria.id\n"
                + "HAVING SUM(item.quant) > 0;";

        ArrayList<Vendas> vendas = new ArrayList<>();

        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);

            while (rs.next()) {
                Vendas venda = new Vendas();

                venda.categoria = rs.getString("categoria");
                venda.quantidade = rs.getLong("quantidade");
                vendas.add(venda);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ChartManager.class.getName()).log(Level.SEVERE, null, ex);
        }

        return vendas;
    }

    public static List<List<Vendas>> getVendasSemana() {

        LocalDate data = LocalDate.now();

        ArrayList<List<Vendas>> vendasDaSemana = new ArrayList<>();

        for (int offset = 0; offset < 7; offset++) {
            vendasDaSemana.add(getVendasDoDia(data.minusDays(offset).toString()));
        }

        return vendasDaSemana;
    }

    /**
     *
     * @return
     */
    public static String jsonVendasSemana() {
        return new JsonBuilder(getVendasSemana()).toString();
    }

}

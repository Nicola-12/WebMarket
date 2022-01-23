/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managers;

import apoio.Database;
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

    public static long getVendasDoDia(String data) {
        Connection conn = Database.getInstance().getConnection();
        System.out.printf("Obtendo vendas para a data %s\n", data);
        String sql
                = "SELECT \n"
                + "  SUM(item.quant * item.total) AS quantidade\n"
                + "FROM \n"
                + "  compra, \n"
                + "  itencarrinho AS item, \n"
                + "  carrinho \n"
                + "WHERE compra.created_at = '" + data + "' \n"
                + "  AND carrinho.id_compra = compra.id \n"
                + "  AND carrinho.id_iten = item.id \n"
                + "HAVING SUM(item.quant) > 0;";

        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);

            if (rs.next()) {
                return rs.getLong("quantidade");
                
            }

        } catch (SQLException ex) {
            Logger.getLogger(ChartManager.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public static List<Long> getVendasSemana() {

        LocalDate data = LocalDate.now();

        ArrayList<Long> vendasDaSemana = new ArrayList<>();

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

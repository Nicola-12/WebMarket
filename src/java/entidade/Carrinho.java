/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidade;

import java.sql.*;

/**
 *
 * @author Usuario
 */
public class Carrinho {

    public int id_compra;
    public int id_iten;

    public static Carrinho from(ResultSet resultSet) throws SQLException {
        Carrinho carrinho = new Carrinho();

        carrinho.id_compra = resultSet.getInt("id_compra");
        carrinho.id_iten = resultSet.getInt("id_iten");

        return carrinho;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("carrinho={id_compra=").append(id_compra);
        sb.append("', id_iten='").append(id_iten);
        sb.append('}');
        return sb.toString();
    }

}

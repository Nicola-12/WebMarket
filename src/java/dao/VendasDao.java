/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Vendas;
import java.util.ArrayList;
import java.sql.*;

/**
 *
 * @author Usuario
 */
public class VendasDao implements IDAO<Vendas> {

    ResultSet result;

    @Override
    public String salvar(Vendas o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO vendas"
                    + "default,"
                    + "'" + o.valor + "',"
                    + "'" + o.parcelas + "',"
                    + "'" + o.id_pessoa + "',"
                    + "'" + o.id_carrinho + "'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("ERRO AO SALVAR VENDAS" + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Vendas o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String excluir(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Vendas> consultarTodos() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean registroUnico(Vendas o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Vendas> consultar(String criterio) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object consultarId(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean consultar(Vendas o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

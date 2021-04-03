/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Carrinho;
import java.util.ArrayList;
import java.sql.*;

/**
 *
 * @author Usuario
 */
public class CarrinhoDao implements IDAO<Carrinho> {

    ResultSet result;

    @Override
    public String salvar(Carrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO carrinho "
                    + "default,"
                    + "'" + o.quant + "',"
                    + "'" + o.precoTotal + "',"
                    + "'" + o.id_produto + "',"
                    + "'now()'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("ERRO AO SALVAR CARRINHO: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Carrinho o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String excluir(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> consultarTodos() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean registroUnico(Carrinho o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> consultar(String criterio) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object consultarId(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean consultar(Carrinho o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

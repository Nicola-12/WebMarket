package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.ItemCarrinho;
import java.util.ArrayList;
import java.sql.*;

public class ItemCarrinhoDao implements IDAO<ItemCarrinho> {

    ResultSet result;

    @Override
    public String salvar(ItemCarrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO itencarrinho "
                    + "default,"
                    + "'" + o.quant + "',"
                    + "'" + o.total + "',"
                    + "'" + o.id_produto + "',"
                    + "'" + o.created_at + "',"
                    + "'now()'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar o carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(ItemCarrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE itencarrinho SET "
                    + "quant='" + o.quant + "',"
                    + "precoTotal='" + o.total + "',"
                    + "id_produto='" + o.id_produto + "',"
                    + "created_at= now() "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> consultarTodos() {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean registroUnico(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> consultar(String criterio) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ItemCarrinho consultarId(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean consultar(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

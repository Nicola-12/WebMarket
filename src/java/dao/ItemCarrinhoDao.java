package dao;

import apoio.Database;
import apoio.IDAO;
import entidade.ItemCarrinho;
import java.util.ArrayList;
import java.sql.*;

public class ItemCarrinhoDao implements IDAO<ItemCarrinho> {

    ResultSet result;

    @Override
    public String save(ItemCarrinho o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO itencarrinho values "
                    + "(default,"
                    + "" + o.quant + ","
                    + "" + o.valorU + ","
                    + "" + o.id_produto + ","
                    + "now()) RETURNING id";

            System.out.println("SQL: " + sql);

            ResultSet rs = stm.executeQuery(sql);
            rs.next();
            o.id = rs.getInt(1);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar o carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String update(ItemCarrinho o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "UPDATE itencarrinho SET "
                    + "quant='" + o.quant + "',"
                    + "precoTotal='" + o.valorU + "',"
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
    public String remove(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> findAll() {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isUnique(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> getAllByValue(String criterio) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ItemCarrinho getById(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean exists(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import apoio.Database;
import apoio.IDAO;
import entidade.Carrinho;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author ne
 */
public class CarrinhoDao implements IDAO<Carrinho> {

    @Override
    public String save(Carrinho o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO carrinho values ("
                    + "" + o.id_compra + ","
                    + "" + o.id_iten + ")";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar o carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String update(Carrinho o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "UPDATE carrinho SET "
                    + "id_compra='" + o.id_compra + "',"
                    + "id_iten='" + o.id_iten + "',"
                    + "WHERE id_compra= " + o.id_compra;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String remove(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isUnique(Carrinho o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> getAllByValue(String criterio) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Carrinho getById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean exists(Carrinho o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

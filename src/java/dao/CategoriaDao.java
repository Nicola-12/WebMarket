/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Categoria;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Usuario
 */
public class CategoriaDao implements IDAO<Categoria> {

    ResultSet result;

    @Override
    public String salvar(Categoria categoria) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO categoria VALUES"
                    + "default,"
                    + "'" + categoria.getDescricao() + "',"
                    + "' now()',"
                    + "' null '";

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("ERRO AO SALVAR CATEGORIA: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Categoria categoria) {
        String saida = null;

        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE TABLE categoria"
                    + "SET descricao = '" + categoria.getDescricao() + "'"
                    + "WHERE id = '" + categoria.getId() + "'";

            int retorno = stm.executeUpdate(sql);

            if (retorno != 0) {
                saida = null;
            } else {
                saida = "ERRO";
            }
        } catch (Exception e) {
            System.out.println("ERRO AO SALVAR A CATEGORIA: " + e);
            saida = e.toString();
        }

        return saida;
    }

    @Override
    public String excluir(int id) {
        try {

            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = " DELETE FROM TABLE categoria"
                    + "WHERE id = '" + id + "'";

            int retorno = stm.executeUpdate(sql);

            return sql;

        } catch (Exception e) {
            return e.toString();

        }
    }

    @Override
    public ArrayList<Categoria> consultarTodos() {
        ArrayList<Categoria> categorias = new ArrayList();

        try {
            Statement st = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "select * "
                    + "from "
                    + "categoria ";

            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                Categoria c = new Categoria();

                c.setId(resultado.getInt("id"));
                c.setDescricao(resultado.getString("descricao"));

                categorias.add(c);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar Categorias: " + e);
        }

        return categorias;
    }

    @Override
    public boolean registroUnico(Categoria o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Categoria> consultar(String criterio) {
        ArrayList<Categoria> categorias = new ArrayList();

        try {
            Statement st = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "select * "
                    + "from "
                    + "categoria "
                    + "where "
                    + "descricao ilike '%" + criterio + "%' "
                    + "order by descricao";

            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                Categoria c = new Categoria();

                c.setId(resultado.getInt("id"));
                c.setDescricao(resultado.getString("descricao"));

                categorias.add(c);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar Categorias: " + e);
        }

        return categorias;
    }

    @Override
    public Object consultarId(int id) {
        Categoria c = null;

        try {
            Statement st = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "select * "
                    + "from "
                    + "categoria "
                    + "where "
                    + "id = " + id;

            ResultSet resultado = st.executeQuery(sql);

            while (resultado.next()) {
                c = new Categoria();

                c.setId(resultado.getInt("id"));
                c.setDescricao(resultado.getString("descricao"));

            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar Categoria por ID: " + e);
        }

        return c;
    }

    @Override
    public boolean consultar(Categoria o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

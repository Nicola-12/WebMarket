package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Produto;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

public class ProdutoDao implements IDAO<Produto> {

    ResultSet result;

    @Override
    public String salvar(Produto o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO produto VALUES "
                    + "(default,"
                    + "'" + o.descricao + "',"
                    + "'" + o.nome + "',"
                    + "'" + o.valor + "',"
                    + "'" + o.estoque + "',"
                    + "'" + o.id_categoria + "',"
                    + "'" + o.ativo + "',"
                    + " now(),"
                    + " now(),"
                    + "'" + o.file + "'"
                    + ")";

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar produto: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Produto o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE produto SET "
                    + "descricao='" + o.descricao + "',"
                    + "nome ='" + o.nome + "', "
                    + "valor='" + o.valor + "',"
                    + "quantidade='" + o.estoque + "',"
                    + "id_categoria='" + o.id_categoria + "',"
                    + "ativo='" + o.ativo + "', "
                    + "updated_at= now() "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar produto: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE produto SET ativo = false WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir produto: " + e);
            return e.toString();
        }
    }

    public ArrayList<Produto> consultarTodos() {
        String sql = "SELECT * FROM produto";
        try {
            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Produto> produto = new ArrayList<>();
            while (result.next()) {
                produto.add(Produto.from(result));
            }
            if (produto.isEmpty()) {
                return null;
            }
            return produto;
        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Produto o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Produto> consultar(String criterio) {
        return consultarProdAndCateg(criterio, null);
    }

    public ArrayList<Produto> consultarProdAndCateg(String pesquisa, String id_categoria) {
        String sql = "SELECT * "
                + "FROM produto p "
                + "WHERE p.nome ILIKE '%" + pesquisa + "%' ";

        if (id_categoria != null && id_categoria.matches("^\\d+$")) {
            sql += " AND p.id_categoria =" + id_categoria;
        }
        ArrayList<Produto> produto = new ArrayList<>();

        try {
            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            while (result.next()) {
                produto.add(Produto.from(result));
            }
            return produto;
        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos com categorias: " + e);
        }
        return produto;
    }

    @Override
    public Produto consultarId(int id) {
        String sql = "SELECT * FROM produto WHERE id=" + id;
        try {
            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Produto.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Produto o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

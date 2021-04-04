package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Pessoa;
import java.util.ArrayList;
import java.sql.*;

public class PessoaDao implements IDAO<Pessoa> {

    ResultSet result;

    @Override
    public String salvar(Pessoa o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO pessoa values"
                    + "(default,"
                    + "'" + o.nome + "',"
                    + "'" + o.senha + "',"
                    + "'" + o.email + "',"
                    + "'" + o.endereco + "',"
                    + "'" + o.telefone + "',"
                    + "'" + o.ativo + "',"
                    + "'now()',"
                    + "'now()')";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("ERRO AO SALVAR PESSOA: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Pessoa o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE pessoa SET "
                    + "descricao=" + o.nome + ","
                    + "valor=" + o.senha + ","
                    + "quantidade=" + o.email + ","
                    + "unidade=" + o.endereco + ","
                    + "id_categoria=" + o.telefone + ","
                    + "ativo=" + o.ativo + ","
                    + "'now()' "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar pessoa: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE pessoa SET ativo = false WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir pessoa: " + e);
            return e.toString();
        }
    }

    @Override
    public ArrayList<Pessoa> consultarTodos() {
        String sql = "SELECT * FROM pessoa WHERE status <> false";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Pessoa> pessoa = new ArrayList<>();
            while (result.next()) {
                pessoa.add(Pessoa.from(result));
            }
            if (pessoa.isEmpty()) {
                return null;
            }
            return pessoa;
        } catch (Exception e) {
            System.out.println("Erro ao consultar pessoas: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Pessoa o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Pessoa> consultar(String criterio) {
        String sql = "SELECT * FROM pessoa WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Pessoa> pessoa = new ArrayList<>();
            while (result.next()) {
                pessoa.add(Pessoa.from(result));
            }
            if (pessoa.isEmpty()) {
                return null;
            }
            return pessoa;
        } catch (Exception e) {
            System.out.println("Erro ao consultar pessoas: " + e);
        }
        return null;
    }

    @Override
    public Object consultarId(int id) {
        String sql = "SELECT * FROM pessoa WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Pessoa.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar pessoas por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Pessoa o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Pessoa;
import java.util.ArrayList;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

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
                    + "'ativo',"
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
                    + "nome='" + o.nome + "',"
                    + "senha='" + o.senha + "',"
                    + "email='" + o.email + "',"
                    + "endereco='" + o.endereco + "',"
                    + "telefone='" + o.telefone + "',"
                    + "ativo='" + o.ativo + "',"
                    + "updated_at = now() "
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

            String sql = "UPDATE pessoa SET ativo = inativo WHERE id=" + id;
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
    public Pessoa consultarId(int id) {
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

    public Pessoa consultarEmail(String email) {
        String sql = "SELECT * FROM pessoa WHERE email ='" + email + "'";
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

    public byte[] gerarRelatorio(String ativo) {
        try {
            Connection conn = ConexaoBD.getInstance().getConnection();

            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/ListagemUsuarios.jrxml"));

            Map parameters = new HashMap();
            parameters.put("ativo", ativo);
      
            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (Exception e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }

}

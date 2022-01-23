package dao;

import apoio.Database;
import apoio.IDAO;
import entidade.Compra;
import java.util.ArrayList;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

public class CompraDao implements IDAO<Compra> {

    ResultSet result;

    @Override
    public String save(Compra o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO compra values "
                    + "(default,"
                    + "" + o.valorTotal + ","
                    + "" + o.parcelas + ","
                    + "" + o.id_pessoa + ","
                    + " now()) "
                    + "RETURNING id";

            System.out.println("SQL: " + sql);
            ResultSet rs = stm.executeQuery(sql);
            rs.next();
            o.id = rs.getInt(1);
            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar compra" + e);
            return e.toString();
        }
    }

    @Override
    public String update(Compra o) {
        try {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "UPDATE compra SET "
                    + "valorTotal='" + o.valorTotal + "',"
                    + "parcelas='" + o.parcelas + "',"
                    + "id_pessoa='" + o.id_pessoa + "' "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar compra: " + e);
            return e.toString();
        }
    }

    @Override
    public String remove(int id) { //não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Compra> findAll() {
        String sql = "SELECT * FROM compra ";
        try {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Compra> compra = new ArrayList<>();
            while (result.next()) {
                compra.add(Compra.from(result));
            }
            if (compra.isEmpty()) {
                return null;
            }
            return compra;
        } catch (Exception e) {
            System.out.println("Erro ao consultar compras: " + e);
        }
        return null;
    }

    @Override
    public boolean isUnique(Compra o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Compra> getAllByValue(String criterio) {
        String sql = "SELECT * FROM compra WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Compra> compra = new ArrayList<>();
            while (result.next()) {
                compra.add(Compra.from(result));
            }
            if (compra.isEmpty()) {
                return null;
            }
            return compra;
        } catch (Exception e) {
            System.out.println("Erro ao consultar compras: " + e);
        }
        return null;
    }

    @Override
    public Compra getById(int id) {
        String sql = "SELECT * FROM compra WHERE id=" + id;
        try {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Compra.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar compra por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean exists(Compra o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public byte[] gerarRelatorioData(Date data1, Date data2) {
        try {
            Connection conn = Database.getInstance().getConnection();

            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/rvenda.jrxml"));
            Map parameters = new HashMap();
            parameters.put("dataIni", data1);
            parameters.put("dataFin", data2);
            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (JRException e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }

}

package entidade;

import java.sql.*;

public class Compra {

    public Integer id;
    public double valorTotal;
    public Integer parcelas;
    public Integer id_pessoa;
    public Date created_at;

    public static Compra from(ResultSet resultSet) throws SQLException {
        Compra c = new Compra();

        c.id = (resultSet.getInt("id"));
        c.valorTotal = (resultSet.getDouble("valorTotal"));
        c.parcelas = (resultSet.getInt("parcelas"));
        c.id_pessoa = (resultSet.getInt("id_pessoa"));
        c.created_at = (resultSet.getDate("created_at"));

        return c;
    }

    public String toStrig() {
        StringBuilder sb = new StringBuilder();

        sb.append("compra{id=").append(id);
        sb.append("', valorTotal='").append(valorTotal);
        sb.append("', parcelas='").append(parcelas);
        sb.append("', id_pessoa='").append(id_pessoa);
        sb.append("', created_at='").append(created_at);
        sb.append('}');

        return sb.toString();
    }

}

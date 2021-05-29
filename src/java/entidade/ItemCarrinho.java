package entidade;

import java.io.Serializable;
import java.sql.*;

public class ItemCarrinho implements Serializable {

    public Integer id;
    public int quant;
    public double valorU;
    public Integer id_produto;
    public Date created_at;

    public static ItemCarrinho from(ResultSet resultSet) throws SQLException {
        ItemCarrinho car = new ItemCarrinho();

        car.id = resultSet.getInt("id");
        car.quant = resultSet.getInt("quant");
        car.valorU = resultSet.getDouble("total");
        car.id_produto = resultSet.getInt("id_produto");
        car.created_at = resultSet.getDate("created_at");
        return car;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("itencarrinho{id=").append(id);
        sb.append("', quant='").append(quant);
        sb.append("', total='").append(valorU);
        sb.append("', id_produto='").append(id_produto);
        sb.append("', created_at='").append(created_at);
        sb.append('}');

        return sb.toString();
    }
}

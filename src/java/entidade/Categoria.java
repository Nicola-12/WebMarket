/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidade;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author Usuario
 */
public class Categoria {

    public Integer id;
    public String descricao; //nome
    public Date criado_em;
    public Date atualizado_em;
    public boolean ativo; //ativo (visível) ou inativo (invisível)
    
    public static Categoria from(ResultSet resultSet) throws SQLException {
        Categoria cat = new Categoria();

        cat.id = resultSet.getInt("id");
        cat.descricao = resultSet.getString("descricao");
        cat.criado_em = resultSet.getDate("criado_em");
        cat.atualizado_em = resultSet.getDate("atualizado_em");
        cat.ativo = resultSet.getBoolean("ativo");

        return cat;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("categoria{id=").append(id);
        sb.append("', descricao='").append(descricao);
        sb.append("', criado_em='").append(criado_em);
        sb.append("', atualizado_em='").append(atualizado_em);
        sb.append("', ativo='").append(ativo);
        sb.append('}');
        return sb.toString();
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidade;

import java.sql.*;

/**
 *
 * @author Usuario
 */
public class Pessoa {

    public Integer id;
    public String nome;
    public String senha;
    public String email;
    public String endereco;
    public String telefone;

    public static Pessoa from(ResultSet resultSet) throws SQLException {

        Pessoa p = new Pessoa();

        p.id = (resultSet.getInt("id"));
        p.nome = (resultSet.getString("nome"));
        p.senha = (resultSet.getString("senha"));
        p.email = (resultSet.getString("email"));
        p.endereco = (resultSet.getString("endereco"));
        p.telefone = (resultSet.getString("telefone"));

        return p;
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        sb.append("pessoa{id=").append(id);
        sb.append("', nome='").append(nome);
        sb.append("', senha='").append(senha);
        sb.append("', email='").append(email);
        sb.append("', endereco='").append(endereco);
        sb.append("', telefone='").append(telefone);
        sb.append('}');

        return sb.toString();
    }

}

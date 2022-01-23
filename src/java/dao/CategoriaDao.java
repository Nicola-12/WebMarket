package dao;

import apoio.Database;
import apoio.IDAO;
import entidade.Categoria;
import java.sql.*;
import java.util.ArrayList;

public class CategoriaDao implements IDAO<Categoria>
{

    ResultSet result;

    @Override
    public String save( Categoria cat )
    {
        try
        {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO categoria VALUES"
                    + "(default,"
                    + "'" + cat.descricao + "',"
                    + " now(),"
                    + " now(),"
                    + "'ativo')";

            System.out.println( "SQL: " + sql );

            int resultado = stm.executeUpdate( sql );

            return null;

        }
        catch ( Exception e )
        {
            System.out.println( "Erro ao salvar categoria: " + e );
            return e.toString();
        }
    }

    @Override
    public String update( Categoria categoria )
    {
        String saida = null;

        try
        {
            Statement stm = Database.getInstance().getConnection().createStatement();

            System.out.println( categoria.descricao );
            String sql = "UPDATE categoria"
                    + " SET descricao ='" + categoria.descricao + "',"
                    + "updated_at ='now()'"
                    + "WHERE id = '" + categoria.id + "'";

            int retorno = stm.executeUpdate( sql );

            if ( retorno != 0 )
            {
                saida = null;
            }
            else
            {
                saida = "ERRO";
            }
        }
        catch ( Exception e )
        {
            System.out.println( "Erro ao salvar a categoria: " + e );
            saida = e.toString();
        }

        return saida;
    }

    @Override
    public String remove( int id )
    {
        try
        {
            Statement stm = Database.getInstance().getConnection().createStatement();

            String sql = "UPDATE categoria SET ativo = 'inativo' WHERE id=" + id;
            System.out.println( "SQL: " + sql );

            int resultado = stm.executeUpdate( sql );

            return resultado + "";

        }
        
        catch ( Exception e )
        {
            System.out.println( "Erro ao excluir categoria: " + e );
            return e.toString();
        }
    }

    @Override
    public ArrayList<Categoria> findAll()
    {
        String sql = "SELECT * FROM categoria WHERE ativo = 'ativo'";
        try
        {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery( sql );
            ArrayList<Categoria> categoria = new ArrayList<>();
            while ( result.next() )
            {
                categoria.add( Categoria.from( result ) );
            }
            if ( categoria.isEmpty() )
            {
                return null;
            }
            return categoria;
        }
        catch ( Exception e )
        {
            System.out.println( "Erro ao consultar categoria: " + e );
        }
        return null;
    }

    @Override
    public boolean isUnique( Categoria o )
    {
        throw new UnsupportedOperationException( "Not supported yet." ); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Categoria> getAllByValue( String criterio )
    {
        String sql = "SELECT * FROM categoria WHERE descricao ILIKE '%" + criterio + "%' ORDER BY descricao";
        try
        {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery( sql );
            ArrayList<Categoria> categoria = new ArrayList<>();
            while ( result.next() )
            {
                categoria.add( Categoria.from( result ) );
            }
            if ( categoria.isEmpty() )
            {
                return null;
            }
            return categoria;
        }
        catch ( Exception e )
        {
            System.out.println( "Erro ao consultar categorias: " + e );
        }
        return null;
    }

    @Override
    public Categoria getById( int id )
    {
        String sql = "SELECT * FROM categoria WHERE id=" + id;
        try
        {
            ResultSet result = Database.getInstance().getConnection().createStatement().executeQuery( sql );
            if ( result.next() )
            {
                return Categoria.from( result );
            }

        }
        catch ( Exception e )
        {
            System.out.println( "Erro ao consultar categorias por ID: " + e );
        }
        return null;
    }

    @Override
    public boolean exists( Categoria o )
    {
        throw new UnsupportedOperationException( "Not supported yet." ); //To change body of generated methods, choose Tools | Templates.
    }

}

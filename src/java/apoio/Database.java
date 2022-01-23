package apoio;

import java.sql.*;
import java.util.*;

public class Database
{

    private static Database instance = null;
    private Connection connection = null;

    public Database()
    {
        try
        {
            // Carrega informações do arquivo de propriedades
            Properties prop = new Properties();
            prop.load( getClass().getResourceAsStream( "/apoio/db.properties" ) );
            String dbDriver = prop.getProperty( "db.driver" );
            String dbUrl = prop.getProperty( "db.url" );
            String dbUser = prop.getProperty( "db.user" );
            String dbPassword = "postgres";

            // Carrega Driver do Banco de Dados
            Class.forName( dbDriver );

            if ( dbUser.length() != 0 ) // conexão COM usuário e senha
            {
                connection = DriverManager.getConnection( dbUrl, dbUser, dbPassword );
            }
            else // conexão SEM usuário e senha
            {
                connection = DriverManager.getConnection( dbUrl );
            }

        }
        
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }

    // Retorna instância
    public static Database getInstance()
    {
        if ( instance == null )
        {
            instance = new Database();
        }
        return instance;
    }

    // Retorna conexão
    public Connection getConnection()
    {
        if ( connection == null )
        {
            throw new RuntimeException( "conexao==null" );
        }
        return connection;
    }

    // Efetua fechamento da conexão
    public void shutDown()
    {
        try
        {
            connection.close();
            instance = null;
            connection = null;
        }
        
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }
}

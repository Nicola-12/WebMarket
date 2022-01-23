/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package apoio;

import apoio.Formatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JFormattedTextField;

/**
 *
 * @author Fabricio Pretto
 */
public class Validator
{

    private static final int[] CPF =
    {
        11, 10, 9, 8, 7, 6, 5, 4, 3, 2
    };
    
    private static final int[] CNPJ =
    {
        6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
    };

    /**
     * 
     * @param str String
     * @param weight int[]
     * @return 
     */
    private static int digitCalc( String str, int[] weight )
    {
        int sum = 0;
        for ( int i = str.length() - 1, digit; i >= 0; i-- )
        {
            digit = Integer.parseInt( str.substring( i, i + 1 ) );
            sum += digit * weight[weight.length - str.length() + i];
        }
        sum = 11 - sum % 11;
        return sum > 9 ? 0 : sum;
    }

    /**
     * validateCPF
     * 
     * @param cpf String
     * @return boolean
     */
    public static boolean validateCPF( String cpf )
    {
        if ( ( cpf == null ) || ( cpf.length() != 11 ) )
        {
            return false;
        }
        Integer digit1 = digitCalc( cpf.substring( 0, 9 ), CPF );
        Integer digit2 = digitCalc( cpf.substring( 0, 9 ) + digit1, CPF );
        return cpf.equals( cpf.substring( 0, 9 ) + digit1.toString() + digit2.toString() );
    }

    /**
     * validateCNPJ
     * 
     * @param cnpj String
     * @return boolean
     */
    public static boolean validateCNPJ( String cnpj )
    {
        if ( ( cnpj == null ) || ( cnpj.length() != 14 ) )
        {
            return false;
        }
        Integer digit1 = digitCalc( cnpj.substring( 0, 12 ), CNPJ );
        Integer digit2 = digitCalc( cnpj.substring( 0, 12 ) + digit1, CNPJ );
        return cnpj.equals( cnpj.substring( 0, 12 ) + digit1.toString() + digit2.toString() );
    }

    /**
     * 
     * @param d day
     * @param m month
     * @param y year
     * @return 
     */
    public static boolean validateDateDMA( int d, int m, int y )
    {
        boolean correct = true;
        int[] days =
        {
            31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
        };
        if ( y < 0 || m < 1 || m > 12 )
        {
            correct = false;
        }
        else
        {
            // valida o dia
            if ( y % 4 == 0 && ( y % 100 != 0 || y % 400 == 0 ) )
            {
                days[1] = 29;
            }
            if ( d < 1 || d > days[m - 1] )
            {
                correct = false;
            }
        }
        return ( correct );
    }

    /**
     * 
     * @param dateWithFormat
     * @return 
     */
    public static boolean validarDataFormatada( String dateWithFormat )
    {
        String[] date = dateWithFormat.split( "/" );
        return ( validateDateDMA( Integer.parseInt( date[0] ), Integer.parseInt( date[1] ), Integer.parseInt( date[2] ) ) );
    }

    /**
     * 
     * @param field 
     */
    public static void validarTelefone( JFormattedTextField field )
    {
        if ( field.getText().trim().length() < 14 )
        {
            Formatter.formatFone( field );
        }
    }


    /**
     * 
     * @param email
     * @return 
     */
    public static boolean emailValidator( String email )
    {
        boolean isEmailIdValid = false;
        if ( email != null && email.length() > 0 )
        {
            String expression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
            Pattern pattern = Pattern.compile( expression, Pattern.CASE_INSENSITIVE );
            Matcher matcher = pattern.matcher( email );
            if ( matcher.matches() )
            {
                isEmailIdValid = true;
            }
        }
        return isEmailIdValid;
    }

    /**
     * 
     * @param email
     * @return 
     */
    public static boolean isEmail( String email )
    {
        return email.matches( "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$" );
    }
}

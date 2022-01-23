package apoio;

import java.text.*;
import java.util.Date;
import java.util.Locale;
import javax.swing.*;
import javax.swing.text.*;

public class Formatter
{

    static DecimalFormat df = new DecimalFormat( "#,##0.00", new DecimalFormatSymbols( new Locale( "pt", "BR" ) ) );

    public static JFormattedTextField getFormatado( String format )
    {
        JFormattedTextField campoFormatado = null;
        MaskFormatter formatter = new MaskFormatter();

        formatter.setPlaceholderCharacter( ' ' );
        formatter.setValueContainsLiteralCharacters( false );

        try
        {
            formatter.setMask( format );
            campoFormatado = new JFormattedTextField( formatter );
        }
        
        catch ( ParseException ex )
        {
            ex.printStackTrace();
        }
        return campoFormatado;
    }

    public static void decimalFormat( JTextField field )
    {
        field.setText( df.format( Double.parseDouble( field.getText() ) ) );
    }

    public static String decimalFormat( double value )
    {
        NumberFormat formatter = new DecimalFormat( "###0.00" );
        return ( formatter.format( value ) );
    }

    public static JFormattedTextField getFormattedFone()
    {
        return getFormatado( "(##) ####-####" );
    }

    public static JFormattedTextField getFormattedCNPJ()
    {
        return getFormatado( "##.###.###/####-##" );
    }

    public static JFormattedTextField getFormattedCPF()
    {
        return getFormatado( "###.###.###-##" );
    }

    public static JFormattedTextField getFormattedDate()
    {
        return getFormatado( "##/##/####" );
    }

    public static JFormattedTextField getFormattedDateTime()
    {
        return getFormatado( "##/##/#### ##:##" );
    }

    public void decimalFormatted( JTextField field )
    {
        field.setText( df.format( Double.parseDouble( field.getText() ) ) );
    }

    public static void DateFormat( JFormattedTextField field )
    {
        try
        {
            MaskFormatter m = new MaskFormatter();
            m.setPlaceholderCharacter( ' ' );
            m.setMask( "##/##/####" );
            field.setFormatterFactory( null );
            field.setFormatterFactory( new DefaultFormatterFactory( m ) );
            field.setValue( null );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }

    public static void formatCpf( JFormattedTextField field )
    {
        try
        {
            MaskFormatter m = new MaskFormatter();
            m.setPlaceholderCharacter( ' ' );
            m.setMask( "###.###.###-##" );
            field.setFormatterFactory( null );
            field.setFormatterFactory( new DefaultFormatterFactory( m ) );
            field.setValue( null );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }

    public static void formatCNPJ( JFormattedTextField field )
    {
        try
        {
            MaskFormatter m = new MaskFormatter();
            m.setPlaceholderCharacter( ' ' );
            m.setMask( "##.###.###/####-##" );
            field.setFormatterFactory( null );
            field.setFormatterFactory( new DefaultFormatterFactory( m ) );
            field.setValue( null );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }

    public static void formatFone( JFormattedTextField field )
    {
        try
        {
            MaskFormatter m = new MaskFormatter();
            m.setPlaceholderCharacter( ' ' );
            m.setMask( "(##)####-####" );
            field.setFormatterFactory( null );
            field.setFormatterFactory( new DefaultFormatterFactory( m ) );
            field.setValue( null );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
    }

    public static String formatDateYMD( String date )
    {
        String formattedDate = null;
        try
        {
            Date dateAMD = new SimpleDateFormat( "yyyy-MM-dd" ).parse( date );
            formattedDate = new SimpleDateFormat( "dd/MM/yyyy" ).format( dateAMD );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
        return ( formattedDate );
    }

    public static String formatDateDMY( String date )
    {
        String formattedDate = null;
        try
        {
            Date dateDMA = new SimpleDateFormat( "dd/MM/yyyy" ).parse( date );
            formattedDate = new SimpleDateFormat( "yyyy-MM-dd" ).format( dateDMA );
        }
        catch ( Exception e )
        {
            System.err.println( e );
        }
        return ( formattedDate );
    }

    public static String removerFormatacao( String data )
    {
        String value = "";
        for ( int i = 0; i < data.length(); i++ )
        {
            if ( data.charAt( i ) != '.' && data.charAt( i ) != '/' && data.charAt( i ) != '-' )
            {
                value = value + data.charAt( i );
            }
        }
        return ( value );
    }

    public static String getActualDate()
    {
        Date now = new Date();
        DateFormat df = new SimpleDateFormat( "dd/MM/yyyy" );
        String dateNow = df.format( now );

        return dateNow;
    }

    public static String getActualDateTime()
    {
        Date now = new Date();
        DateFormat df = new SimpleDateFormat( "dd/MM/yyyy HH:mm" );
        String actualDate = df.format( now );

        return actualDate;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apoio;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 *
 * @author Nicolas
 */
public class Cript
{

    public static String encryptPassword( String password )
    {

        try
        {
            return Base64.getEncoder().encodeToString( MessageDigest.getInstance( "SHA-512" ).digest( password.getBytes( StandardCharsets.UTF_8 ) ) );
        }
        catch ( NoSuchAlgorithmException ex )
        {
            return ex.getMessage();
        }
    }

    public static boolean isEquals( String hash, String password )
    {
        String hashPassword = encryptPassword( password );
        if ( hashPassword == null )
        {
            return false;
        }
        return hash.equals( hashPassword );
    }

}

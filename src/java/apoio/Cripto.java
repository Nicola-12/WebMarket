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
 * @author Usuario
 */
public class Cripto {

    public static String criptografar(String senha) {

        try {
            return Base64.getEncoder().encodeToString(MessageDigest.getInstance("SHA-512").digest(senha.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException ex) {
            return null;
        }
    }

    public static boolean eIgual(String hash, String senha) {
        String senhaHash = criptografar(senha);
        if (senhaHash == null) {
            return false;
        }
        return hash.equals(senhaHash);
    }

}

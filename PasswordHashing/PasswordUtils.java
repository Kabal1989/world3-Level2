import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordUtils {

    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hash);
    }

    public static void main(String[] args) throws NoSuchAlgorithmException {
        String password = "op1"; // Alterar conforme necessário
        String hashedPassword = hashPassword(password);
        System.out.println("Hashed and Base64 Encoded Password: " + hashedPassword);
    }
}

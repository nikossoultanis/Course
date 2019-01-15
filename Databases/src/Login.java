
public class Login {
    public static int authenticate(String username, String password) {
        if (username.equals("soultanis") && password.equals("nikos")) {
            return 1;
        }
        else if(username.equals("customer") && password.equals(""))
        {
        	return 2;
        }
        return 0;
    }

}

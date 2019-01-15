import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
 
public class Main {
    public static void main(String[] args) {
        final JFrame frame = new JFrame("Database Login Window");
        final JButton btnLogin = new JButton("Click to login");
        btnLogin.addActionListener(
                new ActionListener(){
                    public void actionPerformed(ActionEvent e) {
                        LoginDialog loginDlg = new LoginDialog(frame);
                        loginDlg.setVisible(true);
                        if(loginDlg.isSucceeded() && loginDlg.getUsername() == "soultanis")
                        	btnLogin.setText("Successfully Logged in Mr. " + loginDlg.getUsername() + "!");
                        else
                            	btnLogin.setText("You logged in as a  " + loginDlg.getUsername() + "!");
                    		  
                        
                    }
                });

 
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 100);
        frame.setLayout(new FlowLayout());
        frame.getContentPane().add(btnLogin);
        frame.setVisible(true);
    }
}
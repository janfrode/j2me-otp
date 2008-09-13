/*
 * MIDlet interface to Harry Mantakos <harry@meretrix.com> OTP (s/key)
 * calculator. 
 *
 * Written by Jan-Frode Myklebust <janfrode@tanso.net>.
 */

import javax.microedition.lcdui.*;
import javax.microedition.midlet.*;

public class jotpMIDlet
    extends MIDlet 
    implements CommandListener {
        otp otpwd;
	TextField PassField, SeqField, ChallengeField;
        int hashalg;
        int seq;
  private Form mMainForm;
  
  public jotpMIDlet() {

	mMainForm = new Form("OneTimePass");
	PassField = new TextField("Password", null, 20, TextField.ANY | TextField.PASSWORD);
	SeqField = new TextField("Sequence", null, 6, TextField.NUMERIC);
	ChallengeField = new TextField("Challenge", null, 10, 0);
	mMainForm.append(PassField);
	mMainForm.append(SeqField);
	mMainForm.append(ChallengeField);
	mMainForm.addCommand(new Command("Calculate", Command.OK, 0));
	mMainForm.addCommand(new Command("Exit", Command.EXIT, 0));
	mMainForm.setCommandListener(this);
  }
  
  public void startApp() {
    Display.getDisplay(this).setCurrent(mMainForm);
  }
  
  public void pauseApp() {}
  
  public void destroyApp(boolean unconditional) {}
  
  public void commandAction(Command c, Displayable s) {
    if ( c.getCommandType() == Command.EXIT ) {
    	notifyDestroyed();
    } 
    if ( c.getCommandType() == Command.OK) {
	seq = new Integer(1).valueOf(SeqField.getString()).intValue();
	otpwd = new otp(seq, ChallengeField.getString(), PassField.getString(), otp.MD5);
	otpwd.calc();
	mMainForm.append(new StringItem(null, otpwd.toString()));
    }
  }


}

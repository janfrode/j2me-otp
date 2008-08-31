
EMULATOR=emulator
PREVERIFY=preverify
JAVAC=javac
JAVA=java

API=/local/j2me/lib/midpapi.zip
JFLAGS=-bootclasspath $(API) -verbose -O

all:			md4.class md5.class otp.class jotpMIDlet.class jotp.jar	

clean:		
	rm -f md4.class md5.class otp.class jotpMIDlet.class jotp.jar 
	rm -rf output

demo:			all
	$(EMULATOR) -Xdescriptor:jotp.jad

preverify:		md4.class md5.class otp.class jotpMIDlet.class
	$(PREVERIFY) -classpath $(API) -cldc md4 md5 otp jotpMIDlet md

jotpMIDlet.class:	jotpMIDlet.java 
	$(JAVAC) $(JFLAGS) jotpMIDlet.java

md5.class:		md.java
	$(JAVAC) $(FFLAGS) md.java

md4.class:		md.java
	$(JAVAC) $(FFLAGS) md.java

otp.class:		md.java otp.java 
	$(JAVAC) $(FFLAGS) otp.java

jotp.jar:		otp.class md5.class jotpMIDlet.class preverify
	mv output/*.class .
	jar cvf jotp.jar otp.class md.class md4.class md5.class jotpMIDlet.class 

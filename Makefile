
EMULATOR=emulator
PREVERIFY=preverify1.0
JAVAC=javac
JAVA=java

API=/usr/local/WTK2.5.2/lib/midpapi10.jar:/usr/local/WTK2.5.2/lib/cldcapi10.jar:.
JFLAGS=-bootclasspath $(API):. -verbose -O -target 1.4 -source 1.4

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
	$(JAVAC) $(JFLAGS) md.java

md4.class:		md.java
	$(JAVAC) $(JFLAGS) md.java

otp.class:		md.java otp.java 
	$(JAVAC) $(JFLAGS) otp.java

jotp.jar:		otp.class md5.class jotpMIDlet.class preverify
	mv output/*.class .
	jar cvfm jotp.jar Manifest otp.class md.class md4.class md5.class jotpMIDlet.class 

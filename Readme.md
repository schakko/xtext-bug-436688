Testcase for Eclipse Bug #436688
================================
I am receiving the error "java.lang.IllegalArgumentException: The type xyz is not on the classpath"

Bug report: https://bugs.eclipse.org/bugs/show_bug.cgi?id=436688

Reproduce
=========
- import the Xtext projects in your Eclipse IDE
- start the Xtext MyDSL environment
- import the /test-fixture.mydsl into a new Java Project
- add javaee-api-6.0.jar to your classpath
- annotation @Entity can be used on "domain MyDomain" but not inside the inferrer

Reproduced in environments
==========================
- Xtext 2.6.x & JDK 1.7.x
- Xtext 2.7.0 & JDK 1.7.x
- Xtext 2.7.0 & JRE 1.8
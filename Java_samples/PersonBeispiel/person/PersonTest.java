package sk.train.person;

public class PersonTest {

	public static void main(String[] args) {

         Person p;
         
         p = new Person();
         
         System.out.println(p.getAlter());
         System.out.println(p.getName());
         
         try {
			p.setAlter(-1);
		} catch (Exception e) {
			System.err.println("Es ist ein Fehler aufgetreten, User-Support benachrichtigen");
		}
        p.setName("Mustermann");
        
        Person p2 = new Person("Karrer", 62);
        
        System.out.println(p2.getName());
        
        p = p2;
        
        System.out.println(p.getAlter());
        p.setName("Meier");
        System.out.println(p2.getName());
        
        System.out.println(p == p2);
        
        Person p3 = new Person("Meier", 62);
        
        System.out.println(p3 == p2);
        
        System.out.println(p3);
        System.out.println(p2);
        System.out.println(p);

	}

}

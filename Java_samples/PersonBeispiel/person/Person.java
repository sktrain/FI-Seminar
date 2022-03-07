package sk.train.person;

public class Person {
	
	private String name = "Musterfrau";
	private int alter = 20;
	
	public Person() {
		super();
	}
	
	

	public Person(String name, int alter) {
		super();
		this.name = name;
		this.alter = alter;
	}



	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAlter() {
		return alter;
	}

	public void setAlter(int alter) {
		if (alter >= 0)		this.alter = alter;
		else throw new RuntimeException("alter darf nicht negativ sein");
	}



	@Override
	public String toString() {
		return "Person [name=" + name + ", alter=" + alter + "]";
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + alter;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Person other = (Person) obj;
		if (alter != other.alter)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	
	

}

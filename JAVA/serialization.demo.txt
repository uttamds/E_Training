import java.io.*;

// A simple class implementing Serializable
class Student implements Serializable {
    private static final long serialVersionUID = 1L; // good practice
    private String name;
    private int age;

    // Constructor
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // toString method for printing
    @Override
    public String toString() {
        return "Student{name='" + name + "', age=" + age + "}";
    }
}

public class SerializationDemo {
    public static void main(String[] args) {
        String filename = "student.ser"; // persistent storage (file)

        // Create an object
        Student s1 = new Student("Rahul", 21);

        // ------------ Serialization (Writing object to file) ------------
        try (ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(filename))) {
            out.writeObject(s1);
            System.out.println("Object has been serialized to " + filename);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // ------------ Deserialization (Reading object from file) ------------
        try (ObjectInputStream in = new ObjectInputStream(new FileInputStream(filename))) {
            Student s2 = (Student) in.readObject();
            System.out.println("Object has been deserialized: " + s2);
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
